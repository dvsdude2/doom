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

;;; <FILE> --- <DESCRIPTION>  -*- lexical-binding:t -*-

;; open project todo-file
(defun mep-projectile-open-todo ()
  \"Open the project's todo file.\"
  (interactive)
  (if-let* ((proj-dir (projectile-project-root))
            (proj-todo-file (f-join proj-dir \"TODO.org\")))
      (org-open-file proj-todo-file)
    (message \"Not in a project\")))


(use-package! axy
  :defer t
  :after (yasnippet)
  :load-path \"~/.config/doom/myrepo/axy/axy.el\"
  :config
  (global-set-key (kbd \"spc o s\") 'axy/find-&-expand-snippet))


(use-package! axy
  ;; :defer t
  :load-path \"axy/axy.el\")
  ;; :after yasnippet

  (map! :leader
        :prefix \"o\"
        :desc \"yas scratch buffer\"
        :n \"s\" #'axy/find-&-expand-snippet)


(use-package! tray
  :after-call doom-first-input-hook
  :defer t
  :load-path \"tray/tray.el\")


(add-load-path! \"/myrepo/tray/tray.el\")

 (setq! org-capture-templates
       (\"c\" \"codes\")
       (\"cl\" \"code link\" entry
        (file+headline \"~/org/wiki/code-capture.org\" \"Links\")
        \"** %^{link} %^g\\n- %^{note}\\n%^{image url}\"
        :immediate-finish t :prepend t))

;;;; drag-stuff ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(package! drag-stuff :pin \"6d06d846cd37c052d79acd0f372c13006aa7e7c8\")

(use-package! drag-stuff
  :defer t
  :init
  (map! \"<M-up>\"    #'drag-stuff-up
        \"<M-down>\"  #'drag-stuff-down
        \"<M-left>\"  #'drag-stuff-left
        \"<M-right>\" #'drag-stuff-right))


;;; Repeat-mode map.
(defvar org-navigation-repeat-map (make-sparse-keymap)
  \"Repeat keymap for navigation commands.\")
(org-defkey org-navigation-repeat-map (kbd \"b\") #'org-backward-heading-same-level)
(org-defkey org-navigation-repeat-map (kbd \"f\") #'org-forward-heading-same-level)
(org-defkey org-navigation-repeat-map (kbd \"n\") #'org-next-visible-heading)
(org-defkey org-navigation-repeat-map (kbd \"p\") #'org-previous-visible-heading)
(org-defkey org-navigation-repeat-map (kbd \"u\") #'org-up-heading)
(org-defkey org-navigation-repeat-map (kbd \"0\") #'evil-forward-sentence-begin)
(map-keymap
 (lambda (_key cmd)
   (put cmd 'repeat-map 'org-navigation-repeat-map))
 org-navigation-repeat-map)


;;;; To check whether the minor mode is enabled in the current buffer,
evaluate (default-value \\=repeat-mode)'.


(map! :after org
      :map org-navigation-repeat-map
      :desc \"org-previous-visible-header\"
      :n \"k\" #'org-previous-visible-heading
      :desc \"org-up-header\"
      :n \"u\" #'org-up-heading
      :desc \"evil-forward-sentence-begin\"
      :n \"]\" #'evil-forward-sentence-begin)

;;;; repeat-map \"outline\"
;;;; this is what is there for Navigating.

(defvar-keymap outline-navigation-repeat-map
  :repeat t
  \"C-b\" #'outline-backward-same-level
  \"b\"   #'outline-backward-same-level
  \"C-f\" #'outline-forward-same-level
  \"f\"   #'outline-forward-same-level
  \"C-n\" #'outline-next-visible-heading
  \"n\"   #'outline-next-visible-heading
  \"C-p\" #'outline-previous-visible-heading
  \"p\"   #'outline-previous-visible-heading
  \"C-u\" #'outline-up-heading
  \"u\"   #'outline-up-heading)

;;;; this will add a  line with out needing return

(setq next-line-add-newlines t)

;;;; proj automate sorting?

(setq my-function
      (org-sort-entries t ?o))


* ;;;; focus-mode Read-Only

;;;###autoload
#+begin_src emacs-lisp
(define-minor-mode focus-read-only-mode
  \"A read-only mode optimized for `focus-mode'.\"
  :init-value nil
  :keymap (let ((map (make-sparse-keymap)))
            (define-key map (kbd \"n\") 'focus-next-thing)
            (define-key map (kbd \"p\") 'focus-prev-thing)
            (define-key map (kbd \"i\") 'focus-turn-off-focus-read-only-mode)
            (define-key map (kbd \"q\") 'focus-turn-off-focus-read-only-mode)
            map)
  (when cursor-type
    (setq focus-cursor-type cursor-type))
  (if focus-read-only-mode (focus-read-only-init) (focus-read-only-terminate)))
#+end_src

* ;;;; capture template for org-drill (LLM)

#+begin_src emacs-lisp
(setq org-capture-templates
      '((\"ra\" \"anki\" entry
         (file+headline \"~/org/wiki/anki\" \"Drill Items\")
         \"* %^{Front}\\n:PROPERTIES:\\n:ANKI_DECK: Master\\n:ANKI_NOTE_TYPE: Basic\\n:END:\\n\\\\** Back\\n    %^{Back}\\n\\\\** Additional Info\\n    %^{Additional Info}\\n\")))
#+end_src


* ;;;; example template using a function in capture 

#+begin_src emacs-lisp
(setq org-capture-templates
      '((\"x\" \"Test entry 1\" plain
         (file \"~/tmp/test.txt\")
         (function my/expense-template)
         :account \"Account:Bank\")
        (\"y\" \"Test entry 2\" plain
         (file \"~/tmp/test.txt\")
         (function my/expense-template)
         :account \"Account:AnotherBank\")))
#+end_src

* ;;;; found this in a gist called my notes grab this.

#+begin_src emacs-lisp
(defun my/notes-new (title)
  \"Create a new note given a title\"
  (interactive \"sTitle: \")
  (let ((default-directory (concat my/notes-directory \"/\")))
    (find-file (concat (my/title-to-filename title) \".org\"))
    (when (= 0 (buffer-size))
      (insert \"#+title: \" title \"\\n\"
              \"#+date: \")
      (org-insert-time-stamp nil)
      (insert \"\\n\\n\"))))

(defun my/title-to-filename (title)
  \"Convert TITLE to a reasonable filename.\"
  ;; Based on the slug logic in org-roam, but org-roam also uses a
  ;; timestamp, and I use only the slug. BTW \"slug\" comes from
  ;; <https://en.wikipedia.org/wiki/Clean_URL#Slug>
  (setq title (s-downcase title))
  (setq title (s-replace-regexp \"[^a-zA-Z0-9]+\" \"-\" title))
  (setq title (s-replace-regexp \"-+\" \"-\" title))
  (setq title (s-replace-regexp \"^-\" \"\" title))
  (setq title (s-replace-regexp \"-$\" \"\" title))
  title)
#+end_src

* ;;;; csetq versions

#+begin_src emacs-lisp
(defmacro csetq (sym val)
  `(funcall (or (get ',sym 'custom-set) 'set-default) ',sym ,val))

(defmacro csetq (variable value)
  `(funcall (or (get ',variable 'custom-set) 'set-default) ',variable ,value))

(defmacro csetq (sym val)
  `(funcall (or (get ',sym 'custom-set) 'set-default) ',sym ,val))
#+end_src


;;; oxxxx[::::::::::::::::::::>


* ;;; change face of ace-window
#+begin_src emacs-lisp

(custom-set-faces!
 '(aw-leading-char-face
   :foreground \"white\" :background \"red\"
   :weight bold :height 2.5 :box (:line-width 10 :color \"red\")))
#+end_src

* ;;;; focus-mode function
#+begin_src emacs-lisp
(map! \"C-c u\" #'focus-next-thing)
#+end_src

* ;;;; make list of URLs that eww opens 'readable'
#+begin_src emacs-lisp
(setq eww-readable-urls '((\"https://example\\\\.com/\" . nil)
                          \".*\"))
#+end_src

* ;;;; This should add new lines automatically. no end of buffer errors

#+begin_src emacs-lisp
(setq next-line-add-newlines t)
#+end_src

* ;;;; use this to make eww buffers real

#+begin_src emacs-lisp
;;; doom-real-buffer-p

(setq doom-real-buffer-functions
  '(+rss-buffer-p +magit-buffer-p doom-dired-buffer-p))
  
  ;; Ensure elfeed buffers are treated as real
  (add-hook! 'doom-real-buffer-functions
    (defun +rss-buffer-p (buf)
      (string-match-p \"^\\\\*elfeed\" (buffer-name buf))))
  ;; Ensure elfeed buffers are treated as real
  (add-hook! 'doom-real-buffer-functions
    (defun +eww-buffer-p (buf)
      (string-match-p \"\\\\*.*eww.*\\\\*\" (buffer-name buf))))
#+end_src

* ;;;; use local-variables ask to Tangle?

#+begin_src emacs-lisp


 ;; Local Variables: 
;; eval: (add-hook 'after-save-hook (lambda ()(if (y-or-n-p \"Tangle?\")(org-babel-tangle))) nil t) 
;; End: 
#+end_src

* ;;;; evil end-of-line

** ;;;; v$ not use last Character

#+begin_src emacs-lisp

(map! :map evil-org-mode-map
      [remap evil-org-end-of-line] #'evil-end-of-line)

(setq! evil-v$-excludes-newline t)
(setq evil-respect-visual-line-mode t)
(setq evil-cross-lines t)
(global-visual-line-mode 1)
#+end_src

* ;;;; don't indent code blocks

#+begin_src emacs-lisp
;; - In the code part of a source block, use language major mode
;;     to indent current line if ‘org-src-tab-acts-natively’ is
;;     non-nil.  If it is nil, do nothing.

;; It has no effect if ‘org-src-preserve-indentation’ is non-nil.
(setq org-src-preserve-indentation t)

(setq org-src-tab-acts-natively nil)
# Local Variables:
# org-src-tab-acts-natively: nil
# End:
#+end_src

* ;;;; elfeed-summary-settings

#+begin_src emacs-lisp

(setq elfeed-summary-settings
  (expand-file-name \"myrepo/elfeed-summary-layout/+elfeed-summary-settings.el\" doom-user-dir))

(elfeed-summary--restore-folding-state folding-state)
(elfeed-summary--refresh)
(add-hook elfeed-summary-mode-hook)
#+end_src
#+begin_src emacs-lisp
(setq doom-scratch-initial-major-mode org)
#+end_src

* ;;;; using shift-j in dired lets you search for file.

#+begin_src emacs-lisp
(dired-goto-file FILE)
#+end_src

" 13659 org-mode)