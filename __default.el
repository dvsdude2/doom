(";;; package --- summary
;;; Commentary:
;;; code:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; * basic init stuff
(setq initial-scratch-message \";;
;; I'm sorry, Emacs failed to start correctly.
;; Hopefully the issue will be simple to resolve.
;;
;;                _.-^^---....,,--
;;            _--                  --_
;;           <          SONIC         >)
;;           |       BOOOOOOOOM!       |
;;            \\._                   _./
;;               ```--. . , ; .--'''
;;                     | |   |
;;                  .-=||  | |=-.
;;                  `-=#$%&%$#=-'
;;                     | ;  :|
;;            _____.,-#%&$@%#&#~,._____
\")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; org-use-speed-commands’ to a non-‘nil’ value
(setq org-use-speed-commands t)

;; looking at this for eww text to be centered?
;; pet poject Iam working on. 
(setq 
  shr-bullet    \"• \"       ;  Character for an <li> list item
  shr-indentation 14)        ;  Left margin

 
(defcustom which-key-paging-key \"<f5>\"
  \"Key to use for changing pages.
Bound after each of the prefixes in `which-key-paging-prefixes'\"
  :type 'string
  :version \"1.0\")


(cl-pushnew `((,(format \"\\\\`\\\\(C-c\\\\)\\\\ a\\\\'\" prefix-re))
                  nil . \"evilem\")
                which-key-replacement-alist)


;; doom/save-and-kill-buffer
;; a doom function copied here for reference
;;;;###autoload
(defun doom/save-and-kill-buffer ()
  \"Save the current buffer to file, then kill it.\"
  (interactive)
  (save-buffer)
  (kill-current-buffer))


(defun dired-preview--close-previews ()
  \"Kill preview buffers and delete their windows.\"
  (dired-preview--cancel-timer)
  (dired-preview--delete-windows)
  (dired-preview--kill-buffers)
  (dired-preview--kill-large-buffers))

;;;; my update readme file with ediff ;;;;
(defun my/readme-update-ediff ()
    \"Update git README\\\\ using ediff.\"
  (interactive)
  (ediff \"~/.config/doom/config.org\" \"~/.config/doom/README.org\"))



;;;; 'check-for' commands, eq: packages,modes,features,... ;;;;;;;;;;;;;;;;;;;;;
;;;; -----------------------------------------------------------------------;;;;

;;;; this will check for modes

(if (bound-and-true-p flymake-mode)
    (message \"flymake-mode is on\")
  (message \"flymake-mode is off\"))

;;;; this will check for modes
(featurep FEATURE &optional SUBFEATURE)

(if (featurep 'corfu 'corfu-history-mode)
    (message \"features are there!\")
  (message \"no features\"))

;; For people wondering how to check if a package.el package is installed,
;; use package-installed-p.

(if (package-installed-p corfu-history-mode)
    (message \"package is installed\")
  (message \"package is not intalled\"))

;; tell me when it happens
(when(feature-loaded-p 'foo
  (message \"foo is loaded!\")))

;; 
;; Try and figure out if FILE has already been loaded.
(help--loaded-p \"~/.config/emacs/.local/straight/repos/corfu/extensions\")


;;;; set 'browse-url-handlers' ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; -----------------------------------------------------------------------;;;;

;; /[a-zA-Z0-9_\\-]+  ;; a regex to match char after t.co... URL 

;; \"^https?://\\\\(t.co/[a-zA-Z0-9_]+\\\\)/\"
;; \"ttps://t.co/[a-z]*[A-Z][0-9]*\"
;; \"\\<(http[s]?|www\\.twitter\\.com/[a-zA-Z0-9_\\-]+/status/[0-9]+)\\\\>\"
;; \"pic.twitter.com/[a-zA-Z0-9]*\" ;; regex-build tested
;; \"\\\\(https?\\\\)://\\\\(www\\\\.)?twitter\\\\.com\\\\([^[:space:]\\t\\n\\r<]\\\\|$\\\\)\"  ;;this is what llm gave me
;; \"(?:https?:\\/\\/)?(?:www\\.)?youtu\\.?be(?:\\.com)?\\/?.*(?:watch|embed)?(?:.*v=|v\\/|\\/)([\\w\\-_]+)\\&\"  ;; llm ex. for youtube
(setq browse-url-handlers
      '((\"\\\\.\\\\(gifv?\\\\|avi\\\\|AVI\\\\|mp[4g]\\\\|MP4\\\\|MP3\\\\|webm\\\\)$\" . my/mpv-play-url)
        (\"^https?://\\\\(www\\\\.youtube\\\\.com\\\\|youtu\\\\.be\\\\)/\" . my/mpv-play-url)
        (\"^https?://\\\\(odysee\\\\.com\\\\|rumble\\\\.com\\\\)/\" . my/mpv-play-url)
        ;; (\"^https?:\\/\\/((www\\.)?twitter\\.com\\/.+|t\\.co/[a-zA-Z0-9]+|x\\.com\\/.+)/\" . my/mpv-play-url)
        (\"^https?://\\\\(www\\\\.t.co/[a-zA-Z0-9]\\\\|x\\.com\\\\.com\\\\)/\" . my/mpv-play-url)
        (\"^https?://\\\\(off-guardian.org\\\\|.substack\\\\.com\\\\|tomluongo\\\\.me\\\\)/\" . dvs-eww)
        (\"^https?://\\\\(news.ycombinator.com\\\\)/\" . elfeed-open-hnreader-url)
        (\".\" . browse-url-default-browser)))

;;;; here's a 'regular-expression' that matches Twitter URLs: ;;;;;;;;;;;;;;;;
;;;; -----------------------------------------------------------------------;;;; 

;; ```regex
;; https?:\\/\\/(www\\.)?twitter\\.com\\/.+
;; ```

;; This regular expression will match URLs that begin with \"http://\" or \"https://\",
;; followed by \"www.twitter.com\" or \"twitter.com\",
;; and then any character sequence (`.+`).

;; Here's a breakdown of the regular expression:

;; - `https?:\\/\\/` - matches either \"http://\" or \"https://\"
;; - `(www\\.)?` - matches \"www.\" (optional)
;; - `twitter\\.com` - matches \"twitter.com\"
;; - `\\/.*` - matches any character sequence following \"twitter.com\"


;;;; 'whichkey-replacment' ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(which-key-replacement-alist (push '((nil . \"evilem-motion\") . (nil . \"em\"))))

;; matches any binding with the descriptions \"Prefix Command\" and
;; replaces the description with \"prefix\", ignoring the
;; corresponding key.
;; karthinks use of whichkey-replacment
(push '((\"\\\\`C-c a\\\\'\")
        nil . \"evilem-motion\"))
      (which-key-replacement-alist)

;;;; 'dired-preview--kill-buffers' ;;;;;;;;;;;;;;;;;;;;;

 (dired-preview--kill-buffers)
(setq! dired-preview--buffers-threshold 1024)
(setq! dired-preview--buffers-threshold 1024000)
;;   \"Maximum cumulative buffer size of previews.
;; When the accumulated preview buffers exceed this number and
;; `dired-preview--kill-buffers' is called, it will kill buffers
;; until it drops below this number.\")

(map! \"<f5> w\" :desc \"which-key-next-page-cycle\" #'which-key-show-next-page-cycle)


;; hn-show-comments from search-mode ;;;;
;; hacker news comment reader
(defun dvs/elfeed-hn-show-comments ()
  \"hacker news comment reader\"
  (interactive)
  (let ((entries (elfeed-search-selected)))
    (cl-loop for entry in entries
             do (elfeed-untag entry 'read) ;; mark as read use \"'unread\"
             when (cdr (elfeed-entry-id entry))
             do (hnreader-promise-comment it))
    (setq-local hnreader-view-comments-in-same-window t)
    (mapc #'elfeed-search-update-entry entries)
    (unless (use-region-p) (forward-line))))
;; this command could be added to the function
;; (setq-local hnreader-view-comments-in-same-window t)


    (transient-define-prefix my/engine-mode ()
      \"transient for org-mpv-notes\"
      [\"Engine Mode\"
       [(\"b\" \"Brave\"
         (lambda ()
           (interactive)
           (defengine brave
    \"https://search.brave.com/search?q=%s\"
    )))]])

(add-hook 'elfeed-summary-create-buffer-hook #'goto-line 4)

;;;; 'template' using 3 key combo template ;;;;;;;;;;;;;

(map! :leader
      (:prefix-map (\"n\" . \"notes\")
        (:prefix (\"j\" . \"journal\")
         :desc \"New Entry\"           \"j\" #'org-journal-new-entry
         :desc \"New Scheduled Entry\" \"J\" #'org-journal-new-scheduled-entry
         :desc \"Search Forever\"      \"s\" #'org-journal-search-forever)))


;;;; 'd-slide' ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(map! :prefix \"C-c d\"
      :desc \"dslide-deck-start\"
      :n \"s\" #'dslide-deck-start
      :desc \"dslide deck stop\"
      :n \"q\" #'dslide-deck-stop)

(map! :map dslide-mode-map
      :desc \"dslide deck stop\"
      :n \"q\" #'dslide-deck-stop
      :desc \"dslide deck forward\"
      :n \"j\" #'dslide-deck-forward
      :desc \"dslide deck backwards\"
      :n \"k\" #'dslide-deck-backward)

(org-edit-src-code)
 
;; (defun disable-fylcheck-in-org-src-block ()
;;   (setq-local flycheck-disabled-checkers '(emacs-lisp-checkdoc)))






(setq dashboard-projects-switch-function 'counsel-projectile-switch-project-by-name)






" 7715 emacs-lisp-mode)