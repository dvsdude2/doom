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


* ;; org-use-speed-commands’ to a non-‘nil’ value
(setq org-use-speed-commands t)

* ;; looking at this for eww text to be centered?
;; pet poject Iam working on. 
(setq 
  shr-bullet    \"• \"       ;  Character for an <li> list item
  shr-indentation 14)        ;  Left margin

 

* ;; doom/save-and-kill-buffer [ZX]
;; a doom function copied here for reference
;;;;###autoload
(defun doom/save-and-kill-buffer ()
  \"Save the current buffer to file, then kill it.\"
  (interactive)
  (save-buffer)
  (kill-current-buffer))


* ;;;; my update readme file with ediff ;;;;

(defun my/readme-update-ediff ()
    \"Update git README\\\\ using ediff.\"
  (interactive)
  (ediff \"~/.config/doom/config.org\" \"~/.config/doom/README.org\"))


* ;;;; here's a 'regular-expression' that matches Twitter URLs: ;;;;;;;;;;;;;;;;
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



* ;;;; 'dired-preview--kill-buffers' ;;;;;;;;;;;;;;;;;;;;;

 (dired-preview--kill-buffers)
(setq! dired-preview--buffers-threshold 1024)
(setq! dired-preview--buffers-threshold 1024000)
;;   \"Maximum cumulative buffer size of previews.
;; When the accumulated preview buffers exceed this number and
;; `dired-preview--kill-buffers' is called, it will kill buffers
;; until it drops below this number.\")

(map! \"<f5> w\" :desc \"which-key-next-page-cycle\" #'which-key-show-next-page-cycle)


* ;; This is the function that makes the buffer in elfeed-summary
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


* ;;;; 'template' using 3 key combo template ;;;;;;;;;;;;;

(map! :leader
      (:prefix-map (\"n\" . \"notes\")
        (:prefix (\"j\" . \"journal\")
         :desc \"New Entry\"           \"j\" #'org-journal-new-entry
         :desc \"New Scheduled Entry\" \"J\" #'org-journal-new-scheduled-entry
         :desc \"Search Forever\"      \"s\" #'org-journal-search-forever)))

* ;; possible config setting for 'org-web-tools' ;;;;;;;;;
;;

(use-package! org-web-tools
  :commands (org-web-tools-read-url-as-org
             org-web-tools-insert-web-page-as-entry
             org-web-tools-insert-link-for-url)
  :general ([remap comment-line] #'evilnc-comment-or-uncomment-lines))



* ;;;; covert to org funtion 
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

* ;;;; smart paren key map
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

* ;; This snippet of code can create diary entries in #emacs
;; This snippet of code can create diary entries in #emacs using the folder
;; structure like ~/Diary/2024/05_May 2024/22 May 2024, Wednesday.md just by
;; hitting C-d-d and selecting the date from the calendar. 
;; Missing folders are created automatically. If an entry already exists, it will be just opened for editing.
#+begin_src emacs-lisp
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
#+end_src

* ;;;; 'if' statement ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(if COND THEN ELSE...) ;; format 

#+begin_src emacs-lisp
;; FIXME (setting-constant nil)
(add-hook elfeed-summary-mode-hook #'cursor-placement)
(defun cursor-placement ()
  \"Move cursor to first entry.\"
  (interactive)
  (if (point-min)
      (forward-line 3)
    (forward-line 3)))
#+end_src
* ;;;; lexical-binding syntax

;;; <FILE> --- <DESCRIPTION>  -*- lexical-binding:t -*-

* ;;;; org-capture example template

 #+begin_src emacs-lisp
 (setq! org-capture-templates
       (\"c\" \"codes\")
       (\"cl\" \"code link\" entry
        (file+headline \"~/org/wiki/code-capture.org\" \"Links\")
        \"** %^{link} %^g\\n- %^{note}\\n%^{image url}\"
        :immediate-finish t :prepend t))
 #+end_src

* ;;;; To check whether the minor mode is enabled in the current buffer,

#+begin_src emacs-lisp
evaluate (default-value \\=repeat-mode)'.
#+end_src


* ;;;; repeat-map \"outline\"
;;;; this is what is there for Navigating.

#+begin_src emacs-lisp
;; not sure were this came from

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
;;;; not sure what this is could be a incomplete project.

(map! :after org
      :map org-navigation-repeat-map
      :desc \"org-previous-visible-header\"
      :n \"k\" #'org-previous-visible-heading
      :desc \"org-up-header\"
      :n \"u\" #'org-up-heading
      :desc \"evil-forward-sentence-begin\"
      :n \"]\" #'evil-forward-sentence-begin)
;; this one looks official, but can't say were it comes from.

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
        
#+end_src

* ;;;; proj automate sorting?

#+begin_src emacs-lisp
(setq my-function
      (org-sort-entries t ?o))
#+end_src


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

;; elfeed-summary example of real buffer settings

  ;; Ensure elfeed buffers are treated as real
  (add-hook! 'doom-real-buffer-functions
    (defun elfeed-summary-buffer-p (buf)
      (string-match-p \"^\\\\*elfeed-summary\" (buffer-name buf))))
#+end_src

#+end_src

* ;;;; elfeed-summary-settings

#+begin_src emacs-lisp

(setq elfeed-summary-settings
  (expand-file-name \"myrepo/elfeed-summary-layout/+elfeed-summary-settings.el\" doom-user-dir))

(elfeed-summary--restore-folding-state folding-state)
(elfeed-summary--refresh)
(elfeed-summary--refresh-if-exists)
(add-hook elfeed-summary-mode-hook)
;; example for reference

;; elfeed
(use-package! elfeed
  :commands (elfeed)
  :init
  (setq elfeed-db-directory (concat doom-local-dir \"elfeed/db/\")
        elfeed-enclosure-default-dir (concat doom-local-dir \"elfeed/enclosures/\"))
  :config
  (setq elfeed-search-filter \"@6-months-ago \"

#+end_src
#+begin_src emacs-lisp
(setq doom-scratch-initial-major-mode org)
#+end_src

* ;;;; using shift-j in dired lets you search for file.

#+begin_src emacs-lisp
(dired-goto-file FILE)
#+end_src


#+begin_src emacs-lisp
(defun my-write-help-buffer-to-org-file ()
  \"Write the current help buffer to an Org file.\"
  (interactive)
  (let* ((filename (read-file-name \"Save help buffer to file: \" nil nil nil (concat \"help-\" (buffer-name) \".org\"))))
    (write-region (point-min) (point-max) filename nil nil nil 'excl)))   
#+end_src

* ;;;; end-of-sexp this only works in programming modes
#+begin_src emacs-lisp
(sp-end-of-sexp &optional ARG)
#+end_src
* ;;;; evilem-default-keybindings

#+begin_src emacs-lisp
(evilem-default-keybindings \"SPC\")
;; not sure were this came from but it confuses me
(map! :prefix \"C-c\"
      :n \"a\" #'evilem-motion)
;; definition of the above
(defun evilem-default-keybindings (prefix)
  \"Define easymotions for all motions evil defines by default\"
  (define-key evil-motion-state-map (kbd prefix) evilem-map))
#+end_src

" 14602 org-mode)