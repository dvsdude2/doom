;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Some functionality uses this to identify you
(setq user-full-name "dvsdude"
      user-mail-address "john@doe.com")

;; add packages manually by downloading the repo

;; spray
;; (add-to-list 'load-path "~/builds/manual-packages/spray")

;; Corfu-extensions to load path
(add-to-list 'load-path
               (expand-file-name "~/.config/emacs/.local/straight/repos/corfu/extensions"))
(add-to-list 'load-path "~/.config/doom/myrepo")
;; (load "~/.config/doom/myrepo/+config/+config.el")

;; fontset ;;;;
(setq doom-font (font-spec :family "Hack Nerd Font" :size 17 :weight 'bold)
;; (setq doom-font (font-spec :family "Iosevka" :size 17 :weight 'heavy)
      doom-variable-pitch-font (font-spec :family "DroidSansMono Nerd Font" :size 17)
      ;; doom-variable-pitch-font (font-spec :family "Iosevka" :size 18)
      ;; doom-unicode-font (font-spec :family "DejaVu Sans Mono")
      doom-symbol-font (font-spec :family "DroidSansMono Nerd Font")
      doom-big-font (font-spec :family "Hack Nerd Font" :size 24 :weight 'bold))

(set-fontset-font t 'emoji
                      '("My New Emoji Font" . "iso10646-1") nil 'prepend)

;; (setq doom-theme 'doom-one)
(setq doom-theme 'doom-Iosvkem)

;; hl line mode
(global-hl-line-mode +1)
;; no fringe
(set-fringe-mode 0)
;; line number type
;; (setq display-line-numbers-type 'visual)
(setq display-line-numbers-type nil)
;; should put  focus in the new window ;;;;
(setq evil-split-window-below t
      evil-vsplit-window-right t)
;; set fancy splash-image
(setq fancy-splash-image "~/.config/doom/splash/doom-color.png")
;; set org-directory. It must be set before org loads
(setq org-directory "~/org/")
;; use trash
(setq trash-directory "~/.local/share/Trash/files/")
(setq delete-by-moving-to-trash t)
;; ignore-case
(setq read-file-name-completion-ignore-case t
      read-buffer-completion-ignore-case t
      completion-ignore-case t)
;; gives isearch total number of matches
(setq-default isearch-lazy-count t)
;; move mouse out of the way
(mouse-avoidance-mode t)
(setq mouse-avoidance-mode "banish")
;; dictionary server ;;;;
(setq dictionary-server "dict.org")
;; number of lines of overlap in page flip ;;;;
(setq next-screen-context-lines 7)
;; this should replicate scrolloff in vim ;;
(setq scroll-margin 7)
(setq scroll-preserve-screen-position t)
;; Maximize the window upon startup
(add-to-list 'initial-frame-alist '(fullscreen . maximized))
;;;  "Syntax color, highlighting code colors ;;;;
(add-hook 'prog-mode-hook #'rainbow-mode)
;; Sensible line breaking
(add-hook 'text-mode-hook 'visual-line-mode)
;; automatic chmod +x when you save a file with a #! shebang
(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)

(when (display-graphic-p)
  (global-unset-key (kbd "C-z"))
  (global-unset-key (kbd "C-x C-z")))

(use-package dashboard
  :demand t
  :custom
  (dashboard-startup-banner (concat  "~/.config/doom/splash/doom-color.png"))
  (dashboard-banner-logo-title "Welcome to my ☠DOOM 'n DIRE☠ tis the only thing that fills the desire.🔥")
  (dashboard-center-content t)
  (dashboard-set-heading-icons t)
  (dashboard-set-file-icons t)
  (dashboard-set-init-info t)
  (dashboard-set-navigator t)
  (dashboard-navigator-buttons
   `(
     ((,(and (display-graphic-p)
             (nerd-icons-faicon "nf-fa-rss_square" :height 1.0 :face 'font-lock-keyword-face))
       "elfeed"
       "open elfeed"
       (lambda (&rest _) (=rss)))
      (,(and (display-graphic-p)
             (nerd-icons-faicon "nf-fa-book" :height 1.0 :face 'font-lock-keyword-face))
       "journal"
       "journal new entry"
       (lambda (&rest _) (org-journal-new-entry nil)))
      (,(and (display-graphic-p)
             (nerd-icons-codicon "nf-cod-settings" :height 1.0 :face 'font-lock-keyword-face))
       "config"
       "open config"
       ;;(lambda (&rest _) (+workspace/load "config")))
       (lambda (&rest _) (=config)))
      (,(and (display-graphic-p)
             (nerd-icons-faicon "nf-fa-calendar" :height 1.0 :face 'font-lock-keyword-face))
       "calendar"
       "calendar"
       (lambda (&rest _) (=calendar)))
      (,(and (display-graphic-p)
             (nerd-icons-faicon "nf-fa-tasks" :height 1.0 :face 'font-lock-keyword-face))
       "agenda"
       "agenda all todos"
       (lambda (&rest _) (org-agenda nil "n")))
      (,(and (display-graphic-p)
             (nerd-icons-mdicon "nf-md-restore" :height 1.0 :face 'font-lock-keyword-face))
       "restart"
       "restar emacs"
       (lambda (&rest _) (restart-emacs))))))
  :config
  (setq dashboard-items '((recents . 7)
                          (bookmarks . 6)
                          (agenda . 3)))
  (setq initial-buffer-choice (lambda() (dashboard-refresh-buffer)(get-buffer "*dashboard*"))))

(add-to-list '+doom-dashboard-menu-sections
             '("Add journal entry"
               :icon (nerd-icons-faicon "nf-fa-calendar" :face 'doom-dashboard-menu-title)
               :when (modulep! :lang org +journal)
               :face (:inherit (doom-dashboard-menu-title bold))
               :action org-journal-new-entry))

(add-to-list '+doom-dashboard-menu-sections
             '("open elfeed"
               :icon (nerd-icons-faicon "nf-fa-rss_square" :face 'doom-dashboard-menu-title)
               :when (modulep! :app rss +org)
               :face (:inherit (doom-dashboard-menu-title bold))
               :action =rss))

;; use open window for default target
(setq dired-dwim-target t)

(add-hook 'dired-mode-hook
          'dired-hide-details-mode)

;;; dired preview set to toggle, can be auto
(after! dired
  (use-package! dired-preview))
;;     :hook
;;     (dired-mode . dired-preview-mode)))
;; (dired-preview-global-mode 1)

(map! :leader
      :prefix "t"
      :desc "dired preview mode" "p" 'dired-preview-mode)

;;; dired subtree
(use-package! dired-subtree
  :after dired
  :config
  (bind-key "<tab>" #'dired-subtree-toggle dired-mode-map)
  (bind-key "<backtab>" #'dired-subtree-cycle dired-mode-map))

;; dired open
(after! dired
  (use-package! dired-open
    :config
    (setq dired-open-extensions '(("mkv" . "mpv")
                                  ("mp4" . "mpv")
                                  ("webm" . "mpv")))))

(use-package! deft
  :commands deft
  :init
  (setq deft-default-extension "org"
        deft-directory "~/org/"
        ;; de-couples filename and note title:
        deft-use-filename-as-title t
        deft-use-filter-string-for-filename t
        deft-recursive t
        ;; disable auto-save
        deft-auto-save-interval -1.0
        ;; converts the filter string into a readable file-name using kebab-case:
        deft-file-naming-rules
        '((noslash . "-")
          (nospace . "-")
          (case-fn . downcase))
        deft-strip-summary-regexp
      (concat "\\("
          "[\n\t]" ;; blank
          "\\|^#\\+[[:alpha:]_]+:.*$" ;; org-mode metadata
          "\\|^:PROPERTIES:\n\\(.+\n\\)+:END:\n"
          "\\)"))
  :config
  (add-to-list 'deft-extensions '("md" "txt" "tex" "org"))
  (add-hook 'deft-mode-hook #'doom-mark-buffer-as-real-h)
  ;; start filtering immediately
  (set-evil-initial-state! 'deft-mode 'insert)
  (map! :map deft-mode-map
        :n "gr"  #'deft-refresh
        :n "C-s" #'deft-filter
        :i "C-n" #'deft-new-file
        :i "C-m" #'deft-new-file-named
        :i "C-d" #'deft-delete-file
        :i "C-r" #'deft-rename-file
        :n "r"   #'deft-rename-file
        :n "a"   #'deft-new-file
        :n "A"   #'deft-new-file-named
        :n "d"   #'deft-delete-file
        :n "D"   #'deft-archive-file
        :n "q"   #'kill-current-buffer))

;; default file for notes
(setq org-default-notes-file (concat org-directory "notes.org"))
;; default diary files
(setq org-agenda-diary-file "~/org/notable-dates.org")
;; (setq diary-file "~/.config/doom/diary")

;; org insert structural template (C-c C-,) menu for adding code blocks
(after! org
(use-package! org-tempo
  :config
  (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))))

;; copy and paste images into an org-file
(after! org
  (use-package! org-ros
    :defer t))

;; org-refile
(setq org-refile-targets '((nil :maxlevel . 2) (org-agenda-files :maxlevel . 2)))
(setq org-outline-path-complete-in-steps nil)         ;; Refile in a single go
(setq org-refile-use-outline-path 'file)              ;; this also set by vertico

;; org-src edit window  C-c ' or spc m '
(setq org-src-window-setup 'reorganize-frame)  ;; default

;; set org-id to a timestamp instead of uuid
(setq org-id-method 'ts)

;; disable flycheck in org-src-blocks
(add-hook 'org-src-mode-hook 'flycheck-mode 0)

(with-eval-after-load 'org (global-org-modern-mode))
(after! org
  (setq org-modern-star '("◉" "○" "◈" "◇" "✳")
        org-modern-hide-stars 'leading ;; can be nil,t,leading
        org-modern-todo nil
        org-modern-progress nil
        org-modern-tag nil))

(after! org
  (setq org-agenda-include-diary t
        org-agenda-timegrid-use-ampm 1
        org-startup-indented t
        org-pretty-entities t
        org-hide-emphasis-markers t
        org-startup-with-inline-images t
        org-image-actual-width '(300)))

;; un-hide emphasis-markers when under point ;;;;
(add-hook 'org-mode-hook 'org-appear-mode)
(add-hook 'org-mode-hook 'variable-pitch-mode)

;; set font size for headers ;;
(after! org
  (custom-set-faces
   '(org-level-1 ((t (:inherit outline-1 :height 1.4))))
   '(org-level-2 ((t (:inherit outline-2 :height 1.1))))
   '(org-level-3 ((t (:inherit outline-3 :height 1.0))))
   '(org-level-4 ((t (:inherit outline-4 :height 1.0))))
   '(org-level-5 ((t (:inherit outline-5 :height 1.0))))
   '(org-document-title ((t (:height 1.7 :underline t))))
   ))

;; set `color' of emphasis types ;;;;
(after! org
  (setq org-emphasis-alist
        '(("*" my-org-emphasis-bold)
          ("/" italic)
          ("_" underline)
          ("=" org-verbatim verbatim)
          ("~" org-code verbatim)
          ("+" (:strike-through t)))))

(defface my-org-emphasis-bold
  '((default :inherit bold)
    (((class color) (min-colors 88) (background light))
     :foreground "#a60000")
    (((class color) (min-colors 88) (background dark))
     :foreground "#ff8059"))
  "My bold emphasis for Org."
  :group 'custom-faces)

(defface my-org-emphasis-italic
  '((default :inherit italic)
    (((class color) (min-colors 88) (background light))
     :foreground "#005e00")
    (((class color) (min-colors 88) (background dark))
     :foreground "#44bc44"))
  "My italic emphasis for Org."
  :group 'custom-faces)

(defface my-org-emphasis-underline
  '((default :inherit underline)
    (((class color) (min-colors 88) (background light))
     :foreground "#813e00")
    (((class color) (min-colors 88) (background dark))
     :foreground "#d0bc00"))
  "My underline emphasis for Org."
  :group 'custom-faces)

(defface my-org-emphasis-strike-through
  '((((class color) (min-colors 88) (background light))
     :strike-through "#972500" :foreground "#505050")
    (((class color) (min-colors 88) (background dark))
     :strike-through "#ef8b50" :foreground "#a8a8a8"))
  "My strike-through emphasis for Org."
  :group 'custom-faces)

;; brings up a buffer for capturing
;; org-capture-templates will be put in org-capture-projects-local
(defun set-org-capture-templates ()
  (setq org-capture-templates
        '(("t" "Personal todo" entry
           (file+headline +org-capture-todo-file "Inbox")
           "** TODO %?\n%i\n%a" :prepend t)
          ("z" "organizer" entry
           (file+headline "~/org/organizer.org" "refile stuff")
           "** NEW %?\n  %i\n  " :prepend t)
          ("y" "tilt" entry
           (file+headline "~/org/wiki/tilt-doom.org" "TILT")
           "** NEW %?\n  %i\n  " :prepend t)
          ("s" "journal-schedule" plain #'org-journal-date-location
           "** TODO %?\n <%(princ org-journal--date-location-scheduled-time)>\n" :jump-to-captured t)
          ("j" "Journal entry" plain #'org-journal-find-location
           "** %(format-time-string org-journal-time-format)%?" :prepend t)
          ("k" "keybindings" entry
           (file+headline "~/org/wiki/my-keybinding-list.org" "new ones")
           "** NEW %?\n  %i\n  " :prepend t)
          ("x" "webmarks" entry
           (file+headline "~/org/webmarks.org" "bookmarks")
           "- %(org-cliplink-capture)\n" :prepend t)
          ("l" "check out later" entry
           (file+headline "todo.org" "Check out later")
           "** IDEA %?\n%i\n%a" :prepend t)
          ("n" "Personal notes" entry
           (file+headline +org-capture-notes-file "Inbox")
           "*  %?\n%i\n%a" :prepend t)
          ("p" "Templates for projects")
          ("pt" "Project-local todo" entry
           (file+headline +org-capture-project-todo-file "Inbox")
           "* TODO %?\n%i\n%a" :prepend t)
          ("pn" "Project-local notes" entry
           (file+headline +org-capture-project-notes-file "Inbox")
           "* %U %?\n%i\n%a" :prepend t)
          ("pc" "Project-local changelog" entry
           (file+headline +org-capture-project-changelog-file "Unreleased")
           "* %U %?\n%i\n%a" :prepend t)
          ("o" "Centralized templates for projects")
          ("ot" "Project todo" entry
           #'+org-capture-central-project-todo-file
           "* TODO %?\n %i\n %a" :heading "Tasks" :prepend nil)
          ("on" "Project notes" entry
           #'+org-capture-central-project-notes-file
           "* %U %?\n %i\n %a" :prepend t :heading "Notes")
          ("oc" "Project changelog" entry
           #'+org-capture-central-project-changelog-file
           "* %U %?\n %i\n %a" :prepend t :heading "Changelog"))))


(add-hook 'org-mode-hook #'set-org-capture-templates)

(use-package! org-journal
  :defer t
  :init
  ;; HACK `org-journal' adds a `magic-mode-alist' entry for detecting journal
  ;;      files, but this causes us lazy loaders a big problem: an unacceptable
  ;;      delay on the first file the user opens, because calling the autoloaded
  ;;      `org-journal-is-journal' pulls all of `org' with it. So, we replace it
  ;;      with our own, extra layer of heuristics.
  (add-to-list 'magic-mode-alist '(+org-journal-p . org-journal-mode))

  (defun +org-journal-p ()
    "Wrapper around `org-journal-is-journal' to lazy load `org-journal'."
    (when-let (buffer-file-name (buffer-file-name (buffer-base-buffer)))
      (if (or (featurep 'org-journal)
              (and (file-in-directory-p
                    buffer-file-name (expand-file-name org-journal-dir org-directory))
                   (require 'org-journal nil t)))
          (org-journal-is-journal))))

  ;; `org-journal-dir' defaults to "~/Documents/journal/", which is an odd
  ;; default, so we change it to {org-directory}/journal (we expand it after
  ;; org-journal is loaded).
  (setq org-journal-dir "journal/"
        org-journal-cache-file (concat doom-cache-dir "org-journal"))

  :config
  (setq org-journal-file-type 'daily)
  (setq org-journal-date-format "%A, %d %B %Y")
  ;; Remove the orginal journal file detector and rely on `+org-journal-p'
  ;; instead, to avoid loading org-journal until the last possible moment.
  (setq magic-mode-alist (assq-delete-all 'org-journal-is-journal magic-mode-alist))

  (setq org-journal-dir (expand-file-name org-journal-dir org-directory)
        org-journal-find-file-fn #'find-file)

  (setq org-journal-enable-agenda-integration t)
  ;; Setup carryover to include all configured TODO states. We cannot carry over
  (setq org-journal-carryover-items  "TODO=\"TODO\"|TODO=\"PROJ\"|TODO=\"STRT\"|TODO=\"WAIT\"|TODO=\"HOLD\"")

  (add-hook 'org-journal-mode-hook #'my/org-journal-mode-hook)
  (map! (:map org-journal-mode-map
         :n "]f"  #'org-journal-next-entry
         :n "[f"  #'org-journal-previous-entry
         :n "C-n" #'org-journal-next-entry
         :n "C-p" #'org-journal-previous-entry)
        (:map org-journal-search-mode-map
         "C-n" #'org-journal-search-next
         "C-p" #'org-journal-search-previous)
        :localleader
        (:map org-journal-mode-map
         (:prefix "j"
          "c" #'org-journal-new-entry
          "d" #'org-journal-new-date-entry
          "n" #'org-journal-next-entry
          "p" #'org-journal-previous-entry)
         (:prefix "s"
          "s" #'org-journal-search
          "f" #'org-journal-search-forever
          "F" #'org-journal-search-future
          "w" #'org-journal-search-calendar-week
          "m" #'org-journal-search-calendar-month
          "y" #'org-journal-search-calendar-year))
        (:map org-journal-search-mode-map
         "n" #'org-journal-search-next
         "p" #'org-journal-search-prev)))

;; function needed to make an org-capture-template for org-journal
(defun org-journal-find-location ()
  (org-journal-new-entry t)
  (unless (eq org-journal-file-type 'daily)
    (org-narrow-to-subtree))
  (goto-char (point-max)))

(defvar org-journal--date-location-scheduled-time nil)
;; function to schedule things using capture templates
(defun org-journal-date-location (&optional scheduled-time)
  (let ((scheduled-time (or scheduled-time (org-read-date nil nil nil "Date:"))))
    (setq org-journal--date-location-scheduled-time scheduled-time)
    (org-journal-new-entry t (org-time-string-to-time scheduled-time))
    (unless (eq org-journal-file-type 'daily)
      (org-narrow-to-subtree))
    (goto-char (point-max))))

(defun my/org-journal-mode-hook ()
    "Hooks for org-journal-mode."
  (flyspell-mode)
  (auto-fill-mode)
  (doom-disable-line-numbers-h)
  (turn-on-visual-line-mode)
  (+zen/toggle))

;; save and exit journal easily
(map! :after org
      :map org-journal-mode-map
      :desc "doom save and kill" "C-c C-c" #'doom/save-and-kill-buffer)

(setq +calendar-open-function #'+calendar/my-open-calendar)

;;;###autoload
(defun +calendar/my-open-calendar ()
  "change calendar sources"
  (interactive)
  (cfw:open-calendar-buffer
   ;; :custom-map cfw:my-cal-map
   :contents-sources
   (list
    (cfw:org-create-source "Green")  ; org-agenda source
    (cfw:org-create-file-source "cal" "~/org/notable-dates.org" "Cyan")  ; other org source
    (cfw:cal-create-source "Orange") ; diary source
    ;; (cfw:ical-create-source "Moon" "~/moon.ics" "Gray")  ; ICS source1
    )))

;; change calendar sources
;; By defining your own calendar commands, you can control what sources to pull
;; calendar data from:
;; example in ~/.config/emacs/modules/app/calendar/README.org

;; (use-package flyspell-correct
;;   :after flyspell
;;   :bind (:map flyspell-mode-map ("C-;" . flyspell-correct-wrapper)))

;; (define-key! flyspell-mode-map "C-;" #'flyspell-correct-wrapper)
(define-key! [remap flyspell-auto-correct-previous-word] #'flyspell-correct-wrapper)

(setq flyspell-persistent-highlight nil)

(setq flyspell-issue-message-flag nil)

(setq ispell-personal-dictionary "/home/dvsdude/.aspell.en_CA.pws")
(setq ispell-program-name "aspell")
(setq ispell-extra-args '("--repl" "~/aspell.prepl"))

;; this is grabbed from Dooms config
(use-package! evil-surround
  :commands (global-evil-surround-mode
             evil-surround-edit
             evil-Surround-edit
             evil-surround-region)
  :config (global-evil-surround-mode 1))
(add-hook 'org-mode-hook (lambda ()
                           (push '(?= . ("=" . "=")) evil-surround-pairs-alist)))

(evil-embrace-disable-evil-surround-integration)

;; Using Doom config
(use-package! evil-snipe
  :commands evil-snipe-local-mode evil-snipe-override-local-mode
  :hook (doom-first-input . evil-snipe-override-mode)
  :hook (doom-first-input . evil-snipe-mode)
  :init
  (setq evil-snipe-smart-case t
        evil-snipe-scope 'line
        evil-snipe-repeat-scope 'visible
        evil-snipe-char-fold t))
(evil-snipe-mode t)
(evil-snipe-override-mode 1)

;; evil-snipe
 (map! :after evil-snipe
       :map evil-snipe-parent-transient-map
       "C-;" (cmd! (require 'evil-easymotion)
                   (call-interactively
                    (evilem-create #'evil-snipe-repeat
                                   :bind ((evil-snipe-scope 'whole-buffer)
                                          (evil-snipe-enable-highlight)
                                          (evil-snipe-enable-incremental-highlight))))))
(push '(?\[ "[[{(]") evil-snipe-aliases)
(add-hook 'magit-mode-hook 'turn-off-evil-snipe-override-mode)

(map! :leader
      :prefix "s"
      :desc "avy goto char timer" "a" #'evil-avy-goto-char-timer)

(map! :leader
      :prefix "j"
      :desc "avy goto next line" "j" #'evilem-motion-next-line)
(map! :leader
      :prefix "k"
      :desc "avy goto prev line" "k" #'evilem-motion-previous-line)
(setq avy-timeout-seconds 1.0) ;;default 0.5
(setq avy-single-candidate-jump t)

;; evil-easymotion "prefix"
(evilem-default-keybindings "C-c a")
;; (evilem-default-keybindings "SPC")

;;;###autoload
(defun +corfu-smart-sep-toggle-escape ()
  "Insert `corfu-separator' or toggle escape if it's already there."
  (interactive)
  (cond ((and (char-equal (char-before) corfu-separator)
              (char-equal (char-before (1- (point))) ?\\))
         (save-excursion (delete-char -2)))
        ((char-equal (char-before) corfu-separator)
         (save-excursion (backward-char 1)
                         (insert-char ?\\)))
        (t (call-interactively #'corfu-insert-separator))))


(defvar +corfu-want-ret-to-confirm t
  "Configure how the user expects RET to behave.
Possible values are:
- t (default): Insert candidate if one is selected, pass-through otherwise;
- `minibuffer': Insert candidate if one is selected, pass-through otherwise,
              and immediatelly exit if in the minibuffer;
- nil: Pass-through without inserting.")

(defvar +corfu-buffer-scanning-size-limit (* 1 1024 1024) ; 1 MB
  "Size limit for a buffer to be scanned by `cape-dabbrev'.")

(use-package! corfu
  :hook (doom-first-input . global-corfu-mode)
  :bind
  (:map corfu-map
        ("TAB" . corfu-next)
        ([tab] . corfu-next)
        ("S-TAB" . corfu-previous)
        ([backtab] . corfu-previous)
        ("RET" . nil))
  :config
  (setq corfu-auto t
        corfu-auto-delay 0.18
        corfu-auto-prefix 3
        global-corfu-modes '((not erc-mode
                              circe-mode
                              help-mode
                              gud-mode
                              vterm-mode)
                             t)
        corfu-cycle t
        corfu-preselect 'prompt
        corfu-count 6
        corfu-max-width 120
        corfu-on-exact-match nil
        corfu-quit-at-boundary 'separator
        corfu-quit-no-match corfu-quit-at-boundary
        tab-always-indent 'complete)
  (add-to-list 'completion-category-overrides `(lsp-capf (styles ,@completion-styles)))
  (add-to-list 'corfu-auto-commands #'lispy-colon)
  (add-to-list 'corfu-continue-commands #'+corfu-smart-sep-toggle-escape)
  (add-hook 'evil-insert-state-exit-hook #'corfu-quit))

;; Enable auto completion and configure quitting
(use-package! orderless
  :config
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles orderless partial-completion)))
        orderless-component-separator #'orderless-escapable-split-on-space)
  (set-face-attribute 'completions-first-difference nil :inherit nil))

;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package! savehist
  ;; persist variables across sessions
  :defer-incrementally custom
  :hook (doom-first-input . savehist-mode)
  :custom (savehist-file (concat doom-cache-dir "savehist"))
  :config
  (setq savehist-save-minibuffer-history t
        savehist-autosave-interval nil     ; save on kill only
        savehist-additional-variables
        '(kill-ring                        ; persist clipboard
          register-alist                   ; persist macros
          mark-ring global-mark-ring       ; persist marks
          search-ring regexp-search-ring)) ; persist searches
  (add-hook! 'savehist-save-hook
    (defun doom-savehist-unpropertize-variables-h ()
      "Remove text properties from `kill-ring' to reduce savehist cache size."
      (setq kill-ring
            (mapcar #'substring-no-properties
                    (cl-remove-if-not #'stringp kill-ring))
            register-alist
            (cl-loop for (reg . item) in register-alist
                     if (stringp item)
                     collect (cons reg (substring-no-properties item))
                     else collect (cons reg item))))
    (defun doom-savehist-remove-unprintable-registers-h ()
      "Remove unwriteable registers (e.g. containing window configurations).
Otherwise, `savehist' would discard `register-alist' entirely if we don't omit
the unwritable tidbits."
      ;; Save new value in the temp buffer savehist is running
      ;; `savehist-save-hook' in. We don't want to actually remove the
      ;; unserializable registers in the current session!
      (setq-local register-alist
                  (cl-remove-if-not #'savehist-printable register-alist)))))

;; corfu history
(use-package! corfu-history
  :hook ((corfu-mode . corfu-history-mode))
  :config
  (after! savehist (add-to-list 'savehist-additional-variables 'corfu-history)))

(use-package! cape
  :defer t
  :init
  (add-hook! 'text-mode-hook
    (defun +corfu-add-cape-dict-h ()
      (add-hook 'completion-at-point-functions #'cape-dict -15 t)))
  (add-hook! 'prog-mode-hook
    (defun +corfu-add-cape-file-h ()
      (add-hook 'completion-at-point-functions #'cape-file -10 t)))
  (add-hook! '(org-mode-hook markdown-mode-hook)
    (defun +corfu-add-cape-elisp-block-h ()
      (add-hook 'completion-at-point-functions #'cape-elisp-block 0 t)))
  ;; Enable Dabbrev completion basically everywhere as a fallback.
    (setq cape-dabbrev-check-other-buffers t)
    ;; Set up `cape-dabbrev' options.
    (defun +dabbrev-friend-buffer-p (other-buffer)
      (< (buffer-size other-buffer) +corfu-buffer-scanning-size-limit))
    (add-hook! '(prog-mode-hook
                 text-mode-hook
                 conf-mode-hook
                 comint-mode-hook
                 minibuffer-setup-hook
                 eshell-mode-hook)
      (defun +corfu-add-cape-history-h ()
        (add-hook 'completion-at-point-functions #'cape-history -5 t)))
    (add-hook! '(prog-mode-hook
                 text-mode-hook
                 conf-mode-hook
                 comint-mode-hook
                 minibuffer-setup-hook
                 eshell-mode-hook)
      (defun +corfu-add-cape-dabbrev-h ()
        (add-hook 'completion-at-point-functions #'cape-dabbrev 20 t)))
    (after! dabbrev
      (setq dabbrev-friend-buffer-function #'+dabbrev-friend-buffer-p
            dabbrev-ignored-buffer-regexps
            '("\\` "
              "\\(TAGS\\|tags\\|ETAGS\\|etags\\|GTAGS\\|GRTAGS\\|GPATH\\)\\(<[0-9]+>\\)?")
            dabbrev-upcase-means-case-search t)
      (add-to-list 'dabbrev-ignored-buffer-modes 'pdf-view-mode)
      (add-to-list 'dabbrev-ignored-buffer-modes 'doc-view-mode)
      (add-to-list 'dabbrev-ignored-buffer-modes 'tags-table-mode))

  ;; Make these capfs composable.
  (advice-add #'lsp-completion-at-point :around #'cape-wrap-noninterruptible)
  (advice-add #'lsp-completion-at-point :around #'cape-wrap-nonexclusive)
  (advice-add #'comint-completion-at-point :around #'cape-wrap-nonexclusive)
  (advice-add #'eglot-completion-at-point :around #'cape-wrap-nonexclusive)
  (advice-add #'pcomplete-completions-at-point :around #'cape-wrap-nonexclusive))

;; Example configuration for Consult
;; (use-package consult
;;   ;; Replace bindings. Lazily loaded due by `use-package'.
;;   :bind (;; C-c bindings in `mode-specific-map'
;;          ("C-c M-x" . consult-mode-command)
;;          ("C-c h" . consult-history)
;;          ("C-c k" . consult-kmacro)
;;          ("C-c m" . consult-man)
;;          ("C-c i" . consult-info)
;;          ([remap Info-search] . consult-info)
;;          ;; C-x bindings in `ctl-x-map'
;;          ("C-x M-:" . consult-complex-command)     ;; orig. repeat-complex-command
;;          ("C-x b" . consult-buffer)                ;; orig. switch-to-buffer
;;          ("C-x 4 b" . consult-buffer-other-window) ;; orig. switch-to-buffer-other-window
;;          ("C-x 5 b" . consult-buffer-other-frame)  ;; orig. switch-to-buffer-other-frame
;;          ("C-x r b" . consult-bookmark)            ;; orig. bookmark-jump
;;          ("C-x p b" . consult-project-buffer)      ;; orig. project-switch-to-buffer
;;          ;; Custom M-# bindings for fast register access
;;          ("M-#" . consult-register-load)
;;          ("M-'" . consult-register-store)          ;; orig. abbrev-prefix-mark (unrelated)
;;          ("C-M-#" . consult-register)
;;          ;; Other custom bindings
;;          ("M-y" . consult-yank-pop)                ;; orig. yank-pop
;;          ;; M-g bindings in `goto-map'
;;          ("M-g e" . consult-compile-error)
;;          ("M-g f" . consult-flymake)               ;; Alternative: consult-flycheck
;;          ("M-g g" . consult-goto-line)             ;; orig. goto-line
;;          ("M-g M-g" . consult-goto-line)           ;; orig. goto-line
;;          ("M-g o" . consult-outline)               ;; Alternative: consult-org-heading
;;          ("M-g m" . consult-mark)
;;          ("M-g k" . consult-global-mark)
;;          ("M-g i" . consult-imenu)
;;          ("M-g I" . consult-imenu-multi)
;;          ;; M-s bindings in `search-map'
;;          ("M-s d" . consult-find)                  ;; Alternative: consult-fd
;;          ("M-s D" . consult-locate)
;;          ("M-s g" . consult-grep)
;;          ("M-s G" . consult-git-grep)
;;          ("M-s r" . consult-ripgrep)
;;          ("M-s l" . consult-line)
;;          ("M-s L" . consult-line-multi)
;;          ("M-s k" . consult-keep-lines)
;;          ("M-s u" . consult-focus-lines)
;;          ;; Isearch integration
;;          ("M-s e" . consult-isearch-history)
;;          :map isearch-mode-map
;;          ("M-e" . consult-isearch-history)         ;; orig. isearch-edit-string
;;          ("M-s e" . consult-isearch-history)       ;; orig. isearch-edit-string
;;          ("M-s l" . consult-line)                  ;; needed by consult-line to detect isearch
;;          ("M-s L" . consult-line-multi)            ;; needed by consult-line to detect isearch
;;          ;; Minibuffer history
;;          :map minibuffer-local-map
;;          ("M-s" . consult-history)                 ;; orig. next-matching-history-element
;;          ("M-r" . consult-history)))                ;; orig. previous-matching-history-element


(map! :prefix ("M-s i" . "consult-info")
      :desc "consult info emacs"
      :n "e" #'consult-info-emacs
      :desc "consult info org"
      :n "o" #'consult-info-org
      :desc "consult-info-completion"
      :n "c" #'consult-info-completion)

(defun consult-info-emacs ()
    "Search through Emacs info pages."
  (interactive)
  (consult-info "emacs" "efaq" "elisp" "cl"))

(defun consult-info-org ()
    "Search through the Org info page."
  (interactive)
  (consult-info "org"))

(defun consult-info-completion ()
    "Search through completion info pages."
  (interactive)
  (consult-info  "orderless" "embark"
                "corfu" "cape" "tempel"))

;; Insert a file link. At the prompt, enter the filename
(defun +org-insert-file-link ()
  (interactive)
  (insert (format "[[%s]]" (org-link-complete-file))))
;; `map': insert-file-link (space f L)
(map! :after org
      :map org-mode-map
      :leader
      (:prefix "f"
       :desc "create link to file" "L" #'+org-insert-file-link))

;; set transparency interactivly
(defun transparency (value)
  "Sets the transparency of the frame window. 0=transparent/100=opaque"
  (interactive "nTransparency Value 0 - 100 opaque:")
  (set-frame-parameter (selected-frame) 'alpha-background value))

(map! :leader
     (:prefix ("t" . "toggle")
      :desc "toggle transparency" "T" #'transparency))

;; Comment or uncomment the current line
(defun my/comment-line ()
  ;; "Comment or uncomment the current line."
  (interactive)
  (save-excursion
    (if (use-region-p)
        (comment-or-uncomment-region (region-beginning) (region-end))
      (push-mark (beginning-of-line) t t)
      (end-of-line)
      (comment-dwim nil))))
(map! :desc "comment or uncomment"
      :n "M-;" #'my/comment-line)

;; this keeps the workspace-bar visable
(after! persp-mode
  (defun display-workspaces-in-minibuffer ()
    (with-current-buffer " *Minibuf-0*"
      (erase-buffer)
      (insert (+workspace--tabline))))
  (run-with-idle-timer 1 t #'display-workspaces-in-minibuffer)
  (+workspace/display))

;;;###autoload
(defun =config ()
  "Open your private config.el file."
  (interactive)
  (find-file (expand-file-name "config.org" doom-user-dir)))

(defun dvs/zen-scratch-pad ()
   "Create a new org-mode buffer for random stuff."
   (interactive)
   (let ((buffer (generate-new-buffer "org-scratchy")))
     (switch-to-buffer buffer)
     (setq buffer-offer-save t)
     (org-mode)
     (auto-fill-mode)
     (doom-disable-line-numbers-h)
     (turn-on-visual-line-mode)
     (+zen/toggle)))

(map! :leader
      :prefix "o"
      :desc "open zen scratch"
      "X" #'dvs/zen-scratch-pad)

(defun my-make-new-buffer ()
  (interactive)
  (let ((buffer (generate-new-buffer "*new*")))
    (set-window-buffer nil buffer)
    (with-current-buffer buffer
      (funcall (default-value 'major-mode))
      (setq doom-real-buffer-p t))))

(map! :leader
      :prefix "n"
      :desc "make new buffer"
      "b" #'my-make-new-buffer)

;; https://tecosaur.github.io/emacs-config/config.html#org-buffer-creation
(evil-define-command +evil-buffer-org-new (_count file)
  "Creates a new ORG buffer replacing the current window, optionally
   editing a certain FILE"
  :repeat nil
  (interactive "P<f>")
  (if file
      (evil-edit file)
    (let ((buffer (generate-new-buffer "*new org*")))
      (set-window-buffer nil buffer)
      (with-current-buffer buffer
        (org-mode)
        (auto-fill-mode)
        (setq-local doom-real-buffer-p t)))))

;; new-org-buffer (space b o)
(map! :leader
      :prefix "b"
      :desc "New empty Org buffer" "o" #'+evil-buffer-org-new)

(defun org-table-strip-table-at-point ()
  (interactive)
  (let* ((table (delete 'hline (org-table-to-lisp)))
     (contents (orgtbl-to-generic
            table '(:sep "\t"))))
    (goto-char (org-table-begin))
    (re-search-forward "|")
    (backward-char)
    (delete-region (point) (org-table-end))
    (insert contents)))

;;;###autoload
;; add time only on fullscreen
(defun bram85-show-time-for-fullscreen (frame)
  "Show the time in the modeline when the FRAME becomes full screen."
  (let ((fullscreen (frame-parameter frame 'fullscreen)))
    (if (memq fullscreen '(fullscreen fullboth))
        (display-time-mode 1)
      (display-time-mode -1))))

(add-hook 'window-size-change-functions #'bram85-show-time-for-fullscreen)

;; (zone-when-idle 60)

(beacon-mode t)

(setq plantuml-jar-path "/usr/share/java/plantuml/plantuml.jar")
  ;; Enable plantuml-mode for PlantUML files
(add-to-list 'auto-mode-alist '("\\.plantuml\\'" . plantuml-mode))
  ;; Enable exporting
(org-babel-do-load-languages 'org-babel-load-languages '((plantuml . t)))

(require 'org-web-tools)
;; use to download webpage text content
;; (use-package! org-web-tools)

(use-package! hnreader
  :after elfeed)

(use-package! org-xournalpp
  :defer t
  :config
  (add-hook 'org-mode-hook 'org-xournalpp-mode))

(use-package! journalctl-mode
  :defer t)

;; org-keybindings

(map! :after org
      :leader
      :prefix ("o" . "open")
      :desc "open org config"
      :n "i" (lambda () (interactive) (find-file "~/.config/doom/config.org"))
      ;; jump to todo.org
      :desc "open org todos"
      :n "t" (lambda () (interactive) (find-file "~/org/todo.org"))
      ;; jump to notes.org
      :desc "open org notes"
      :n "n" (lambda () (interactive) (find-file "~/org/notes.org"))
      ;; jump to org organizer
      :desc "open org organizer"
      :n "0" (lambda () (interactive) (find-file "~/org/organizer.org"))
      ;; jump to org folder
      :desc "open org Directory"
      :n "o" (lambda () (interactive) (find-file "~/org/"))
      ;; jump to org wiki folder
      :desc "open org wiki"
      :n "k" (lambda () (interactive) (find-file "~/org/wiki/")))

;; demarcate or create source-block
(map! :after org
      :leader
      :prefix "d"
      :desc "demarcate/create source-block"
      :n "b" #'org-babel-demarcate-block)
;; cycle agenda files
(map! :after org
      :leader
      :prefix ("o" . "open")
      :desc "cycle agenda files"
      :n "a f" #'org-cycle-agenda-files)
;; open config in named workspace
(map! :after org
      :leader
      :prefix ("o" . "open")
      :desc "open calendar"
      :n "c" #'=calendar)
;; read url's readable content to org buffer
(map! :leader
      :prefix "i"
      :desc "websites-content to org" "w" #'org-web-tools-read-url-as-org)
;; list-processes
(map! :leader
      :prefix "l"
      :desc "list processes" "p" #'list-processes)
;; adds selected text to chosen buffer
(map! :leader
      :prefix "i"
      :desc "append to buffer" "t" #'append-to-buffer)
;; adds entire buffer to chosen buffer
(map! :leader
      :prefix "i"
      :desc "insert buffer at point" "b" #'insert-buffer)
;; toggle vertico-grid-mode
(map! :leader
      :prefix "t"
      :desc "toggle vertico grid"
      :n "g" 'vertico-grid-mode
      :desc "toggle eshell"
      :n "e" #'+eshell/toggle)
;; toggle default-scratch buffer
(map! :leader
      :prefix ("o" . "open")
      :desc "open defalt scratch-buffer"
      :n "x" #'scratch-buffer)

;; start org-mpv-notes-mode
(map! "<f5> n" #'org-mpv-note)
;; (defhydra hydra-mpv (global-map "<f5> m")
;; dictioary-lookup-definition better than spc s t
(map! "M-*" #'dictionary-lookup-definition)
(map! "M-s d" #'dictionary-lookup-definition)
(map! "M-s h" #'consult-history)
(map! "<f7>" #'dictionary-lookup-definition)
;; fetches selected text and gives you a list of synonyms to replace it with
(map! "M-&" #'powerthesaurus-lookup-word-dwim)
;; close other window ;;;;
(map! "C-1" #'delete-other-windows)
;; switch other window
(map! "C-2" #'switch-to-buffer-other-window)
;; Minibuffer history
(map! "C-c h" #'consult-history)
;; tranpose function for missed punctuation
(map! "C-c t" #'transpose-chars)
;; insert structural template
(map! "C-c b" #'org-insert-structure-template)
;; ;; start modes
(map! :prefix ("C-c m" . "mode command")
      "o" #'org-mode
      "i" #'lisp-interaction-mode
      "e" #'emacs-lisp-mode
      "f" #'fundamental-mode)
;; Make `v$' not include the newline character ;;;;
(general-define-key
:states '(visual state)
"$" '(lambda ()
        (interactive)
        (evil-end-of-line)))

(use-package! key-chord
  :defer t
  :init
  (key-chord-mode 1))
;; Exit insert mode by pressing j and then j quickly
;; Max time delay between two key presses to be considered a key chord
(setq key-chord-two-keys-delay 0.1) ; default 0.1
;; Max time delay between two presses of the same key to be considered a key chord.
;; Should normally be a little longer than;key-chord-two-keys-delay.
(setq key-chord-one-key-delay 0.2) ; default 0.2
;; (key-chord-define evil-insert-state-map "hb" '+default--delete-backward-char-a)
(key-chord-define evil-insert-state-map "jn" '+default--delete-backward-char-a)
(key-chord-define evil-insert-state-map "gb" 'transpose-chars)
(key-chord-define evil-insert-state-map "ji" 'backward-kill-word)
(key-chord-define evil-normal-state-map "vv" 'evil-visual-line)
(key-chord-define evil-normal-state-map "cx" 'evilnc-comment-or-uncomment-lines)

;; this should help with paging in which-key
;; NOTE #1 commented this out doom says it is a problem and "?" and <f1> should work
;; will give it a go,
;; (setq which-key-use-C-h-commands t)

;; delay
(setq which-key-idle-delay 1.5)

;; (which-key-setup-minibuffer)
(which-key-setup-side-window-bottom)
;;(which-key-setup-side-window-right)
;;(which-key-setup-side-window-right-bottom)
;; (setq which-key-use-C-h-commands nil)

;; mpv commands

;; make mpv type link
(defun org-mpv-complete-link (&optional arg)
  (replace-regexp-in-string
   "file:" "mpv:"
   (org-link-complete-file arg)
   t t))
(org-link-set-parameters "mpv"
  :follow #'mpv-play :complete #'org-mpv-complete-link)

;; mpv-play-clipboard - play url from clipboard
(defun mpv-play-clipboard ()
  "Start an mpv process playing the video stream at URL."
  (interactive)
  (let ((url (current-kill 0 t)))
  (unless (mpv--url-p url)
    (user-error "Invalid argument: `%s' (must be a valid URL)" url))
  (if (not mpv--process)
      ;; mpv isnt running play file
      (mpv-start url)
      ;; mpv running append file to playlist
    (mpv--playlist-append url))))

;; frame step forward
(with-eval-after-load 'mpv
  (defun mpv-frame-step ()
    "Step one frame forward."
    (interactive)
    (mpv--enqueue '("frame-step") #'ignore)))


;; frame step backward
(with-eval-after-load 'mpv
  (defun mpv-frame-back-step ()
    "Step one frame backward."
    (interactive)
    (mpv--enqueue '("frame-back-step") #'ignore)))


;; mpv take a screenshot
(with-eval-after-load 'mpv
  (defun mpv-screenshot ()
    "Take a screenshot"
    (interactive)
    (mpv--enqueue '("screenshot") #'ignore)))


;; mpv show osd
(with-eval-after-load 'mpv
  (defun mpv-osd ()
    "Show the osd"
    (interactive)
    (mpv--enqueue '("set_property" "osd-level" "3") #'ignore)))


;; add a newline in the current document
(defun end-of-line-and-indented-new-line ()
  (interactive)
  (end-of-line)
  (newline-and-indent))

;; mpv-hydra ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defhydra hydra-mpv (global-map "<f5> m")
  "
  ^Seek^                    ^Actions^                ^General^
  ^^^^^^^^---------------------------------------------------------------------------
  _h_: seek back -5         _,_: back frame          _i_: insert playback position
  _j_: seek back -60        _._: forward frame       _n_: insert a newline
  _k_: seek forward 60      _SPC_: pause             _s_: take a screenshot
  _l_: seek forward 5       _q_: quit mpv            _o_: show the osd
  ^
  "
  ("h" mpv-seek-backward "-5")
  ("j" mpv-seek-backward "-60")
  ("k" mpv-seek-forward "60")
  ("l" mpv-seek-forward "5")
  ("," mpv-frame-back-step)
  ("." mpv-frame-step)
  ("SPC" mpv-pause)
  ("q" mpv-kill)
  ("s" mpv-screenshot)
  ("i" mpv-insert-playback-position)
  ("o" mpv-osd)
  ("n" end-of-line-and-indented-new-line))

(after! org
(use-package! org-media-note
  :hook (org-mode .  org-media-note-mode)
  :bind (("<f5> n" . org-media-note-hydra/body))  ;; Main entrance
  :config
  (setq org-media-note-screenshot-image-dir "~/pictures/")))  ;; Folder to save screenshot

;; ;; start org-mpv-notes-mode
;; (map! "<f5> n" #'org-mpv-note)

;; ;; this is mostly the original that worked
(defun my/mpv-play-url (&optional url &rest args)
  "Start mpv for URL ARGS."
  (interactive (browse-url-interactive-arg "URL: "))
  (mpv-start url))

(defun elfeed-open-hnreader-url (url &optional new-window)
  "Open HN-comments URL in a NEW-WINDOW as a org-buffer."
  ;; (interactive)
  (interactive (browse-url-interactive-arg "URL: "))
  (hnreader-comment url))

;; open links in eww
(defun dvs-eww (url &optional arg)
    "Pass URL to appropriate client"
  (interactive
   (list (browse-url-interactive-arg "URL: ")
         current-prefix-arg))
  (let ((url-parsed (url-generic-parse-url url)))
    (pcase (url-type url-parsed)
            (_ (eww url arg)))))

(setq browse-url-handlers
      '(("\\.\\(gifv?\\|avi\\|AVI\\|mp[4g]\\|MP4\\|MP3\\|webm\\)$" . my/mpv-play-url)
        ("^https?://\\(www\\.youtube\\.com\\|youtu\\.be\\)/" . my/mpv-play-url)
        ("^https?://\\(odysee\\.com\\|rumble\\.com\\)/" . my/mpv-play-url)
        ("^https?://\\(off-guardian.org\\|.substack\\.com\\|tomluongo\\.me\\)/" . dvs-eww)
        ;; ("^https?://\\(emacs.stackexchange.com\\|news.ycombinator.com\\)/" . dvs-eww)
        ("^https?://\\(news.ycombinator.com\\)/" . elfeed-open-hnreader-url)
        ("." . browse-url-default-browser)))
;; * NOTE this `was' a customized variable

(use-package! youtube-sub-extractor
  :defer t
  :commands
  (youtube-sub-extractor-extract-subs)
  :config
  (map! :map youtube-sub-extractor-subtitles-mode-map
      :desc "copy timestamp URL"
      :n "RET" #'youtube-sub-extractor-copy-ts-link
      :desc "browse at timestamp"
      :n "C-c C-o" #'youtube-sub-extractor-browse-ts-link))

(setq youtube-sub-extractor-timestamps 'left-margin)
(setq youtube-sub-extractor-min-chunk-size 30)

(require 'thingatpt)
(defun youtube-sub-extractor-extract-subs-at-point ()
   "extract subtitles from a youtube link at point"
(interactive)
(youtube-sub-extractor-extract-subs (thing-at-point-url-at-point)))

(map! :leader
      :prefix "v"
      :desc "YouTube subtitles"
      :n "E" #'youtube-sub-extractor-extract-subs)

(map! :leader
      :prefix "v"
      :desc "YouTube subtitles at point"
      :n "e" #'youtube-sub-extractor-extract-subs-at-point)

(require 'yeetube)
(setq yeetube-download-directory "~/Videos")

(map! :map yeetube-mode-map
     [remap evil-ret] #'yeetube-play)

(map! :leader
      :prefix "s"
      :desc "search yeetube" "y" #'yeetube-search)

(use-package spray
  ;; :load-path "~/builds/manual-packages/spray"
  :defer t
  :commands (spray-mode)
  :config
  (setq spray-wpm 220
        spray-height 800))

(defun spray-mode-hide-cursor ()
    "Hide or unhide the cursor as is appropriate."
    (if spray-mode
        (setq-local spray--last-evil-cursor-state evil-normal-state-cursor
                    evil-normal-state-cursor '(nil))
      (setq-local evil-normal-state-cursor spray--last-evil-cursor-state)))
  (add-hook 'spray-mode-hook #'spray-mode-hide-cursor)

(map! "<f6>" #'spray-mode)
(map! :after spray
      :map spray-mode-map
      :n "<return>" #'spray-start/stop
      :n "M-f" #'spray-faster
      :n "M-s" #'spray-slower
      :n [remap keyboard-quit] 'spray-quit
      :n "q" #'spray-quit)
;; "Minor modes to toggle off when in spray mode."
(setq spray-unsupported-minor-modes
  '(beacon-mode buffer-face-mode smartparens-mode
		     column-number-mode line-number-mode ))
(setq cursor-in-non-selected-windows nil)

;; "Watch a video from URL in MPV" ;;
;;;###autoload
(defun elfeed-v-mpv (url)
  "open URL in mpv"
  (message "just a sec...video will start soon")
  (start-process "mpv" nil "mpv" url))

;;;###autoload
(defun elfeed-view-mpv (&optional use-generic-p)
  "Youtube-feed link"
  (interactive "P")
  (let ((entries (elfeed-search-selected)))
    (cl-loop for entry in entries
             do (elfeed-untag entry 'unread)
             when (elfeed-entry-link entry)
             do (elfeed-v-mpv it))
    (mapc #'elfeed-search-update-entry entries)
    (unless (use-region-p) (forward-line))))

;; youtube downloader ;;;;
(defun yt-dl-it (url)
  "async yt-dlp download from url"
  (interactive)
  (let ((default-directory "~/Videos"))
    (async-shell-command (format "yt-dlp %s" url))))

(defun elfeed-youtube-dl ()
  (interactive)
  (let ((entries (elfeed-search-selected)))
    (cl-loop for entry in entries
             do (elfeed-untag entry 'unread)
             when (elfeed-entry-link entry)
             do (yt-dl-it it))
    (mapc #'elfeed-search-update-entry entries)
    (unless (use-region-p) (forward-line))))

;; browse with eww ;;;;
(defun elfeed-eww-open ()
  (interactive)
  (let ((entries (elfeed-search-selected)))
    (cl-loop for entry in entries
             do (elfeed-untag entry 'unread)
             when (elfeed-entry-link entry)
             do (eww-browse-url it))
    (mapc #'elfeed-search-update-entry entries)
    (unless (use-region-p) (forward-line))))

;; youtube-sub-extractor ;;;;
(defun yt-sub-ex ()
  (interactive)
  (let ((entries (elfeed-search-selected)))
    (cl-loop for entry in entries
             do (elfeed-untag entry 'unread)
             when (elfeed-entry-link entry)
             do (youtube-sub-extractor-extract-subs-at-point))
    (mapc #'elfeed-search-update-entry entries)
    (unless (use-region-p) (forward-line))))

;; reddit show comments ;;;;
(defun my/elfeed-reddit-show-commments (&optional link)
  (interactive)
  (let* ((entry (if (eq major-mode 'elfeed-show-mode)
                    elfeed-show-entry
                  (elfeed-search-selected :ignore-region)))
         (link (if link link (elfeed-entry-link entry))))
    (reddigg-view-comments link)))

;; define tag "star" ;;;;
(defun elfeed-expose (function &rest args)
    "Return an interactive version of FUNCTION, exposing it to the user."
  (lambda () (interactive) (apply function args)))
(defalias 'elfeed-toggle-star
       (elfeed-expose #'elfeed-search-toggle-all 'star))

;; hn-show-comments from search-mode ;;;;
;; hacker news comment reader
(defun dvs/elfeed-hn-show-comments ()
  (interactive)
  (let ((entries (elfeed-search-selected)))
    (cl-loop for entry in entries
             do (elfeed-untag entry 'unread)
             when (cdr (elfeed-entry-id entry))
             do (hnreader-promise-comment it))
    (mapc #'elfeed-search-update-entry entries)
    (unless (use-region-p) (forward-line))))
;; this command could be added to the function
;; (setq-local hnreader-view-comments-in-same-window nil/t)

;; elfeed-goodies
(use-package! elfeed-goodies
  :after elfeed
  :config
  (elfeed-goodies/setup))

;; This is an opinionated workflow that turns Emacs into an RSS reader, inspired
;; by apps Reeder and Readkit. It can be invoked via `=rss'. Otherwise, if you
;; don't care for the UI you can invoke elfeed directly with `elfeed'.

(defvar +rss-split-direction 'below
  "What direction to pop up the entry buffer in elfeed.")

(defvar +rss-enable-sliced-images t
  "scroll images smoother")

(defvar +rss-workspace-name "*rss*"
  "Name of the workspace that contains the elfeed buffer.")

;; keymap ;;
(map! :leader
      :prefix "o"
      :desc "open elfeed" "e" #'=rss)

;; elfeed
(use-package! elfeed
  :commands elfeed
  :init
  (setq elfeed-db-directory (concat doom-local-dir "elfeed/db/")
        elfeed-enclosure-default-dir (concat doom-local-dir "elfeed/enclosures/"))
  :config
  (setq elfeed-search-filter "@2-week-ago "
        elfeed-show-entry-switch #'pop-to-buffer
        elfeed-show-entry-delete #'+rss/delete-pane
        shr-max-image-proportion 0.8)

  (set-popup-rule! "^\\*elfeed-entry"
    :size 0.75 :actions '(display-buffer-below-selected)
    :select t :quit nil :ttl t)

  (make-directory elfeed-db-directory t)

  ;; Ensure elfeed buffers are treated as real
  (add-hook! 'doom-real-buffer-functions
    (defun +rss-buffer-p (buf)
      (string-match-p "^\\*elfeed" (buffer-name buf))))

  ;; Enhance readability of a post
  (add-hook 'elfeed-show-mode-hook #'+rss-elfeed-wrap-h)
  (add-hook! 'elfeed-search-mode-hook
    (add-hook 'kill-buffer-hook #'+rss-cleanup-h nil 'local))
  (add-hook 'elfeed-search-mode-hook #'elfeed-summary)

  ;; Large images are annoying to scroll through, because scrolling follows the
  ;; cursor, so we force shr to insert images in slices.
  (when +rss-enable-sliced-images
    (setq-hook! 'elfeed-show-mode-hook
      shr-put-image-function #'+rss-put-sliced-image-fn
      shr-external-rendering-functions '((img . +rss-render-image-tag-without-underline-fn))))

  ;; keymap
  (map! :after elfeed
        :map elfeed-search-mode-map
        :n [remap save-buffer] 'elfeed-tube-save
        :n "8" #'elfeed-toggle-star
        :n "a" #'elfeed-curate-edit-entry-annoation
        :n "d" #'elfeed-youtube-dl
        :n "e" #'elfeed-eww-open
        :n "F" #'elfeed-tube-fetch
        :n "h" #'dvs/elfeed-hn-show-comments
        :n "m" #'elfeed-curate-toggle-star
        :n "r" #'elfeed-search-update--force
        :n "R" #'elfeed-summary
        :n "q" #'elfeed-kill-buffer
        :n "T" #'my/elfeed-reddit-show-commments
        :n "v" #'elfeed-view-mpv
        :n "x" #'elfeed-curate-export-entries
        :n "Y" #'yt-sub-ex
        :n (kbd "M-RET") #'elfeed-search-browse-url)
  (map! :after elfeed-show
        :map elfeed-show-mode-map
        :n [remap next-buffer] #'+rss/next
        :n [remap previous-buffer] #'+rss/previous
        :n [remap save-buffer] 'elfeed-tube-save
        :n "a" #'elfeed-curate-edit-entry-annoation
        :n "d" #'yt-dl-it
        :n "e" #'elfeed-eww-open
        :n "m" #'elfeed-curate-toggle-star
        :n "x" #'elfeed-kill-buffer
        :n "gc" nil
        :n "gc" #'elfeed-kill-link-url-at-point))

(use-package! elfeed-org
  :after elfeed
  :preface
  (setq rmh-elfeed-org-files (list "elfeed-feeds.org"))
  ;; (setq rmh-elfeed-org-files (list "~/.config/doom/elfeed-feeds.org"))
  :config
  (elfeed-org)
  (defadvice! +rss-skip-missing-org-files-a (&rest _)
    :before '(elfeed rmh-elfeed-org-mark-feed-ignore elfeed-org-export-opml)
    (unless (file-name-absolute-p (car rmh-elfeed-org-files))
      (let* ((default-directory org-directory)
             (files (mapcar #'expand-file-name rmh-elfeed-org-files)))
        (dolist (file (cl-remove-if #'file-exists-p files))
          (message "elfeed-org: ignoring %S because it can't be read" file))
        (setq rmh-elfeed-org-files (cl-remove-if-not #'file-exists-p files))))))

(after! elfeed
(use-package elfeed-curate))

(setq elfeed-curate-star-tag "cur8")

(after! elfeed
(use-package elfeed-tube
  :demand t
  :config
  (elfeed-tube-setup)))

(after! elfeed
(use-package elfeed-tube-mpv))

(use-package! elfeed-summary
  :defer t
  :after elfeed)

(setq elfeed-summary-other-window t)

(map! :map elfeed-summary-mode-map
      :desc "unjam elfeed"
      :n "m" #'elfeed-unjam)

(setq elfeed-summary-settings
      '((group (:title . "today")
         (:elements
          (search
           (:filter . "@1-day-ago")
           (:title . ""))))
        (group (:title . "Daily")
               (:elements
                (query . day))
               (:hide t))
        (group (:title . "searches Days")
               (:elements
                (group
                 (:title . "2 days")
                 (:elements
                  (search
                   (:filter . "@2-day-ago")
                   (:title . "")))
                 (:hide t))
                (group
                 (:title . "3 days")
                 (:elements
                  (search
                   (:filter . "@3-day-ago")
                   (:title . "")))
                 (:hide t))
                (group
                 (:title . "4 days")
                 (:elements
                  (search
                   (:filter . "@4-day-ago")
                   (:title . "")))
                 (:hide t))
                (group
                 (:title . "1 week")
                 (:elements
                  (search
                   (:filter . "@7-day-ago")
                   (:title . "")))
                 (:hide t))
                (group
                 (:title . "2 weeks")
                 (:elements
                  (search
                   (:filter . "@2-weeks-ago")
                   (:title . "")))
                 (:hide t))
                (group
                 (:title . "3 weeks")
                 (:elements
                  (search
                   (:filter . "@3-weeks-ago")
                   (:title . "")))
                 (:hide t))
                (group
                 (:title . "1 month")
                 (:elements
                  (search
                   (:filter . "@1-month-ago")
                   (:title . "")))
                 (:hide t))
                (group
                 (:title . "2 months")
                 (:elements
                  (search
                   (:filter . "@2-month-ago")
                   (:title . "")))
                 (:hide t))
                (group
                 (:title . "6 months")
                 (:elements
                  (search
                   (:filter . "@6-months-ago +unread")
                   (:title . "+unread"))
                  (search
                   (:filter . "@6-months-ago")
                   (:title . "+all")))))
               (:hide t))
        ;; ...

        ;; ...
        (group (:title . "stared")
               (:elements
                (search
                 (:filter . "+star")
                 (:title . "")))
               (:hide t))
        (group (:title . "forums")
               (:elements
                (query . forum))
               (:hide t))
        (group (:title . "Humor")
               (:elements
                (query . fun))
               (:hide t))
        (group (:title . "Repos")
               (:elements
                (query . github))
               (:hide t))
        (group (:title . "Doom")
               (:elements
                (query . doom))
               (:hide t))
        (group (:title . "Emacs")
               (:elements
                (query . emacs))
               (:hide t))
        (group (:title . "Linux")
               (:elements
                (query . linux))
               (:hide t))
        (group (:title . "Corbett")
               (:elements
                (query . corbett))
               (:hide t))
        (group (:title . "science")
               (:elements
                (query . sci))
               (:hide t))
        (group (:title . "Substack")
               (:elements
                (query . sub))
               (:hide t))
        (group (:title . "Videos")
               (:elements
                (group
                 (:title . "truth")
                 (:elements
                  (query . (and video truth)))
                 (:hide t))
                (group
                 (:title . "humor")
                 (:elements
                  (query . (and video fun)))
                 (hide t))
                (group
                 (:title . "real")
                 (:elements
                  (query . (and video real)))
                 (hide t))
                (group
                 (:title . "history")
                 (:elements
                  (query . (and video hist)))))
               (:hide t))
        (group (:title . "searches all")
               (:elements
                (group
                 (:title . "ungrouped")
                 (:elements :misc))))))

;; found in manual for eww w/spc h R ;;;;
(setq eww-retrieve-command
     '("brave" "--headless" "--dump-dom"))

;; https://emacs.stackexchange.com/questions/4089/
;; eww use pdf-tools
;; The behavior can be enabled or disabled by
;; setq-ing the variable tv/prefer-pdf-tools to t or nil
(defvar tv/prefer-pdf-tools (fboundp 'pdf-view-mode))
(defun tv/start-pdf-tools-if-pdf ()
  (when (and tv/prefer-pdf-tools
             (eq doc-view-doc-type 'pdf))
    (pdf-view-mode)))

(add-hook 'doc-view-mode-hook 'tv/start-pdf-tools-if-pdf)

(use-package osm
  :defer t
  :bind ("C-x m" . osm-prefix-map) ;; Alternative: `osm-home'
  :custom
  ;; Take a look at the customization group `osm' for more options.
  (osm-server 'default) ;; Configure the tile server
  (osm-copyright t)     ;; Display the copyright information
:config

  ;; Add custom servers, see also https://github.com/minad/osm/wiki
  ;; (osm-add-server 'myserver
  ;;   :name "My tile server"
  ;;   :group "Custom"
  ;;   :description "Tiles based on aerial images"
  ;;   :url "https://myserver/tiles/%z/%x/%y.png?apikey=%k")
)

(use-package dwim-shell-command
  :defer t
  :bind (([remap shell-command] . dwim-shell-command)
         :map dired-mode-map
         ([remap dired-do-async-shell-command] . dwim-shell-command)
         ([remap dired-do-shell-command] . dwim-shell-command)
         ([remap dired-smart-shell-command] . dwim-shell-command))
  :config
;; pdf to text ;;;;
(defun dwim-shell-commands-pdf-to-txt ()
  "Convert pdf to txt."
  (interactive)
  (dwim-shell-command-on-marked-files
   "pdf to txt"
   "pdftotext -layout '<<f>>' '<<fne>>.txt'"
   :utils "pdftotext"))
;; Ping duckduckgo.com ;;;;
(defun dwim-shell-commands-ping-google ()
  (interactive)
  (dwim-shell-command-on-marked-files
   "Ping google.com"
   "ping -c 3 google.com"
   :utils "ping"
   :focus-now t))
;; Stream clipboard URL using mpv ;;;;
(defun dwim-shell-commands-mpv-stream-clipboard-url ()
  (interactive)
  (dwim-shell-command-on-marked-files
   "Streaming"
   "mpv --geometry=30%x30%+100%+0% \"<<cb>>\""
   :utils "mpv"
   :no-progress t
   :error-autofocus t
   :silent-success t))
;; Clone git URL in clipboard to "~/builds/" ;;;;
(defun dwim-shell-commands-git-clone-clipboard-url-to-builds ()
  (interactive)
  (cl-assert (string-match-p "^\\(http\\|https\\|ssh\\)://" (current-kill 0)) nil "No URL in clipboard")
  (let* ((url (current-kill 0))
         (download-dir (expand-file-name "~/builds/"))
         (project-dir (concat download-dir (file-name-base url)))
         (default-directory download-dir))
    (when (or (not (file-exists-p project-dir))
              (when (y-or-n-p (format "%s exists.  delete?" (file-name-base url)))
                (delete-directory project-dir t)
                t))
      (dwim-shell-command-on-marked-files
       (format "Clone %s" (file-name-base url))
       (format "git clone %s" url)
       :utils "git"
       :on-completion (lambda (buffer)
                        (kill-buffer buffer)
                        (dired project-dir)))))))
(require 'dwim-shell-commands)

(use-package engine-mode
  :defer t
  :config
  (engine-mode t))
(defengine nitter
"https://nitter.net/search?f=tweets&q=%s"
  :keybinding "n")
(defengine githubcs
  "https://github.com/search?type=code&auto_enroll=true&q=%s"
  :keybinding "g")
(defengine github
  "https://github.com/search?ref=simplesearch&q=%s"
  :keybinding "h")
(defengine presearch
  "https://presearch.com/search?q=%s"
  :keybinding "p")
(defengine google
  "http://www.google.com/search?ie=utf-8&oe=utf-8&q=%s"
  :keybinding "o")
(defengine brave
  "https://search.brave.com/search?q=%s"
  :keybinding "b")
(defengine melpa
  "https://melpa.org/#/%s"
  :keybinding "m")
(defengine archwiki
  "https://wiki.archlinux.org/index.php?search="
  :keybinding "a")
(defengine aur
  "https://aur.archlinux.org/packages/?K="
  :keybinding "u")

(use-package markdown-mode
  :defer t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "pandoc"))
;; start pandoc with every markdown file ;;;;
(add-hook 'markdown-mode-hook 'pandoc-mode)

;; default markdown-mode's markdown-live-preview-mode to vertical split
(setq markdown-split-window-direction 'right)

(use-package languagetool
  :defer t
  :commands (languagetool-check
             languagetool-clear-suggestions
             languagetool-correct-at-point
             languagetool-correct-buffer
             languagetool-set-language
             languagetool-server-mode
             languagetool-server-start
             languagetool-server-stop)
  :config
  (setq languagetool-java-arguments '("-Dfile.encoding=UTF-8"
                                      "-cp" "/usr/share/languagetool:/usr/share/java/languagetool/*")
        languagetool-console-command "org.languagetool.commandline.Main"
        languagetool-server-command "org.languagetool.server.HTTPServer"))

(map! :after org
      :map org-mode-map
      :leader
      (:prefix ("l" . "link")
       :desc "insert file link" "k" 'languagetool-check
       :desc "langtool correct buffer" "b" 'languagetool-correct-buffer
       :desc "langtool check done" "d" 'languagetool-clear-suggestions
       :desc "langtool server start" "s" 'languagetool-server-start
       :desc "langtool server mode" "m" 'languagetool-server-mode
       :desc "langtool sever stop" "f" 'languagetool-server-stop))

(use-package! denote
  :defer t
  :hook (dired-mode . denote-dired-mode)
  (org-mode . denote-rename-buffer-mode)
  :custom
  (denote-directory (expand-file-name "~/org/denote/"))
  (denote-known-keywords '("emacs" "package" "info" "perman"))
;; Pick dates, with Org's advanced interface:
  (denote-date-prompt-use-org-read-date t)
  (denote-infer-keywords t)
  (denote-sort-keywords t)
  :config
  (denote-rename-buffer-mode)
  (require 'denote-org-extras))

;; ;; By default, we do not show the context of links.  We just display
;; ;; file names.  This provides a more informative view.
;; (setq denote-backlinks-show-context t)

;; map! "spc d n" #'denote
(map! :leader
      :prefix "d"
      :desc "denote"
      :n "n" #'denote)

(use-package monkeytype
  :init
  (setq monkeytype-downcase nil)
  :defer t)

(defun my/monkeytype-mode-hook ()
    "Hooks for monkeytype-mode."
  (evil-escape-mode -1)
  (flyspell-mode -0)
  (corfu-mode -0)
  (evil-insert -1)
  ;; (text-scale-set 3)
  (+zen/toggle))


;; Toggle downcase text
(add-hook 'monkeytype-mode-hook #'my/monkeytype-mode-hook)

(after! monkeytype
(defun monkeytype--process-input-timer-init ()
  (unless monkeytype--start-time
    (setq monkeytype--current-run-start-datetime
          (format-time-string "%a-%d-%b-%Y %H:%M:%S"))
    (setq monkeytype--start-time (float-time))
    (monkeytype--utils-idle-timer 5000 'monkeytype-pause))))

(map! :after org
      :leader
      :prefix "o"
      :desc "open monkeytype"
      :n "m" #'monkeytype-load-words-from-file)

(use-package! browser-hist
  :defer t
  :commands (browser-hist-search)
  :init
  (require 'embark) ; load Embark before the command (if you're using it)
  (setq browser-hist-default-browser 'brave)
  :config
  (setq browser-hist-db-paths
        '((brave . "~/.config/BraveSoftware/Brave-Browser/Default/History"))))

(map! :leader
      :prefix "s"
      :desc "search browser history"
      :n "h" #'browser-hist-search)

(use-package! yequake
  :defer t
  :custom
  (yequake-frames
   '(("org-capture"
      (buffer-fns . (yequake-org-capture))
      (width . 0.75)
      (height . 0.5)
      (alpha . 0.95)
      (frame-parameters . ((undecorated . t)
                           (skip-taskbar . t)
                           (sticky . t))))
     ("Yequake & scratch" .
         ((width . 0.75)
          (height . 0.5)
          (alpha . 0.95)
          (buffer-fns . ("~/org/yequake/key-reminder.org"
                         split-window-horizontally
                         "*scratch*"))
          (frame-parameters . ((undecorated . t)))))
     ("evil-easymotion" .
         ((width . 0.75)
          (height . 0.5)
          (alpha . 0.95)
          (buffer-fns . ("~/org/yequake/evil-easymotion.org"))
          (frame-parameters . ((undecorated . t))))))))

;; use this in linux to call it outside of emacs
;; emacsclient -n -e '(yequake-toggle "org-capture")'

;; toggle yequakes-frames
(map! :leader
      :prefix "t"
      :desc "toggle yequakes-frames"
      :n "y" #'yequake-toggle)
;; use this to call from linux
;; emacsclient -n -e '(yequake-toggle "Yequake & scratch")'

(use-package! ediff
  :defer t
  :custom-face
  (ediff-current-diff-A ((t (:background "#663333"))))
  (ediff-fine-diff-A ((t (:background "indian red"))))
  (ediff-current-diff-B ((t (:background "#336633"))))
  (ediff-fine-diff-B ((t (:background "#558855"))))
  :commands (ediff-files))
(after! ediff
  (setq ediff-diff-options "-w" ; turn off whitespace checking
        ediff-split-window-function #'split-window-horizontally
        ediff-window-setup-function #'ediff-setup-windows-plain)
  (defvar doom--ediff-saved-wconf nil)
  ;; restore window config after quitting ediff
  (add-hook! 'ediff-before-setup-hook
    (defun doom-ediff-save-wconf-h ()
      (setq doom--ediff-saved-wconf (current-window-configuration))))
  (add-hook! '(ediff-quit-hook ediff-suspend-hook) :append
    (defun doom-ediff-restore-wconf-h ()
      (when (window-configuration-p doom--ediff-saved-wconf)
        (set-window-configuration doom--ediff-saved-wconf)))))

;; get ediff to unfold everthing before
(with-eval-after-load 'outline
   (add-hook 'ediff-prepare-buffer-hook #'org-fold-show-all))

(use-package! pomidor
  :defer t
  :bind (("<f9>" . pomidor))
  :config (setq pomidor-sound-tick nil
                pomidor-sound-tack nil)
  (map! :map pomidor-mode-map
      :desc "quit window"
      :n "M-q" #'quit-window
      :desc "pomidor quit"
      :n "M-Q" #'pomidor-quit
      :desc "pomidor reset"
      :n "M-R" #'pomidor-reset
      :desc "pomidor-hold"
      :n "M-h" #'pomidor-hold
      :desc "pomidor-unhold"
      :n "M-H" #'pomidor-unhold
      :desc "pomidor-stop"
      :n "M-RET" #'pomidor-stop
      :desc "pomidor-break"
      :n "M-SPC" #'pomidor-break))
