;;; weather-metno.el --- Weather data from met.no in Emacs -*- lexical-binding: t -*-

;; Copyright (C) 2012-2014, 2025 Rüdiger Sonderfeld <ruediger@c-plusplus.de> et al.

;; Author: Rüdiger Sonderfeld <ruediger@c-plusplus.de> et al.
;; URL: https://codeberg.org/tta/weater-metno.el
;; Package-Requires: ((emacs "29"))
;; Keywords: comm

;; This file is NOT part of GNU Emacs.

;; SPDX-License-Identifier: GPL-3.0-or-later

;; weather-el is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; weather-el is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with weather-el.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; Weather data from met.no in Emacs.

;; See http://api.met.no/weatherapi/documentation
;; and http://api.met.no/license_data.html

;;; Code:

(require 'calendar)
(require 'cl-lib)
(require 'files)
(require 'lunar)
(require 'solar)
(require 'time-date)
(require 'timezone)
(require 'url)
(require 'url-cache)
(require 'vtable)
(require 'xml)

(require 'weather-metno-query)

(defgroup weather-metno nil
  "Weather data from met.no in Emacs."
  :prefix "weather-metno-"
  :group 'comm)

(defun weather-metno--get-default-location-longitude ()
  "Find default location latitude."
  (cond
   ((boundp 'user-location-longitude)
    user-location-longitude)
   ((and (boundp 'calendar-longitude)
         (or (numberp calendar-longitude)
             (vectorp calendar-longitude))
         (calendar-longitude)))
   (t 0)))

(defun weather-metno--get-default-location-latitude ()
  "Find default location latitude."
  (cond
   ((boundp 'user-location-latitude)
    user-location-latitude)
   ((and (boundp 'calendar-latitude)
         (or (numberp calendar-latitude)
             (vectorp calendar-latitude))
         (calendar-latitude)))
   (t 0)))

(defun weather-metno--get-default-location-name ()
  "Find default location name."
  (if (boundp 'user-location-name)
      user-location-name
    (if (boundp 'calendar-location-name)
        (let ((calendar-longitude (weather-metno--get-default-location-longitude))
              (calendar-latitude (weather-metno--get-default-location-latitude)))
          (eval calendar-location-name))
      "")))

(defcustom weather-metno-search-server
  "https://nominatim.openstreetmap.org"
  "Server used to search for location names.
The server must offer the nominatim.org API."
  :type 'string)

(defcustom weather-metno-location-name
  (weather-metno--get-default-location-name)
  "Name of the default weather location.
See `weather-metno-location-latitude', `weather-metno-location-longitude', and
`weather-metno-location-msl'."
  :group 'weather-metno
  :type 'string)

(defcustom weather-metno-location-latitude
  (weather-metno--get-default-location-latitude)
  "Latitude of `weather-metno-location-name' in degrees.
See `weather-metno-location-longitude' and `weather-metno-location-msl'."
  :group 'weather-metno
  :type '(number :tag "Exact"))

(defcustom weather-metno-location-longitude
  (weather-metno--get-default-location-longitude)
  "Longitude of `weather-metno-location-name' in degrees.
See `weather-metno-location-latitude' and `weather-metno-location-msl'."
  :group 'weather-metno
  :type '(number :tag "Exact"))

(defcustom weather-metno-location-msl nil
  "Whole meters above sea level of `weather-metno-location-name' in degrees.
See `weather-metno-location-latitude' and `weather-metno-location-msl'."
  :group 'weather-metno
  :type '(choice (const nil)
                 (number :tag "Exact")))

(defcustom weather-metno-format-time-string "%H:%M"
  "Format string used to format time data.
See `format-time-string' for a description of the format."
  :group 'weather-metno
  :type 'string)

(defcustom weather-metno-format-date-string "%A %Y-%m-%d"
  "Format string used to format a date.
See `format-time-string' for a description of the format."
  :group 'weather-metno
  :type 'string)

(defcustom weather-metno-weathericons-directory
  'ask
  "Weathericons directory.  When nil and using graphical display, user
will be queried for directory to save weathericons, and the directory will be
saved here.  Setting it to `disabled' prevents from asking the directory and
disables weathericons."
  :type '(choice
          (const :tag "Ask" ask)
          (const :tag "Disabled" nil)
          (string :tag "Directory"))
  :group 'weather-metno)

(defconst weather-metno-url "https://api.met.no/weatherapi/"
  "URL to api.met.no.")

(defconst weather-metno-weathericon-version "1.1"
  "Version of weathericon.")

(defconst weather-metno-forecast-version "2.0"
  "Version of locationforecast.")

(defconst weather-metno-logo "met-no.png"
  "File name of the met.no logo.")

(defvar weather-metno-symbol--storage nil
  "Symbol cache.")

(defcustom weather-metno-display-function #'weather-metno-forecast-list-view
  "Function to display the forecast."
  :type `(choice
          (function-item
           ,#'weather-metno-forecast-list-view)
          (function-item
           ,#'weather-metno-forecast-tabular-view)))

(defun weather-metno-clear-symbol-cache ()
  (interactive)
  (setq weather-metno-symbol--storage nil))

(defun weather-metno--symbol-cache-insert (symbol icon &optional content-type)
  "Store SYMBOL ICON in cache."
  (setq weather-metno-symbol--storage (append weather-metno-symbol--storage
                                              (list (cons (list icon content-type) symbol)))))

(defun weather-metno--symbol-cache-fetch (icon &optional content-type)
  "Fetch ICON from cache."
  (cdr (assoc (list icon content-type) weather-metno-symbol--storage)))

(defun weather-metno--weathericon-url (icon &optional content-type)
  "Create URL to get ICON from the weathericon API."
  (format "file:%s/%s.png" weather-metno-weathericons-directory icon))

(defcustom weather-metno-get-image-props '(:scale 0.25)
  "Image props for weather symbols.
See `create-image' or \"(elisp) Images\" for an explanation.

Example: (:width 16 :height 16 :ascent center) to force icons to be 16x16. This
only works if ImageMagick is used.  See `weather-metno-use-imagemagick'."
  :group 'weather-metno
  :type 'sexp)

(defcustom weather-metno-use-imagemagick (fboundp 'imagemagick-types)
  ;; TODO is there a better way to identify if emacs has imagemagick support?
  "Use ImageMagick to load images.
ImageMagick is required for some image options such as resizing.
See `weather-metno-get-image-props'."
  :group 'weather-metno
  :type 'boolean)

(defconst weather-metno--table-view-query
  '(:get minTemperature :name min-temperature :select value :each string-to-number :min
         :get maxTemperature :name max-temperature :select value :each string-to-number :max
         :get minTemperature :name min-temperature-avg :select value :each string-to-number :reduce weather-metno~q-avg
         :get maxTemperature :name max-temperature-avg :select value :each string-to-number :reduce weather-metno~q-avg
         :get precipitation :name precipitation-min :select value :each string-to-number :min
         :get precipitation :name precipitation-max :select value :each string-to-number :max
         :get symbol :select code :name symbol :reduce weather-metno--most-frequent-element
         :get windSpeed :name wind-speed :select mps :each string-to-number :max
         :get windGust :name wind-gust :select mps :each string-to-number :max
         :get windDirection :name wind-direction-symbol :select name :each weather-metno--wind-direction
         :reduce weather-metno--most-frequent-element)
  "Items to query from forecast data.")

(defun weather-metno--get-image (icon content-type)
  "Extract image from current-buffer."
  (goto-char (point-min))
  (unless (search-forward "\n\n" nil t)
    (kill-buffer)
    (error "Error in http reply"))
  (url-store-in-cache (current-buffer))
  (let ((image (apply #'create-image (buffer-substring (point) (point-max))
                      (if weather-metno-use-imagemagick
                          'imagemagick
                        (if content-type nil 'png))
                      t weather-metno-get-image-props)))
    (weather-metno--symbol-cache-insert image icon   content-type)
    (kill-buffer)
    image))

(defun weather-metno--do-insert-weathericon (_status buffer point icon
                                                     content-type)
  "Insert image in BUFFER at POINT.
This is used by `weather-metno-insert-weathericon' as handler."
  (save-excursion
    (let ((image (weather-metno--get-image icon   content-type)))
      (with-current-buffer buffer
        (put-image image point)))))

(defvar weather-metno-symbol-expire-time 86400
  "Expire time for symbols in seconds.
See `url-cache-expire-time'.  Default is 24h (86400s).")

(defun weather-metno-insert-weathericon (buffer point icon &optional
                                                content-type expire-time)
  "Fetch the weather ICON and insert it into BUFFER at POINT.
This function works asynchronously.  If NIGHTP is set then a night icon will be
fetched.  If POLARP then an icon for a polarday will be fetched.  CONTENT-TYPE
specifies the content-type (default image/png).

Does nothing if weathericon directory is not set.

This uses the met.no weathericon API
http://api.met.no/weatherapi/weathericon/1.0/documentation

The data is available under CC-BY-3.0."
  (when (stringp weather-metno-weathericons-directory)
    (let ((symbol (weather-metno--symbol-cache-fetch icon   content-type)))
      (if symbol
          (put-image symbol point)
        (let* ((url (weather-metno--weathericon-url icon
                                                    content-type))
               (expire-time2 (or expire-time
                                 weather-metno-symbol-expire-time))
               (expired (if expire-time2
                            (url-cache-expired url expire-time2)
                          t)))
          (if (not expired)
              (with-current-buffer (url-fetch-from-cache url)
                (weather-metno--do-insert-weathericon nil buffer point icon   content-type))
            (url-retrieve
             url
             'weather-metno--do-insert-weathericon
             (list buffer point icon   content-type))))))))

(defun weather-metno-get-weathericon (icon &optional   content-type
                                           expire-time)
  "Fetch the weather ICON and return it.
Fetch is done synchronously.  Use `weather-metno-insert-weathericon' if you just
want to insert the icon into a buffer.

The data is available under CC-BY-3.0."
  (when (stringp weather-metno-weathericons-directory)
    (let ((symbol (weather-metno--symbol-cache-fetch icon   content-type)))
      (if symbol
          symbol
        (let* ((url (weather-metno--weathericon-url icon
                                                    content-type))
               (expire-time2 (or expire-time
                                 weather-metno-symbol-expire-time))
               (expired (if expire-time2
                            (url-cache-expired url expire-time2)
                          t)))
          (if (not expired)
              (with-current-buffer (url-fetch-from-cache url)
                (weather-metno--get-image icon   content-type))
            (with-current-buffer (url-retrieve-synchronously url)
              (weather-metno--get-image icon   content-type))))))))

(defun weather-metno--parse-time-string (time-string)
  "Parse a RFC3339 compliant TIME-STRING.
This function is similar to `decode-time' but works with RFC3339 (ISO 8601)
compatible timestamps.  Except for fractional seconds! Thanks to tali713."
  (require 'timezone)
  (cl-destructuring-bind (year month day time zone)
      (append (timezone-parse-date time-string) nil)
    `(,@(cl-subseq (parse-time-string time) 0 3)
      ,(string-to-number day)
      ,(string-to-number month)
      ,(string-to-number year)
      nil
      nil
      ,(if zone
           (mod (* 60
                   (timezone-zone-to-minute
                    (replace-regexp-in-string ":" "" zone)))
                (* 3600 24))
         (car (current-time-zone))))))

(defun weather-metno--forecast-url (lat lon &optional msl)
  "Create the url from LAT, LON and MSL to be used by `weather-metno-forecast'."
  (concat (format "%slocationforecast/%s/classic?lat=%s&lon=%s"
                  weather-metno-url weather-metno-forecast-version lat lon)
          (if msl
              (format "&msl=%s" msl)
            "")))

(defun weather-metno--date-to-time (x)
  "Convert RFC3339 string X to Emacs's time format.
Emacs's time format is (HIGH LOW . IGNORED)."
  (apply 'encode-time (weather-metno--parse-time-string x)))

(defun weather-metno--calendar-to-emacs-date (date)
  "Return the current time with hours, seconds and minutes set to zero."
  (encode-time 0 0 0 (nth 1 date) (nth 0 date) (nth 2 date)))

(defun weather-metno--add-hours-to-datetime (date hours)
  "Add hours to a date."
  (encode-time (decoded-time-add
                (decode-time date)
                (make-decoded-time :hour hours))))

(defun weather-metno--forecast-convert (xml)
  "Convert the XML structure from met.no to an internal format.
Internal format is ((COORD ((DATE-RANGE) (ENTRY0) (ENTRY1) ...))).
COORD is (LAT LON ALT).
DATE-RANGE is (FROM TO) with FROM and TO in Emacs's time format.
ENTRY is (TYPE (ATTRIBUTES))."
  (let (res)
    (dolist (i
             (xml-node-children (car (xml-get-children
                                      (car xml)
                                      'product))))
      ;; iterator over all <time> entries
      (when (and (consp i) (eq (car i) 'time))
        ;; extract from,to attributes
        (let ((from (weather-metno--date-to-time
                     (xml-get-attribute i 'from)))
              (to (weather-metno--date-to-time
                   (xml-get-attribute i 'to))))

          ;; iterator over <location> entries
          (dolist (loc (xml-get-children i 'location))

            (let* ((coord (list
                           (xml-get-attribute-or-nil loc 'latitude)
                           (xml-get-attribute-or-nil loc 'longitude)
                           (xml-get-attribute-or-nil loc 'altitude)
                           )) ;; Coord: (lat lon alt)
                   (entry (assoc coord res))
                   (date-range (list from to))
                   (forecast (assoc date-range (cdr entry))))
              (unless entry
                (setq entry (list coord))
                (setq res (append res (list entry))))

              (unless forecast
                (setq forecast (list date-range))
                (setcdr entry (list (append (cadr entry)
                                            (list forecast)))))


              (dolist (fcast (xml-node-children loc))
                (when (consp fcast)
                  (setcdr forecast
                          (append (cdr forecast)
                                  (list
                                   (list (xml-node-name fcast)
                                         (xml-node-attributes fcast))))))))))))
    res))

(defun weather-metno-forecast-receive (callback lat lon &optional msl raw-xml)
  "Fetch weather forecast from met.no for LAT LON (MSL).
CALLBACK is called when the request is completed.  CALLBACK gets called with
 (LAT LON MSL RAW-XML DATA) as arguments.  DATA is the received data in the
format described in `weather-metno--forecast-convert'.  Unless RAW-XML is set in
which case DATA is simply the result of `xml-parse-region'.

See http://api.met.no/weatherapi/locationforecast/1.8/documentation for the
documentation of the web API."
  (let ((url (weather-metno--forecast-url lat lon msl)))
    (url-retrieve url
                  (lambda (_status callback lat lon msl)
                    (save-excursion
                      (goto-char (point-min))
                      (unless (search-forward "\n\n" nil t)
                        (kill-buffer)
                        (error "Error in http reply"))
                      (let ((headers (buffer-substring (point-min) (point))))
                        (unless (string-match-p
                                 (concat "^HTTP/1.1 "
                                         "\\(200 OK\\|203 "
                                         "Non-Authoritative Information\\)")
                                 headers)
                          (kill-buffer)
                          (error "Unable to fetch data"))
                        (url-store-in-cache (current-buffer))

                        (let ((xml (xml-parse-region (point) (point-max))))
                          (kill-buffer)
                          (funcall callback lat lon msl raw-xml
                                   (if raw-xml
                                       xml
                                     (weather-metno--forecast-convert xml)))))))
                  (list callback lat lon msl))))

(defun weather-metno--string-empty? (x)
  "Return non-nil when X is either nil or empty string."
  (or (string= x "") (not x)))

(defun weather-metno--format-with-loc (x)
  "Convert X into a minibuffer query string."
  (if (weather-metno--string-empty?
       weather-metno-location-name)
      (concat x ": ")
    (format "%s [Default for %s]: " x weather-metno-location-name)))

(defun weather-metno--n2s (n)
  "Convert N from number to string or nil if not a number."
  (if (numberp n)
      (number-to-string n)))

(defcustom weather-metno-table-buffer-name "*Weather (table)*"
  "Name for the tabular view buffer."
  :group 'weather-metno
  :type 'string)

(defcustom weather-metno-list-buffer-name "*Weather (list)*"
  "Name for the list view buffer."
  :group 'weather-metno
  :type 'string)

(defun weather-metno-buffer-name ()
  "Returns the name for the forecast buffer."
  (if (equal weather-metno-display-function 'weather-metno-forecast-tabular-view)
      weather-metno-table-buffer-name
    weather-metno-list-buffer-name))

(defface weather-metno-header
  '((t :inherit header-line))
  "Face for top header line."
  :group 'weather-metno)

(defface weather-metno-date
  '((t :inherit header-line))
  "Face for date line."
  :group 'weather-metno)

(defface weather-metno-date-range
  '((t :inherit font-lock-function-name-face))
  "Face for date range line."
  :group 'weather-metno)

(defface weather-metno-entry
  '((t :inherit font-lock-variable-name-face))
  "Face for entry."
  :group 'weather-metno)

(defface weather-metno-lunar-phase
  '((t :inherit font-lock-comment-face))
  "Face for entry."
  :group 'weather-metno)

(defface weather-metno-footer
  '((t :inherit font-lock-comment-face))
  "Face for footer."
  :group 'weather-metno)

(defun weather-metno--insert (face &rest args)
  "Insert ARGS into current buffer with FACE."
  (insert (propertize (apply 'concat args) 'face face)))

(defcustom weather-metno-unit-name '(("celsius" . "℃"))
  "Table to translate unit names.
This can NOT be used to convert units!"
  :group 'weather-metno
  :options '("celsius")
  :type '(alist :key-type string :value-type string))

(defun weather-metno--unit-name (unit)
  "Change UNIT to a better name."
  (or (cdr (assoc unit weather-metno-unit-name))
      unit))

(defun weather-metno--format-value-unit (name attributes)
  "Helper to format entries that contain UNIT and VALUE.
E.g. temperature, pressure, precipitation, ..."
  (format "%s %s%s"
          name
          (cdr (assq 'value attributes))
          (weather-metno--unit-name (cdr (assq 'unit attributes)))))

(defun weather-metno--format--precipitation (attributes _)
  "Format precipitation."
  (weather-metno--format-value-unit "Precipitation" attributes))

(defun weather-metno--format--temperature (attributes _)
  "Format temperature."
  (weather-metno--format-value-unit "Temperature" attributes))

(defun weather-metno--format--dewpointTemperature (attributes _)
  "Format dew point temperature."
  (weather-metno--format-value-unit "Dew point" attributes))

(defun weather-metno--format--minTemperature (attributes _)
  "Format minimum temperature."
  (weather-metno--format-value-unit "Minimum temperature" attributes))

(defun weather-metno--format--maxTemperature (attributes _)
  "Format maximum temperature."
  (weather-metno--format-value-unit "Maximum temperature" attributes))

(defun weather-metno--format--pressure (attributes _)
  "Format pressure."
  (weather-metno--format-value-unit "Pressure" attributes))

(defun weather-metno--format--humidity (attributes _)
  "Format humidity."
  (weather-metno--format-value-unit "Humidity" attributes))

(defun weather-metno--format--windDirection (attributes _)
  "Format wind direction."
  (format "Wind direction %s° (%s)"
          (cdr (assq 'deg attributes))
          (cdr (assq 'name attributes))))

(defcustom weather-metno-translate-wind-name
  '(("Stille" . "Calm")                ; 0  beaufort scale
    ("Flau vind" . "Light air")        ; 1
    ("Svak vind" . "Light breeze")     ; 2
    ("Lett bris" . "Gentle breeze")    ; 3
    ("Laber bris" . "Moderate breeze") ; 4
    ("Frisk bris" . "Fresh breeze")    ; 5
    ("Liten kuling" . "Strong breeze") ; 6
    ("Stiv kuling" . "High wind")      ; 7
    ("Sterk kuling" . "Fresh gale")    ; 8
    ("Liten storm" . "Strong gale")    ; 9
    ("Full storm" . "Storm")           ; 10
    ("Sterk storm" . "Violent storm")  ; 11
    ("Orkan" . "Hurricane"))           ; 12
  "Table to translate wind names from Norwegian."
  :group 'weather-metno
  :options '("Stille" "Flau vind" "Svak vind" "Lett bris"
             "Laber bris" "Frisk bris" "Liten kuling"
             "Stiv kuling" "Sterk kuling" "Liten storm" "Full storm"
             "Sterk storm" "Orkan")
  :type '(alist :key-type string :value-type string))

(defun weather-metno--translate-wind-name (name)
  "Translate NAME from Norwegian."
  (cdr (assoc name weather-metno-translate-wind-name)))

(defun weather-metno--format--windSpeed (attributes _)
  "Format wind speed."
  (format "Wind speed %s m/s (Beaufort scale %s) %s"
          (cdr (assq 'mps attributes))
          (cdr (assq 'beaufort attributes))
          (weather-metno--translate-wind-name (cdr (assq 'name attributes)))))

(defun weather-metno--format--windGust (attributes _)
  "Format wind gust."
  (format "Wind gust %s m/s"
          (cdr (assq 'mps attributes))))

(defun weather-metno--format--cloudiness (attributes _)
  "Format cloudiness."
  (format "Cloudiness %s%%"
          (cdr (assq 'percent attributes))))

(defun weather-metno--format--fog (attributes _)
  "Format fog."
  (format "Fog %s%%"
          (cdr (assq 'percent attributes))))

(defun weather-metno--format--lowClouds (attributes _)
  "Format low clouds."
  (format "Low clouds %s%%"
          (cdr (assq 'percent attributes))))

(defun weather-metno--format--mediumClouds (attributes _)
  "Format medium clouds."
  (format "Medium clouds %s%%"
          (cdr (assq 'percent attributes))))

(defun weather-metno--format--highClouds (attributes _)
  "Format high clouds."
  (format "High clouds %s%%"
          (cdr (assq 'percent attributes))))

(defun weather-metno--format--symbol (attributes last-headline)
  "Format symbol."
  (weather-metno-insert-weathericon
   (current-buffer) last-headline
   (cdr (assq 'code attributes)))
  "")

;; Todo the last-headline thing sucks. Find something better!
(defun weather-metno--format-entry (entry &optional last-headline)
  "Format ENTRY.
LAST-HEADLINE should point to the place where icons can be inserted."
  (let ((formatter (intern (concat "weather-metno--format--"
                                   (symbol-name (car entry))))))
    (if (fboundp formatter)
        (funcall formatter (cadr entry) last-headline)
      (format "Unknown entry %s" entry))))


(defconst weather-metno-forecast--table-column-descriptions
  '("Time" "" "Temperature" "Avg" "Precipitation" "Wind speed/gusts" "Wind direction")
  "Headers for the weather table.")

(defconst weather-metno--wind-direction-map
  '((S . #x2191) (N . #x2193) (SW . #x2196) (SE . #x2197) (NW . #x2199) (NE . #x2198) (E . #x2192) (W . #x2190))
  "Character symbols used to indicate wind direction.")

(defconst weather-metno--condensed-forecast-format
  "{symbol|:symbol}={min-temperature} – {max-temperature} ℃={min-temperature-avg} – {max-temperature-avg} ℃={precipitation-min} – {precipitation-max} ㎜={wind-speed} ({wind-gust}) m/s={wind-direction-symbol}"
  "String used to format each query result.")

(defun weather-metno~q-avg (x)
  "Calculate average of X, round to one decimal."
  (/ (round (* 10 (/ (apply #'+ x)
                     (length x)))) 10.0))

(defun weather-metno-tabular-view--f-symbol (code)
  "Format symbol."
  (let* ((image (if (and (stringp weather-metno-weathericons-directory)
                         (display-images-p))
                    (weather-metno-get-weathericon code)
                  nil)))
    (if image
        (propertize code
                    'display (append image '(:ascent center :margin 4))
                    'rear-nonsticky '(display))
      "")))

(defun weather-metno--most-frequent-element (lst)
  "Return the most frequent element in a list."
  (let ((hash-table (make-hash-table :test 'equal))
        most-frequent
        max-count)
    ;; Count occurrences
    (dolist (item lst)
      (puthash item (1+ (gethash item hash-table 0)) hash-table))
    ;; Find the most frequent element
    (maphash (lambda (key value)
               (when (or (not max-count) (> value max-count))
                 (setq max-count value
                       most-frequent key)))
             hash-table)
    most-frequent))

(defun weather-metno--wind-direction (str)
  "Return a unicode symbol to indicate wind direction."
  (char-to-string (cdr (assq (intern str) weather-metno--wind-direction-map))))

(defun weather-metno--transpose-2d-list (matrix)
  "Convert columns to rows and vice versa."
  (apply 'cl-mapcar 'list matrix))

(defun weather-metno--switch-to-forecast-buffer ()
  (interactive)
  (switch-to-buffer (weather-metno-buffer-name)))

(defun weather-metno-kill-forecast-buffer ()
  (interactive)
  (kill-buffer (current-buffer)))

(defun weather-metno-forecast-backward-date ()
  (interactive)
  (re-search-backward "^\\* " nil 'move))

(defun weather-metno-forecast-forward-date ()
  (interactive)
  (re-search-forward "^\\* " nil 'move))

(defun weather-metno-forecast-backward-time ()
  (interactive)
  (re-search-backward "^\\*\\* " nil 'move))

(defun weather-metno-forecast-forward-time ()
  (interactive)
  (re-search-forward "^\\*\\* " nil 'move))

(defvar weather-metno-forecast-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map "s" 'weather-metno-forecast-search-location)
    (define-key map "t" 'weather-metno-forecast-tabular-view)
    (define-key map "l" 'weather-metno-forecast-list-view)
    (define-key map "p" 'weather-metno-forecast-backward-time)
    (define-key map "n" 'weather-metno-forecast-forward-time)
    (define-key map "P" 'weather-metno-forecast-backward-date)
    (define-key map "N" 'weather-metno-forecast-forward-date)
    (define-key map "q" 'weather-metno-kill-forecast-buffer)
    (define-key map "g" 'weather-metno-update)
    map)
  "Keymap for `weather-metno-forecast-mode'.")

(eval-when-compile (require 'easymenu))
(easy-menu-define weather-metno-forecast-mode weather-metno-forecast-mode-map
  "Menu for Weather Metno Forecast."
  '("Weather"
    ["Backward Time" weather-metno-forecast-backward-time
     :help "Go to previous date"]
    ["Forward Time" weather-metno-forecast-forward-time
     :help "Go to next date"]
    ["Backward Date" weather-metno-forecast-backward-date
     :help "Go to previous date"]
    ["Forward Date" weather-metno-forecast-forward-date
     :help "Go to next date"]
    "---"
    ["Table View" weather-metno-forecast-tabular-view
     :help "View forecast as a table"]
    ["List View" weather-metno-forecast-list-view
     :help "View forecast as a list"]
    "---"
    ["Update" weather-metno-update
     :help "Fetch new data from met.no"]
    ["Quit" weather-metno-kill-forecast-buffer
     :help "Quit"]))

(define-derived-mode weather-metno-forecast-mode special-mode
  "metno-forecast"
  "Major mode for showing weather forecasts.
\\{weather-metno-forecast-mode-map}"
  :group 'weather-metno)

(defvar weather-metno--data nil
  "Weather data cache.")
(defvar weather-metno--location nil
  "Location for `weather-metno--data' cache.") ;; TODO this can be extracted from the data!

;; TODO: if the buffer layouts get messed on weather-metno-update, just remove no-switch
;; functionality altogether
(defun weather-metno--refresh-buffer (buffer-to-refresh no-switch)
  "Refresh buffer contents.  If current buffer is one of weather-metno buffers,
refresh that, otherwise refresh the default buffer."
  (cond
   ((string= buffer-to-refresh weather-metno-table-buffer-name)
    (weather-metno-forecast-tabular-view no-switch))
   ((string= buffer-to-refresh weather-metno-list-buffer-name)
    (weather-metno-forecast-list-view no-switch))
   (t
    (funcall weather-metno-display-function no-switch))))

;;;###autoload
(defun weather-metno-update (&optional lat lon msl)
  "Update weather data."
  (interactive)
  (let ((buffer-to-refresh (buffer-name)))
    (weather-metno-forecast-receive
     (lambda (lat lon msl raw-xml data)
       (cl-assert (not raw-xml))
       (setq weather-metno--location (list lat lon msl))
       (setq weather-metno--data data)
       (weather-metno--refresh-buffer buffer-to-refresh t))
     (or lat weather-metno-location-latitude)
     (or lon weather-metno-location-longitude)
     (or msl weather-metno-location-msl))))

(defun weather-metno--location-format (lat lon &optional msl)
  "Format LAT LON MSL into a string."
  ;; The multiplication is to make the comparison only for the first 5 decimals
  (if (and (= (round (* 10000 (string-to-number lat)))
              (round (* 10000 weather-metno-location-latitude)))
           (= (round (* 10000 (string-to-number lon)))
              (round (* 10000 weather-metno-location-longitude))))
      weather-metno-location-name
    (format "location %s,%s %s" lat lon msl)))

(defun weather-metno--time-to-date (time)
  "Convert TIME in Emacs's time format to a date in calendar format."
  (let ((d (decode-time time)))
    (list (nth 4 d) (nth 3 d) (nth 5 d))))

;;;###autoload
(defun weather-metno-forecast-list-view (&optional no-switch)
  "Display weather forecast in list format.
If NO-SWITCH is non-nil then do not switch to weather forecast buffer."
  (interactive)
  (setq weather-metno-display-function #'weather-metno-forecast-list-view)
  (unless weather-metno--data
    (weather-metno-update))
  (with-current-buffer (get-buffer-create (weather-metno-buffer-name))
    (save-excursion
      (let ((inhibit-read-only t))
        (remove-images (point-min) (point-max))

        (weather-metno-forecast-mode)
        (erase-buffer)
        (goto-char (point-min))
        (dolist (location weather-metno--data)
          (weather-metno--insert 'weather-metno-header
                                 (concat "Forecast for "
                                         (weather-metno--location-format
                                          (caar location) (cl-cadar location)
                                          (cl-caddar location))
                                         "\n"))

          (let ((last-date '(1 1 1)))
            (dolist (forecast (cadr location))
              (let* ((date-range (car forecast))
                     (from (car date-range))
                     (to (cadr date-range))
                     (date (weather-metno--time-to-date to))
                     last-headline)

                (unless (calendar-date-equal date last-date)
                  (weather-metno--insert
                   'weather-metno-date
                   "* For "
                   (format-time-string weather-metno-format-date-string to)
                   "\n"))
                (setq last-date date)

                (let ((from-string (format-time-string
                                    weather-metno-format-time-string
                                    from)))
                  (if (equal from to)
                      (weather-metno--insert 'weather-metno-date-range
                                             "** " from-string)
                    (weather-metno--insert 'weather-metno-date-range
                                           "** "
                                           from-string
                                           "–"
                                           (format-time-string
                                            weather-metno-format-time-string
                                            to))))
                (setq last-headline (point))
                (insert "\n")

                (dolist (entry (cdr forecast))
                  (let ((fmt-entry (weather-metno--format-entry entry last-headline)))
                    (unless (weather-metno--string-empty? fmt-entry)
                      (weather-metno--insert 'weather-metno-entry
                                             "*** " fmt-entry "\n"))
                    ))
                )))
          )
        (insert "\n")
        (when (file-exists-p weather-metno-logo)
          (insert-image-file weather-metno-logo))
        (weather-metno--insert
         'weather-metno-footer
         "Data from The Norwegian Meteorological Institute (CC BY 3.0)\n" ;; TODO link!
         )))
    (goto-char (point-min)))
  (unless no-switch
    (weather-metno--switch-to-forecast-buffer)))


(defun weather-metno--get-forecast-for-day (date)
  "Format forecast data for a date, splitting it into 6 hour chunks."
  (let ((ret nil))
    (dotimes (day-segment 4)
      (let* ((emacs-date (weather-metno--calendar-to-emacs-date date))
             (hour (* day-segment 6))
             (start-time (weather-metno--add-hours-to-datetime emacs-date hour))
             (end-time (weather-metno--add-hours-to-datetime start-time 6)))
        (when-let* ((query-data (eval `(weather-metno-query-by-hour
                                        (weather-metno--data nil ',start-time ',end-time)
                                        ,@weather-metno--table-view-query))))
          (let ((time-string (format "%s – %s"
                                     (format-time-string weather-metno-format-time-string start-time)
                                     (format-time-string weather-metno-format-time-string end-time)))
                (formatted-query (split-string (weather-metno-query-format
                                                weather-metno--condensed-forecast-format
                                                query-data
                                                nil
                                                "weather-metno-tabular-view--f-" "?")
                                               "=")))
            (push time-string formatted-query)
            (push formatted-query ret)))))
    (nreverse ret)))

(defun weather-metno--insert-lunar-phase-info (day)
  "Insert lunar phase information in the buffer."
  (let* ((month-year (list (car day)
                           (nth 2 day)))
         (phases (apply 'lunar-phase-list month-year)))
    (dolist (phase phases)
      (if (equal (car phase) day)
          (let ((eclipse (nth 3 phase)))
            (weather-metno--insert 'weather-metno-lunar-phase
                                   (format "%s\n"
                                           (concat (lunar-phase-name (nth 2 phase)) " "
                                                   (cadr phase) (unless (string-empty-p eclipse) " ")
                                                   eclipse))))))))

;;;###autoload
(defun weather-metno-forecast-tabular-view (&optional no-switch)
  "Display weather forecast, sunrise and sunset times, and lunar phases in
tabular format.  If NO-SWITCH is non-nil then do not switch to weather forecast
buffer."
  (interactive)
  (setq weather-metno-display-function #'weather-metno-forecast-tabular-view)
  (if (not weather-metno--data)
      (weather-metno-update)
    (with-current-buffer (get-buffer-create (weather-metno-buffer-name))
      (let ((inhibit-read-only t))
        (remove-images (point-min) (point-max))
        (weather-metno-forecast-mode)
        (setq-local truncate-lines t)
        (erase-buffer)
        (goto-char (point-min))
        (weather-metno--insert 'weather-metno-header
                               (concat "Forecast for "
                                       (apply 'weather-metno--location-format (caar weather-metno--data))) "\n")
        (dotimes (day 10)
          (let* ((current-day (calendar-current-date day))
                 (day-data (weather-metno--get-forecast-for-day current-day)))
            (let ((calendar-latitude (string-to-number (nth 0 (caar weather-metno--data))))
                  (calendar-longitude (string-to-number (nth 1 (caar weather-metno--data))))
                  (time-string (format-time-string
                                weather-metno-format-date-string
                                (weather-metno--calendar-to-emacs-date current-day))))
              (weather-metno--insert 'weather-metno-entry
                                     (format "\n%s: %s\n%s"
                                             time-string
                                             (solar-sunrise-sunset-string current-day t)
                                             (make-string (+ (string-width time-string) 2) ? )))
              (weather-metno--insert-lunar-phase-info current-day)
              (insert "\n"))
            (push weather-metno-forecast--table-column-descriptions day-data)
            ;; Remove any empty strings that remain in data when icons are disabled
            (when (or (not (stringp weather-metno-weathericons-directory))
                      (not (display-images-p)))
              (setq day-data (mapcar (lambda (sublist)
                                       (cl-remove-if (lambda (s) (string= s "")) sublist))
                                     day-data)))
            (make-vtable
             :objects (weather-metno--transpose-2d-list day-data)
             :separator-width 8
             :keymap (define-keymap
                       "g" #'weather-metno-update
                       "s" #'weather-metno-forecast-search-location
                       "l" #'weather-metno-forecast-list-view
                       "q" #'weather-metno-kill-forecast-buffer))
            (goto-char (point-max))))
        (insert "\n")
        (weather-metno--insert
         'weather-metno-footer
         "Weather data from The Norwegian Meteorological Institute (CC BY 3.0)\n"))
      (goto-char (point-min))))
  (unless no-switch
    (weather-metno--switch-to-forecast-buffer)))

(defun weather-metno--order-locations-by-importance (locations)
  "Order locations based on their importance rating."
  (let ((pred (lambda (item) (gethash "importance" item))))
    (cl-reduce (lambda (acc item)
                 (let ((value (funcall pred item))
                       (max-value (funcall pred acc)))
                   (if (> value max-value)
                       item
                     acc)))
               locations)))

(defun weather-metno--fetch-location-data (location)
  "Fetch location data from the Nomatim service. Return result in a JSON object."
  (let ((url-request-extra-headers
         `(("accept-language" . "english"))))
    (let ((query-result (url-retrieve-synchronously (format "https://nominatim.openstreetmap.org/search?q=%s&format=json&accept-language=en" location))))
      (with-current-buffer query-result
        (progn
          (goto-char (point-min))
          (search-forward "\n\n" nil t)
          (let ((headers (buffer-substring (point-min) (point))))
            (unless (string-match-p
                     (concat "^HTTP/1.1 "
                             "\\(200 OK\\|203 "
                             "Non-Authoritative Information\\)")
                     headers)
              (error "Unable to fetch data")))
          (json-parse-string (buffer-substring (point) (point-max))))))))

(defun weather-metno--ask-download-directory ()
  "Prompt for a directory and ask for confirmation when directory is not empty."
  (let ((dir (read-directory-name "Select directory to extract weathericons into: ")))
    (if (or (directory-empty-p dir)
            (y-or-n-p "Directory not empty. Proceed?"))
        dir
      nil)))

(defun weather-metno--check-weathericons ()
  "Check if `weather-metno-weathericons-directory` is `ask', if so, ask to
download and extract the icon package."
  (interactive)
  (when (and
         (eq 'ask weather-metno-weathericons-directory)
         (display-images-p))
    (let ((response (read-char-from-minibuffer "Weathericons directory is not set. Download and extract the package? (y, n or [d]on't ask.) ")))
      (cond
       ((eq response ?y)
        (let ((dir (weather-metno--ask-download-directory))
              (zip-file (concat temporary-file-directory "/weathericons.zip")))
          (when dir
            (url-copy-file "https://github.com/metno/weathericons/archive/refs/heads/main.zip" zip-file t)
            (shell-command (format "unzip -qq -o -j %s \"weathericons-main/weather/png/*\" -d %s" zip-file dir))
            (setq weather-metno-weathericons-directory dir)
            (customize-save-variable 'weather-metno-weathericons-directory dir))))
       ((eq response ?n)
        (message "Operation canceled."))
       ((eq response ?d)
        (setq weather-metno-weathericons-directory nil))
       (t
        (message "Invalid input; please enter y, n, or d."))))))

(defun weather-metno-forecast-location (lat lon &optional msl)
  "Query for latitude, longitude and MSL and fetch the forecast for that location."
  (interactive
   (list
    (read-string (weather-metno--format-with-loc "Latitude")
                 (weather-metno--n2s weather-metno-location-latitude))
    (read-string (weather-metno--format-with-loc "Longitude")
                 (weather-metno--n2s weather-metno-location-longitude))
    (read-string (weather-metno--format-with-loc "Whole meters above sea level")
                 (weather-metno--n2s weather-metno-location-msl))))
  (when (weather-metno--string-empty? msl)
    (setq msl nil))

  (unless (equal (list lat lon msl) weather-metno--data)
    (weather-metno-update lat lon msl)
    (funcall weather-metno-display-function nil)))

;;;###autoload
(defun weather-metno-forecast-search-location (location)
  "Get weather forecast for LOCATION, or input interactively.
Nomatim service is used to get coordinates of the location."
  (interactive
   (list
    (read-string "Location: "
                 weather-metno-location-name)))
  (let ((data (weather-metno--fetch-location-data location)))
    (when (eq (length data) 0)
      (error "No matches."))
    (when (not (eq (length data) 1))
      (message "Multiple matches. Using the most relevant one."))
    (let* ((loc (weather-metno--order-locations-by-importance data))
           (name (gethash "display_name" loc))
           (lon (string-to-number (gethash "lon" loc)))
           (lat (string-to-number (gethash "lat" loc))))
      (setq weather-metno-location-name name)
      (setq weather-metno-location-longitude lon)
      (setq weather-metno-location-latitude lat)
      (setq weather-metno-location-msl nil)
      (weather-metno--check-weathericons)
      ;; FIXME: these cause the buffer to be updated twice
      (weather-metno-update lat lon nil)
      (call-interactively weather-metno-display-function nil))))

;;;###autoload
(defun weather-metno-forecast (&optional arg no-switch)
  "Display weather forecast.  If called with universal-argument, or no
default location has been set, asks for location and queries its coordinates
from NOMATIM service.  If NO-SWITCH is non-nil then do not switch to weather
forecast buffer."
  (interactive "P")
  (if (or (and (eq (weather-metno--get-default-location-latitude) 0)
               (eq (weather-metno--get-default-location-longitude) 0))
          (not (null arg)))
      (call-interactively 'weather-metno-forecast-search-location)
    (weather-metno--check-weathericons)
    ;; FIXME: these may cause the buffer to be updated twice
    (unless weather-metno--data
      (weather-metno-update))
    (call-interactively weather-metno-display-function no-switch)))

(provide 'weather-metno)

;;; weather-metno.el ends here
