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


;;;; 'whichkey-replacment' ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defcustom which-key-paging-key \"<f5>\"
  \"Key to use for changing pages.
Bound after each of the prefixes in `which-key-paging-prefixes'\"
  :type 'string
  :version \"1.0\")


(cl-pushnew `((,(format \"\\\\`\\\\(C-c\\\\)\\\\ a\\\\'\" prefix-re))
                  nil . \"evilem\")
                which-key-replacement-alist)

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

;; this one was on the left but separate window added to the left 
(set-popup-rules!
  '((\"^\\\\*\\\\(HN\\\\|HNComments\\\\)\"
     :slot 2 :vslot -1 :size +popup-shrink-to-fit
     :side left :select t :quit t)))
;; this just an ex. for left-side

 (\"^ \\\\*undo-tree\\\\*\"
  (+popup-buffer)
  (actions)
  (side . left)
  (size . 20)
  (window-width . 40)
  (window-height . 0.16)
  (slot . 2)
  (vslot)
  (window-parameters
   (ttl . 5)
   (quit . t)
   (select . t)
   (modeline)
   (autosave)))

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


  (consult-customize
   consult-ripgrep consult-git-grep consult-grep
   consult-bookmark consult-recent-file
   consult--source-recent-file consult--source-project-recent-file consult--source-bookmark
   :preview-key \"C-SPC\")
  (when (modulep! :config default)
    (consult-customize
     +default/search-project +default/search-other-project
     +default/search-project-for-symbol-at-point
     +default/search-cwd +default/search-other-cwd
     +default/search-notes-for-symbol-at-point
     +default/search-emacsd
     :preview-key \"C-SPC\"))
  (consult-customize
   consult-theme
   :preview-key (list \"C-SPC\" :debounce 0.5 'any))
  (when (modulep! :lang org)
    (defvar +vertico--consult-org-source
      (list :name     \"Org Buffer\"
            :category 'buffer
            :narrow   ?o
            :hidden   t
            :face     'consult-buffer
            :history  'buffer-name-history
            :state    #'consult--buffer-state
            :new
            (lambda (name)
              (with-current-buffer (get-buffer-create name)
                (insert \"#+title: \" name \"\\n\\n\")
                (org-mode)
                (consult--buffer-action (current-buffer))))
            :items
            (lambda ()
              (mapcar #'buffer-name
                      (if (featurep 'org)
                          (org-buffer-list)
                        (seq-filter
                         (lambda (x)
                           (eq (buffer-local-value 'major-mode x) 'org-mode))
                         (buffer-list)))))))
    (add-to-list 'consult-buffer-sources '+vertico--consult-org-source 'append)))


;; *reddigg-main*: show your subreddit list, enter on them will fetch the
;; subreddit posts and show them on *reddigg*. On *reddigg* when you enter on a
;; post will fetch the comments and show them on *reddigg-comments* buffer.


" 3515 emacs-lisp-mode)