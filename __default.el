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



;;;; 'dired-preview--kill-buffers' ;;;;;;;;;;;;;;;;;;;;;

 (dired-preview--kill-buffers)
(setq! dired-preview--buffers-threshold 1024)
(setq! dired-preview--buffers-threshold 1024000)
;;   \"Maximum cumulative buffer size of previews.
;; When the accumulated preview buffers exceed this number and
;; `dired-preview--kill-buffers' is called, it will kill buffers
;; until it drops below this number.\")

(map! \"<f5> w\" :desc \"which-key-next-page-cycle\" #'which-key-show-next-page-cycle)


;;;; possible trasient project ;;;;;;;;;;;;;;;;;;;;;;;;;
    (transient-define-prefix my/engine-mode ()
      \"transient for org-mpv-notes\"
      [\"Engine Mode\"
       [(\"b\" \"Brave\"
         (lambda ()
           (interactive)
           (defengine brave
    \"https://search.brave.com/search?q=%s\"
    )))]])

(add-hook 'elfeed-summary-get-buffer-create-hook (lambda () (goto-line 4)))

;; This is the function that makes the buffer in elfeed-summary
;; 

;; ;;;###autoload
;; (defun elfeed-summary ()
;;   \"Display a feed summary for elfeed.\"
;;   (interactive)
;;   (elfeed-summary--ensure)
;;   (unless elfeed-summary--setup
;;     (elfeed-summary--setup))
;;   (when-let ((buffer (get-buffer elfeed-summary-buffer)))
;;     (kill-buffer buffer))
;;   (let ((buffer (get-buffer-create elfeed-summary-buffer)))
;;     (with-current-buffer buffer
;;       (elfeed-summary--render
;;        (elfeed-summary--get-data)))
;;     (switch-to-buffer buffer)
;;     (goto-char (point-min))))
(after! elfeed-summary (λ! forward-line 3))


;;;; 'template' using 3 key combo template ;;;;;;;;;;;;;

(map! :leader
      (:prefix-map (\"n\" . \"notes\")
        (:prefix (\"j\" . \"journal\")
         :desc \"New Entry\"           \"j\" #'org-journal-new-entry
         :desc \"New Scheduled Entry\" \"J\" #'org-journal-new-scheduled-entry
         :desc \"Search Forever\"      \"s\" #'org-journal-search-forever)))


;;;; 'display' ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq dashboard-projects-switch-function 'counsel-projectile-switch-project-by-name)


(add-to-list 'display-buffer-alist
   '(\"^\\\\*HNComments\\\\*\" display-buffer-in-side-window
     (side . left)
     (window-width . 0.30)))


;;; repeat-mode ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; - look into wether or not reapt-mode can be toggled

#+begin_src emacs-lisp
(repeat-mode 1)

;;; repeat-mode
(defvar cc/org-header-navigation-repeat-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd \"p\")    #'org-previous-visible-heading)
    (define-key map (kbd \"n\")  #'org-next-visible-heading)
    map))
;;

(map-keymap
 (lambda (_ cmd)
   (put cmd 'repeat-map 'cc/org-header-navigation-repeat-map))
 cc/org-header-navigation-repeat-map)
#+end_src
;;

(after! org
  (repeat-mode 1))

(add-hook 'org-mode-hook 'repeat-mode 1)
repeat
;;

#+begin_src emacs-lisp
(after! org
  (repeat-mode 1))
(defvar dvs/org-header-navigation-repeat-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd \"k\")    #'org-previous-visible-heading)
    (define-key map (kbd \"j\")  #'org-next-visible-heading)
    (define-key map (kbd \"l\")    #'org-next-link)
    map))

(map-keymap
 (lambda (_ cmd)
   (put cmd 'repeat-map 'dvs/org-header-navigation-repeat-map))
 dvs/org-header-navigation-repeat-map)
#+end_src


;; possible config setting for 'org-web-tools' ;;;;;;;;;
;;

(use-package! org-web-tools
  :commands (org-web-tools-read-url-as-org
             org-web-tools-insert-web-page-as-entry
             org-web-tools-insert-link-for-url)
  :general ([remap comment-line] #'evilnc-comment-or-uncomment-lines))



(defun generate-buffer ()
  (interactive)
  (switch-to-buffer (make-temp-name \"daily-scratch\")))

;; not 100% sure what this does but looks interesting enough
(defun extract-and-save ()
  (interactive)
  (let ((text-to-save (get-text-to-save)))
    (save-window-excursion
      (switch-to-buffer-other-window (generate-new-buffer \"*extraction*\"))
      (insert text-to-save)
      (diff-mode)
      (unwind-protect (save-buffer) 
        (kill-buffer)))))



;; *reddigg-main*: show your subreddit list, enter on them will fetch the
;; subreddit posts and show them on *reddigg*. On *reddigg* when you enter on a
;; post will fetch the comments and show them on *reddigg-comments* buffer.


(defun convert2org ()
  “Convert the current buffer’s content into Org-mode format.”
  (interactive)
  ;; Set buffer to Org mode
  (org-mode)
  ;; Add a simple org-mode header to the buffer
  (goto-char (point-min))
  (insert “#+TITLE: Converted Document\\n”)
  (insert “#+DATE: “ (format-time-string “%Y-%m-%d”) “\\n”)
  ;; Add an empty line for separation
  (insert “\\n”)
  ;; Message indicating conversion is complete
  (message “Buffer converted to Org-mode format.”))

      ;;; smartparens
(map! (:after smartparens
        :map smartparens-mode-map
        \"C-M-a\"           #'sp-beginning-of-sexp
        \"C-M-e\"           #'sp-end-of-sexp
        \"C-M-f\"           #'sp-forward-sexp
        \"C-M-b\"           #'sp-backward-sexp
        \"C-M-n\"           #'sp-next-sexp
        \"C-M-p\"           #'sp-previous-sexp
        \"C-M-u\"           #'sp-up-sexp
        \"C-M-d\"           #'sp-down-sexp
        \"C-M-k\"           #'sp-kill-sexp
        \"C-M-t\"           #'sp-transpose-sexp
        \"C-M-<backspace>\" #'sp-splice-sexp))

;; this is charlie choe's issue capture template
;; 
;; (\"Issue\"
;;                            :keys \"i\"
;;                            :todo-state \"TODO\"
;;                            :template (lambda ()
;;                                        (cc/config-capture-template
;;                                         '(\"* %{todo-state} %^{description} %^G\")
;;                                         '(\"\\n** Title\"
;;                                           \"%?\"
;;                                           \"** Description\\n\"
;;                                           \"** Environment\\n\"
;;                                           \"** Steps to Reproduce\\n\"
;;                                           \"** Expected Result\\n\"
;;                                           \"** Actual Result\\n\"
;;                                           ))))
;; ))

;; This snippet of code can create diary entries in #emacs using the folder
;; structure like ~/Diary/2024/05_May 2024/22 May 2024, Wednesday.md just by
;; hitting C-d-d and selecting the date from the calendar. 
;; Missing folders are created automatically. If an entry already exists, it will be just opened for editing.
(setq diary-folder \"~/Diary\")
(defun create-diary-entry (time)
  (let* ((year (format-time-string \"%Y\" time))
    (month-number (format-time-string \"%m\" time))
    (month-name (format-time-string \"%B\" time))
    (date (format-time-string \"%d\" time))
    (week-day (format-time-string \"%A\" time))
    (month-folder-name (concat month-number \"_\" month-name \" \" year))
    (entry-name (concat date \" \" month-name \" \" year \", \" week-day))
    (year-folder-path (concat diary-folder  \"/\" year))
    (month-folder-path (concat year-folder-path \"/\" month-folder-name))
    (entry-path (concat month-folder-path \"/\" entry-name \".md\")))
      (if (not (file-directory-p year-folder-path))
          (make-directory year-folder-path))
      (if (not (file-directory-p month-folder-path))
          (make-directory month-folder-path))
      (if (not (file-exists-p entry-path))
          (write-region (concat \"# \" entry-name \"\\n\\n\") nil (expand-file-name entry-path)))
      (find-file entry-path)
      (beginning-of-line 3)))

(setq diary-date-keymap (make-sparse-keymap))
(global-set-key (kbd \"C-c d\") diary-date-keymap)

(define-key diary-date-keymap (kbd \"d\") (lambda () \"Create a diary entry with a date chosen from calendar\" (interactive) (create-diary-entry (date-to-time (org-read-date)))))


;;;; 'if' statement ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; 

(if COND THEN ELSE...) ;; format 

;; FIXME (setting-constant nil)
(add-hook elfeed-summary-mode-hook #'cursor-placement)
(defun cursor-placement ()
  \"Move cursor to first entry.\"
  (interactive)
  (if (point-min)
      (forward-line 3)
    (forward-line 3)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun xml->tree-widget (root)
  (cond ((null root) nil)
	((listp root) (let ((elem (xml-node-name root))
			    (children (remove-if (function stringp) (xml-node-children root))))
			`(tree-widget :node (push-button
					     :tag ,(format \"%s\" elem)
					     :format \"%[%t%]\\n\"
					     :xml-node ,root
					     :notify ,(lambda (widget &rest rest)
                                                        (message (format \"%s\" (widget-get widget :xml-node)))))
				      ,@(mapcar (lambda (x) (xml->tree-widget x)) children))))))

(add-hook 'nxml-mode-hook (lambda() (hs-minor-mode 1)))

(add-to-list 'hs-special-modes-alist
             '(nxml-mode
               \"<!--\\\\|<[^/>]*[^/]>\" ;; regexp for start block
               \"-->\\\\|</[^/>]*[^/]>\" ;; regexp for end block
               \"<!--\"
               nxml-forward-element
               nil))



;;; <FILE> --- <DESCRIPTION>  -*- lexical-binding:t -*-

;; open project todo-file
(defun mep-projectile-open-todo ()
  \"Open the project's todo file.\"
  (interactive)
  (if-let* ((proj-dir (projectile-project-root))
            (proj-todo-file (f-join proj-dir \"TODO.org\")))
      (org-open-file proj-todo-file)
    (message \"Not in a project\")))" 11707 emacs-lisp-mode)