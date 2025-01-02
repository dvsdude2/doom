;;; ~/.config/doom/config.el -*- lexical-binding:t -*-

;; Some functionality uses this to identify you
(setq user-full-name "dvsdude"
      user-mail-address "john@doe.com")

;; add packages manually from local repo
;; load my packaged function to open config.org named workspace
(load "~/.config/doom/myrepo/+config/+config.el")
;; Corfu-extensions to load path
(add-to-list 'load-path
             (expand-file-name "~/.config/emacs/.local/straight/repos/corfu/extensions"))
;; add tray pkg to load-path
(add-to-list 'load-path "~/.config/doom/myrepo/tray")
;; load wiki-summary
(add-to-list 'load-path "~/.config/doom/myrepo/wiki-summary")

;; fontset ;;;;
(setq doom-font (font-spec :family "Hack Nerd Font" :size 17 :weight 'bold)
;; (setq doom-font (font-spec :family "Iosevka" :size 18 :weight 'heavy)
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
;; set path for projects
(setq projectile-project-search-path '(("~/org/projects" . 1)))
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
  (dashboard-banner-logo-title "Welcome to my 💀DOOM & DIRED💀 It has freed me from all that I desired.🔥")
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
  (dashboard-setup-startup-hook)
  (add-to-list 'dashboard-items '(agenda) t)
  (setq dashboard-filter-agenda-entry 'dashboard-filter-agenda-by-todo)
  (setq dashboard-items '((recents . 7)
                          (projects . 5)
                          (agenda . 6)))
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

;; this needed to use arrow-keys with dired-preview
(define-key! dired-mode-map
  ;; Evil remaps
  [remap evil-next-line]     #'dired-next-line
  [remap evil-previous-line] #'dired-previous-line)

;; (require 'dired-preview)
(use-package! dired-preview
  :after dired
  :config
  (setq dired-preview-ignored-extensions-regexp
        (concat "\\."
                "\\(gz\\|"
                "zst\\|"
                "tar\\|"
                "xz\\|"
                "rar\\|"
                "zip\\|"
                "iso\\|"
                "epub"
                "\\)")))

(map! :map dired-mode-map
      :leader
      :prefix "t"
      :desc "dired preview mode"
      :n "p" 'dired-preview-mode)

(use-package! ready-player
  :after dired
  :hook (dired-mode . ready-player-mode)
  :config
  (ready-player-mode +1))

(use-package! dired-subtree
  :after dired
  :config
  (bind-key "<tab>" #'dired-subtree-toggle dired-mode-map)
  (bind-key "<backtab>" #'dired-subtree-cycle dired-mode-map))

(after! dired
  (use-package! dired-open
    :config
    (setq dired-open-extensions '(("mkv" . "mpv")
                                  ("mp4" . "mpv")
                                  ("pdf" . "evince")
                                  ("webm" . "mpv")))))

;; default file for notes
(setq org-default-notes-file (concat org-directory "notes.org"))
;; default diary files
(setq org-agenda-diary-file "~/org/notable-dates.org")
;; (setq diary-file "~/.config/doom/diary")

;; set org-todo-keywords
(after! org
  (setq org-todo-keywords
        '((sequence "TODO(t)" "PROJ(p)" "NOTE(r)" "STRT(s)" "WAIT(w)" "HOLD(h)" "IDEA(i)" "|" "DONE(d)" "KILL(k)")
          (sequence "[ ](T)" "[-](S)" "[?](W)" "|" "[X](D)")
          (sequence "|" "OKAY(o)" "YES(y)" "NO(n)"))))

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

;; set one location for archives
(setq org-archive-location "~/org/archive.org::* From %s")

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
  (setq! org-capture-templates
         '(("t" "todo Personal" entry
            (file+headline +org-capture-todo-file "Inbox")
            "** TODO %?\n%i\n%a" :prepend t)
           ("n" "notes Personal" entry
            (file+headline +org-capture-notes-file "Inbox")
            "**  %?\n%i\n%a" :prepend t)
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
            "** %^{link} %^g\n- %^{note}\n%^{image url}"
            :immediate-finish t :prepend t)
           ("l" "check out later" entry
            (file+headline "todo.org" "Check out later")
            "** IDEA %?\n%i\n%a" :prepend t)
           ("r" "remember")
           ("rd" "drill-template" entry
            (file+headline "~/org/wiki/drill.org" "questions")
            "** %^{category} %^g\n%^{question}\n*** answer\n%^{answer}\n**** notes\n%^{notes}"
            :immediate-finish t :prepend t)
           ("ru" "Task: Read this URL" entry
            (file+headline "tasks.org" "Articles To Read")
            ,(concat "* TODO Read article: '%:description'\nURL: %c\n\n")
            :empty-lines 1 :immediate-finish t)
           ("rw" "Capture web snippet" entry
            (file+headline "my-facts.org" "Inbox")
            ,(concat "* Fact: '%:description'        :"
                     (format "%s" org-drill-question-tag)
                     ":\n:PROPERTIES:\n:DATE_ADDED: %u\n:SOURCE_URL: %c\n:END:\n\n%i\n%?\n")
            :empty-lines 1 :immediate-finish t)
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

(setq org-journal-file-type 'daily)
(setq org-journal-date-format "%A, %d %B %Y")
(setq org-journal-enable-agenda-integration t)
(add-hook 'org-journal-mode-hook #'my/org-journal-mode-hook)

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

;; ;; save and exit journal easily
(map! :after org
      :map org-journal-mode-map
      :desc "save and kill journal"
      :ni "C-q" #'doom/save-and-kill-buffer)
;; ;; save and exit journal easily
(map! :after org
      :map org-journal-mode-map
      :prefix "C-c j"
      :desc "save and kill journal"
      :ni "f" #'doom/save-and-kill-buffer)

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

;; remap
(define-key! [remap flyspell-auto-correct-previous-word] #'flyspell-correct-wrapper)

(setq flyspell-persistent-highlight nil)

(setq flyspell-issue-message-flag nil)

(setq ispell-personal-dictionary "/home/dvsdude/.aspell.en_CA.pws")
(setq ispell-program-name "aspell")

;; this is grabbed from Dooms config
(use-package! evil-surround
  :commands (global-evil-surround-mode
             evil-surround-edit
             evil-Surround-edit
             evil-surround-region)
  :config (global-evil-surround-mode 1))

(add-hook 'org-mode-hook #'embrace-org-mode-hook)

(map! :prefix "C-c"
      :desc "evil-embrace-dispatch"
      :n "e" #'embrace-commander)

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

;; evil-easymotion "prefix"
;; (evilem-default-keybindings "C-c a")
;; (evilem-default-keybindings "SPC")

;; evil-easymotion
(map! (:after evil-easymotion
       :m "gs" evilem-map
       (:map evilem-map
        "a" (evilem-create #'evil-forward-arg)
        "A" (evilem-create #'evil-backward-arg)
        "s" #'evil-avy-goto-char-2
        "SPC" (cmd! (let ((current-prefix-arg t)) (evil-avy-goto-char-timer)))
        "/" #'evil-avy-goto-char-timer)))

(map! :leader
      :prefix "s"
      :desc "avy goto char timer"
      :n "a" #'evil-avy-goto-char-timer)

(map! :leader
      :prefix "j"
      :desc "avy goto next line"
      :n "j" #'evilem-motion-next-line)
(map! :leader
      :prefix "k"
      :desc "avy goto prev line"
      :n "k" #'evilem-motion-previous-line)
(setq avy-timeout-seconds 1.0) ;;default 0.5
(setq avy-single-candidate-jump t)

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
Possible values are
- t (default) Insert candidate if one is selected, pass-through otherwise;
- `minibuffer' Insert candidate if one is selected, pass-through otherwise,
              and immediatelly exit if in the minibuffer;
- nil Pass-through without inserting.")

(defvar +corfu-buffer-scanning-size-limit (* 1 1024 1024) ; 1 MB
  "Size limit for a buffer to be scanned by `cape-dabbrev'.")

(use-package! corfu
  :hook (doom-first-input . global-corfu-mode)
  :init
  (corfu-mode +1)
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
        global-corfu-modes '((not help-mode
                                  vterm-mode)t)
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
                 eshell-mode-hook)
      (defun +corfu-add-cape-history-h ()
        (add-hook 'completion-at-point-functions #'cape-history -5 t)))
    (add-hook! '(prog-mode-hook
                 text-mode-hook
                 conf-mode-hook
                 comint-mode-hook
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

;; yas-corfu
(use-package! yasnippet-capf
  :defer t
  :init
  (add-hook! 'yas-minor-mode-hook
    (defun +corfu-add-yasnippet-capf-h ()
      (add-hook 'completion-at-point-functions #'yasnippet-capf 30 t))))

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

(defun dvs/zen-scratch-pad ()
   "Create a new org-mode buffer for random stuff."
   (interactive)
   (let ((buffer (generate-new-buffer "*org scratchy*")))
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

(defun dvs/readme-update-ediff ()
    "Update git README\\ using ediff."
  (interactive)
  (ediff "~/.config/doom/config.org" "~/.config/doom/README.org"))

;;;###autoload
(defun find-in-dotfiles ()
  "Open a file somewhere in ~/.dotfiles via a fuzzy filename search."
  (interactive)
  (doom-project-find-file (expand-file-name "~/.config/")))

;;;###autoload
(defun browse-dotfiles ()
  "Browse the files in ~/.dotfiles."
  (interactive)
  (doom-project-browse (expand-file-name "~/.config/")))

(map! :leader
      :prefix "f"
      :desc "open file in ~/.config/"
      :n "." #'find-in-dotfiles
      :desc "browse files in ~/.config/"
      :n "/" #'browse-dotfiles)

(defun my/dired-file-to-org-link ()
  "Transform the file path under the cursor in Dired to an Org mode
link and copy to kill ring."
  (interactive)
  (let ((file-path (dired-get-file-for-visit)))
    (if file-path
        (let* ((relative-path (file-relative-name file-path
                                                  (project-root (project-current t))))
               (org-link (concat "#+attr_org: :width 300px\n"
                                 "#+attr_html: :width 100%\n"
                                 "file:" relative-path "\n")))
          (kill-new org-link)
          (message "Copied to kill ring: %s" org-link))
      (message "No file under the cursor"))))

(map! :leader
      :prefix "i"
      :desc "dired=>org-link=>killring"
      :n "l" #'my/dired-file-to-org-link)

(defun my-github-search(&optional search)
  (interactive (list (read-string "Search: " (thing-at-point 'symbol))))
  (let* ((language (cond ((eq major-mode 'python-mode) "Python")
                 ((eq major-mode 'emacs-lisp-mode) "Emacs Lisp")
                 ((eq major-mode 'org-mode) "Emacs Lisp")
                         (t "Text")))
         (url (format "https://github.com/search/?q=\"%s\"+language:\"%s\"&type=Code" (url-hexify-string search) language)))
    (browse-url url)))

(after! org
(use-package org-rich-yank
  :demand t
  :bind (:map org-mode-map
              ("M-p" . org-rich-yank))))

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
  :after elfeed
  :config
  (set-popup-rules!
    '(("^\\*\\(HN\\|HNComments\\)"
       :slot -1 :vslot 2 :size '(+popup-shrink-to-fit)
       :select t :quit t))))

(use-package! org-xournalpp
  :defer t
  :config
  (add-hook 'org-mode-hook 'org-xournalpp-mode))

(use-package! journalctl-mode
  :defer t)

(use-package! olivetti
  :defer t)

(use-package! eshell-git-prompt
  :after eshell
  :config
  (eshell-git-prompt-use-theme 'powerline))

(use-package! substitute
  :after-call after-find-file pre-command-hook
  :config
  ;; Use C-c s as a prefix for all Substitute commands.
  (define-key global-map (kbd "C-c s") #'substitute-prefix-map)
  ;; upper and lower case will not change if this is nil
  (setq substitute-fixed-letter-case t)
  ;; report the number of changes
  (add-hook 'substitute-post-replace-functions #'substitute-report-operation))

(use-package! powerthesaurus
  :defer t)

(use-package! tray
  :after-call doom-first-input-hook
  :load-path "tray/tray.el")

(use-package! wiki-summary
  :after-call doom-first-input-hook
  :load-path "/wiki-summary/wiki-summary.el")

;; (]) next visible header in org
(map! :after org
      :map org-mode-map
      :prefix "]"
      :desc "next org visible header"
      :n "j" #'org-next-visible-heading)

(map! :after org
      :map org-mode-map
      :prefix "["
      :desc "prev org visible header"
      :n "k" #'org-previous-visible-heading)

;; (map! "<f5>" #'yequake-toggle)
(map! "<f6>" #'scroll-lock-mode)
;; (map! "<f7>" #'tray-lookup)
;; (map! "<f8>" #'unused)
(map! "<f9> r" #'remember)
(map! "<f9> R" #'remember-region)

;; (d) demarcate or create source-block
(map! :after org
      :leader
      :prefix "d"
      :desc "demarcate/create source-block"
      :n "b" #'org-babel-demarcate-block)

(map! :after dired
      :map dired-mode-map
      :leader
      :prefix "f"
      :desc "open all marked files at once"
      :n "m" #'dired-do-find-marked-files)

;; (i) insert
(map! :leader
      :prefix "i"
      ;; inserts selected text to chosen buffer
      :desc "append to buffer"
      :n "t" #'append-to-buffer
      ;; inserts entire buffer at point
      :desc "insert buffer at point"
      :n "b" #'insert-buffer
      ;; inserts contents of webpage
      :desc "websites-content to org"
      :n "w" #'org-web-tools-read-url-as-org)

;; (l) list-processes
(map! :leader
      :prefix "l"
      :desc "link copy"
      :n "c" #'link-hint-copy-link
      :desc "list processes"
      :n "p" #'list-processes)

;; (o) open
(map! :after org
      :leader
      :prefix ("o" . "open")
      ;; cycle agenda files
      :desc "cycle agenda files"
      :n "a f" #'org-cycle-agenda-files
      ;; open calendar in named workspace
      :desc "open calendar"
      :n "c" #'=calendar
      :desc "open Dashboard"
      :n "D" #'dashboard-open
      ;; toggle default-scratch buffer
      :desc "open defalt scratch-buffer"
      :n "x" #'scratch-buffer
      :desc "open org config in workspace"
      :n "I" #'=config
      :desc "open org config"
      :n "i" (lambda () (interactive) (find-file "~/.config/doom/config.org"))
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
      :n "k" (lambda () (interactive) (find-file "~/org/wiki/"))
      :desc "update readme using ediff"
      :n "u" #'dvs/readme-update-ediff)

;; (t) toogle
(map! :leader
      :prefix ("t" . "toggle")
      :desc "toggle olivetti-mode"
      :n "o" 'olivetti-mode
      :desc "toggle eshell"
      :n "e" #'+eshell/toggle)

(map! :leader
      :prefix ("v" . "Vertico")
      :desc "toggle vertico grid"
      :n "g" 'vertico-grid-mode
      :desc "vertico output to writable buffer"
      :n ";" #'+vertico/embark-export-write
      :desc "vertico history"
      :n "x" #'vertico-repeat-select)

;; Minibuffer history
(map! "C-c h" #'consult-history)
;; tranpose function for missed punctuation
(map! "C-c t" #'transpose-chars)
;; insert structural template
(map! "C-c b" #'org-insert-structure-template)
;; start modes
(map! :prefix ("C-c m" . "mode-command")
      "o" #'org-mode
      "i" #'lisp-interaction-mode
      "e" #'emacs-lisp-mode
      "f" #'fundamental-mode)
;; video related
(map! :prefix ("C-c v" . "video-related")
      :desc "extract subtitles"
      :n "e" #'youtube-sub-extractor-extract-subs-at-point
      :desc "extract subtitles at point"
      :n "E" #'youtube-sub-extractor-extract-subs)

(map! (:after smartparens
        :map smartparens-mode-map
        "C-M-a"           #'sp-beginning-of-sexp
        "C-M-]"           #'sp-forward-slurp-sexp
        "C-M-e"           #'sp-end-of-sexp
        "C-M-f"           #'sp-forward-sexp
        "C-M-b"           #'sp-backward-sexp
        "C-M-n"           #'sp-next-sexp
        "C-M-p"           #'sp-previous-sexp
        "C-M-u"           #'sp-up-sexp
        "C-M-d"           #'sp-down-sexp
        "C-M-k"           #'sp-kill-sexp
        "C-M-t"           #'sp-transpose-sexp
        "C-M-<backspace>" #'sp-splice-sexp))

;; quick-calc
(map! "M-# q" #'quick-calc)
;; close other window ;;;;
(map! "C-1" #'delete-other-windows)
;; switch other window
(map! "C-2" #'switch-to-buffer-other-window)
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

(use-package! which-key
  :hook (doom-first-input . which-key-mode)
  :init
  (setq which-key-sort-order #'which-key-key-order-alpha
        which-key-sort-uppercase-first nil
        which-key-add-column-padding 1
        which-key-idle-delay 1.5
        which-key-max-display-columns nil
        which-key-min-display-lines 6
        which-key-side-window-slot -10)
  :config
  (put 'which-key-replacement-alist 'initial-value which-key-replacement-alist)
  (add-hook! 'doom-before-reload-hook
    (defun doom-reset-which-key-replacements-h ()
      (setq which-key-replacement-alist (get 'which-key-replacement-alist 'initial-value))))
  ;; general improvements to which-key readability
  (which-key-setup-side-window-bottom)
  (setq-hook! 'which-key-init-buffer-hook line-spacing 3)

  (which-key-add-key-based-replacements doom-leader-key "<leader>")
  (which-key-add-key-based-replacements doom-localleader-key "<localleader>"))

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

(after! org
(use-package! org-media-note
  :hook (org-mode .  org-media-note-mode)
  :bind (("C-c v n" . org-media-note-hydra/body))  ;; Main entrance
  :config
  (setq org-media-note-screenshot-image-dir "~/pictures/")))  ;; Folder to save screenshot

;; ;; this is mostly the original that worked
(defun my/mpv-play-url (&optional url &rest args)
  "Start mpv for URL ARGS."
  (interactive (browse-url-interactive-arg "URL: "))
  (mpv-start url))

(defun elfeed-open-hnreader-url (url &optional new-window)
  "Open HN-comments URL in a NEW-WINDOW as a org-buffer."
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

;;;; `browse-url'
(setq browse-url-browser-function 'eww-browse-url)
(setq browse-url-secondary-browser-function 'browse-url-default-browser)
(setq browse-url-handlers
      '(("\\.\\(gifv?\\|avi\\|AVI\\|mp[4g]\\|MP4\\|MP3\\|webm\\)$" . my/mpv-play-url)
        ("^https?://\\(www\\.youtube\\.com\\|youtu\\.be\\)/" . my/mpv-play-url)
        ("^https?://\\(odysee\\.com\\|rumble\\.com\\)/" . my/mpv-play-url)
        ("^https?://\\(t\\.co/[a-zA-Z0-9]?*\\|x\\.com/[a-zA-Z]?*/status/[0-9]?*\\)" . my/mpv-play-url)
        ("^https?://\\(off-guardian\.org\\|\.substack\\.com\\|tomluongo\\.me\\)/" . dvs-eww)
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

(use-package! yeetube
  :defer t
  :init (define-prefix-command 'my/yeetube-map)
  :config
  (setq yeetube-download-directory "~/Videos")
  :bind (("C-c y" . 'my/yeetube-map)
          :map my/yeetube-map
                  ("s" . 'yeetube-search)
                  ("b" . 'yeetube-play-saved-video)
                  ("D" . 'yeetube-download-videos)
                  ("d" . 'yeetube-download-video)
                  ("p" . 'yeetube-mpv-toggle-pause)
                  ("v" . 'yeetube-mpv-toggle-video)
                  ("V" . 'yeetube-mpv-toggle-no-video-flag)
                  ("k" . 'yeetube-remove-saved-video)))

(map! :map yeetube-mode-map
     [remap evil-ret] #'yeetube-play)

(map! :leader
      :prefix "s"
      :desc "search yeetube" "y" #'yeetube-search)

(use-package spray
  :commands (spray-mode)
  :config
  (setq spray-wpm 220
        spray-height 800)
  ;; "Minor modes to toggle off when in spray mode."
  (setq spray-unsupported-minor-modes
        '(beacon-mode buffer-face-mode smartparens-mode
          column-number-mode line-number-mode ))
  (add-hook 'spray-mode-hook #'spray-mode-hide-cursor))

(defun spray-mode-hide-cursor ()
    "Hide or unhide the cursor as is appropriate."
    (if spray-mode
        (setq-local spray--last-evil-cursor-state evil-normal-state-cursor
                    evil-normal-state-cursor '(nil))
      (setq-local evil-normal-state-cursor spray--last-evil-cursor-state)))


(map! :leader
      :prefix "t"
      :desc "toogle spray-mode"
      :n "S" #'spray-mode)

(map! :after spray
      :map spray-mode-map
      :n "<return>" #'spray-start/stop
      :n "M-f" #'spray-faster
      :n "M-s" #'spray-slower
      :n [remap keyboard-quit] 'spray-quit
      :n "q" #'spray-quit)

(defun my/elfeed-search-filter-source (entry)
  "Filter elfeed search buffer by the feed under cursor."
  (interactive (list (elfeed-search-selected :ignore-region)))
  (when (elfeed-entry-p entry)
    (elfeed-search-set-filter
     (concat
      "@6-months-ago "
      "+unread "
      "="
      (replace-regexp-in-string
       (rx "?" (* not-newline) eos)
       ""
       (elfeed-feed-url (elfeed-entry-feed entry)))))))

(org-link-set-parameters "elfeed"
  :follow #'elfeed-link-open
  :store #'elfeed-link-store-link
  :export #'elfeed-link-export-link)

(defun elfeed-link-export-link (link desc format _protocol)
  "Export `org-mode' `elfeed' LINK with DESC for FORMAT."
  (if (string-match "\\([^#]+\\)#\\(.+\\)" link)
    (if-let* ((entry
                (elfeed-db-get-entry
                  (cons (match-string 1 link)
                    (match-string 2 link))))
               (url
                 (elfeed-entry-link entry))
               (title
                 (elfeed-entry-title entry)))
      (pcase format
        ('html (format "<a href=\"%s\">%s</a>" url desc))
        ('md (format "[%s](%s)" desc url))
        ('latex (format "\\href{%s}{%s}" url desc))
        ('texinfo (format "@uref{%s,%s}" url desc))
        (_ (format "%s (%s)" desc url)))
      (format "%s (%s)" desc url))
    (format "%s (%s)" desc link)))

;; "Watch a video from URL in MPV" ;;
;;;###autoload
(defun elfeed-v-mpv (url)
  "open URL in mpv"
  (interactive "P")
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
  "Open in eww."
  (interactive)
  (let ((entries (elfeed-search-selected)))
    (cl-loop for entry in entries
             do (elfeed-untag entry 'unread)
             when (elfeed-entry-link entry)
             do (eww-browse-url it))
    (mapc #'elfeed-search-update-entry entries)
    (unless (use-region-p) (forward-line))))

;; Open a URL with eww.
(defun my/elfeed-show-visit-eww ()
  "Visit the current entry in eww"
  (interactive)
  (let ((link (elfeed-entry-link elfeed-show-entry)))
    (when link
      (eww link))))

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

(set-popup-rules!
  '(("^\\*\\(reddigg\\|reddigg-comments\\)"
     :slot -1 :vslot 2 :size '(+popup-shrink-to-fit)
     :select t :quit t)))

;; define tag "star" ;;;;
(defun elfeed-expose (function &rest args)
    "Return an interactive version of FUNCTION, exposing it to the user."
  (lambda () (interactive) (apply function args)))
(defalias 'elfeed-toggle-star
       (elfeed-expose #'elfeed-search-toggle-all 'star))

;; hn-show-comments from search-mode ;;;;
(defun dvs/elfeed-hn-show-comments ()
  "hacker news comment reader"
  (interactive)
  (let ((entries (elfeed-search-selected)))
    (cl-loop for entry in entries
             do (elfeed-untag entry 'read) ;; mark as read use "'unread"
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
  :commands (elfeed)
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
  (add-hook 'elfeed-search-mode-hook #'elfeed-summary)
  (add-hook! 'elfeed-search-mode-hook
    (add-hook 'kill-buffer-hook #'+rss-cleanup-h nil 'local))

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
        :n "e" #'my/elfeed-show-visit-eww
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
  :after elfeed
  :commands (elfeed-summary)
  :config
  (setq elfeed-summary-other-window t))

(after! elfeed (load! "myrepo/elfeed-summary-layout/+elfeed-summary-settings"))

(map! :map elfeed-summary-mode-map
      :desc "unjam elfeed"
      :n "m" #'elfeed-unjam)

;; found in manual for eww w/spc h R ;;;;
(setq eww-retrieve-command
     '("brave" "--headless" "--dump-dom"))

;; https://emacs.stackexchange.com/questions/4089/
;; The behavior can be enabled or disabled by
;; setq-ing the variable tv/prefer-pdf-tools to t or nil
(defvar tv/prefer-pdf-tools (fboundp 'pdf-view-mode))
(defun tv/start-pdf-tools-if-pdf ()
  (when (and tv/prefer-pdf-tools
             (eq doc-view-doc-type 'pdf))
    (pdf-view-mode)))

(add-hook 'doc-view-mode-hook 'tv/start-pdf-tools-if-pdf)

;; may want this on a keybinding
;; https://jao.io/blog/eww-to-org.html
;; command to generate an org-mode rendering of an eww page
(defun jao-eww-to-org (&optional dest)
  "Render the current eww buffer using org markup.
If DEST, a buffer, is provided, insert the markup there."
  (interactive)
  (unless (org-region-active-p)
    (let ((shr-width 80)) (eww-readable)))
  (let* ((start (if (org-region-active-p) (region-beginning) (point-min)))
         (end (if (org-region-active-p) (region-end) (point-max)))
         (buff (or dest (generate-new-buffer "*eww-to-org*")))
         (link (eww-current-url))
         (title (or (plist-get eww-data :title) "")))
    (with-current-buffer buff
      (insert "#+title: " title "\n#+link: " link "\n\n")
      (org-mode))
    (save-excursion
      (goto-char start)
      (while (< (point) end)
        (let* ((p (point))
               (props (text-properties-at p))
               (k (seq-find (lambda (x) (plist-get props x))
                            '(shr-url image-url outline-level face)))
               (prop (and k (list k (plist-get props k))))
               (next (if prop
                         (next-single-property-change p (car prop) nil end)
                       (next-property-change p nil end)))
               (txt (buffer-substring (point) next))
               (txt (replace-regexp-in-string "\\*" "·" txt)))
          (with-current-buffer buff
            (insert
             (pcase prop
               ((and (or `(shr-url ,url) `(image-url ,url))
                     (guard (string-match-p "^http" url)))
                (let ((tt (replace-regexp-in-string "\n\\([^$]\\)" " \\1" txt)))
                  (org-link-make-string url tt)))
               (`(outline-level ,n)
                (concat (make-string (- (* 2 n) 1) ?*) " " txt "\n"))
               ('(face italic) (format "/%s/ " (string-trim txt)))
               ('(face bold) (format "*%s* " (string-trim txt)))
               (_ txt))))
          (goto-char next))))
    (pop-to-buffer buff)
    (goto-char (point-min))))

(with-eval-after-load "shr"
    (defun shr-put-image (spec alt &optional flags)
      "Insert image SPEC with a string ALT.  Return image.
SPEC is either an image data blob, or a list where the first
element is the data blob and the second element is the content-type.
Hack to use `insert-sliced-image' to avoid jerky image scrolling."
      (if (display-graphic-p)
          (let* ((size (cdr (assq 'size flags)))
                 (data (if (consp spec)
                           (car spec)
                         spec))
                 (content-type (and (consp spec)
                                    (cadr spec)))
                 (start (point))
                 (image (cond
                         ((eq size 'original)
                          (create-image data nil t :ascent 100
                                        :format content-type))
                         ((eq content-type 'image/svg+xml)
                          (create-image data 'svg t :ascent 100))
                         ((eq size 'full)
                          (ignore-errors
                            (shr-rescale-image data content-type
                                               (plist-get flags :width)
                                               (plist-get flags :height))))
                         (t
                          (ignore-errors
                            (shr-rescale-image data content-type
                                               (plist-get flags :width)
                                               (plist-get flags :height)))))))
            (when image
              (let* ((image-pixel-cons (image-size image t))
                     (image-pixel-width (car image-pixel-cons))
                     (image-pixel-height (cdr image-pixel-cons))
                     (image-scroll-rows (round (/ image-pixel-height (default-font-height)))))
                ;; When inserting big-ish pictures, put them at the
                ;; beginning of the line.
                (when (and (> (current-column) 0)
                           (> (car (image-size image t)) 400))
                  (insert "\n"))

                (insert-sliced-image image (or alt "*") nil image-scroll-rows 1)
                ;; (if (eq size 'original)
                ;;     (insert-sliced-image image (or alt "*") nil image-scroll-rows 1)
                ;;   (insert-image image (or alt "*")))

                (put-text-property start (point) 'image-size size)
                (when (and shr-image-animate
                           (cond ((fboundp 'image-multi-frame-p)
                                  ;; Only animate multi-frame things that specify a
                                  ;; delay; eg animated gifs as opposed to
                                  ;; multi-page tiffs.  FIXME?
                                  (cdr (image-multi-frame-p image)))
                                 ((fboundp 'image-animated-p)
                                  (image-animated-p image))))
                  (image-animate image nil 60))))
            image)
        (insert (or alt "")))))

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
         (download-dir (expand-file-name "~/builds"))
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

(use-package! engine-mode
  :defer t
  :config
  (engine-mode t)
  (defengine githubcs
    "https://github.com/search?type=code&auto_enroll=true&q=%s"
    :keybinding "g")
  (defengine github
    "https://github.com/search?ref=simplesearch&q=%s"
    :keybinding "h")
  (defengine presearch
    "https://presearch.com/search?q=%s"
    :keybinding "p")
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
    :keybinding "u"))

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
       :desc "langtool check" "k" 'languagetool-check
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

(use-package! monkeytype
  :defer t
  :config
  (setq monkeytype-downcase nil)
  (setq monkeytype-randomize nil)
  (defun monkeytype--process-input-timer-init ()
    (unless monkeytype--start-time
      (setq monkeytype--current-run-start-datetime
            (format-time-string "%a-%d-%b-%Y %H:%M:%S"))
      (setq monkeytype--start-time (float-time))
      (monkeytype--utils-idle-timer 5000 'monkeytype-pause)))
  (add-hook 'monkeytype-mode-hook #'my/monkeytype-mode-hook))

(defun my/monkeytype-mode-hook ()
  "Hooks for monkeytype-mode."
  (evil-escape-mode -1)
  (flyspell-mode -0)
  (corfu-mode -0)
  (evil-insert -1)
  ;; (text-scale-set 3)
  (+zen/toggle))


(map! :after org
      :leader
      :prefix "o"
      :desc "open monkeytype"
      :n "m" #'monkeytype-load-words-from-file)

(defvar monkeytype-mode-map
  (let ((map (make-sparse-keymap))
        (mappings '("C-c m p" monkeytype-pause
                    "C-c m r" monkeytype-resume
                    "C-c m s" monkeytype-stop
                    "C-c m t" monkeytype-repeat
                    "C-c m f" monkeytype-fortune
                    "C-c m m" monkeytype-mistyped-words
                    "C-c m h" monkeytype-hard-transitions
                    "C-c m a" monkeytype-save-mistyped-words
                    "C-c m l" monkeytype-toggle-mode-line
                    "C-c m e" monkeytype-wpm-peek
                    "C-c m o" monkeytype-save-hard-transitions)))
    (cl-loop for (key fn) on mappings by #'cddr
             do (define-key map (kbd key) fn))
    map)
  "Keymap for `monkeytype-mode' buffers.")

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
  :config (setq pomidor-sound-tick nil
                pomidor-sound-tack nil)
  (map! (:map pomidor-mode-map
         :desc "quit window"
         :n "q" #'+popup/quit-window
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
         :n "M-SPC" #'pomidor-break)))

(use-package! dslide
  :after org
  :defer t
  :config
  (add-hook 'dslide-start-hook #'my-present-start-hook)
  (add-hook 'dslide-stop-hook #'my-present-quit-hook))

(map! :prefix ("C-c d" . "dslide")
      :desc "dslide-deck-start"
      :n "s" #'dslide-deck-start
      :desc "dslide deck stop"
      :n "q" #'dslide-deck-stop)

(map! :map dslide-mode-map
      [remap evil-next-line] #'dslide-deck-forward
      [remap evil-previous-line] #'dslide-deck-backward
      :desc "dslide deck stop"
      :n "q" #'dslide-deck-stop
      :desc "dslide deck forward"
      :n "j" #'dslide-deck-forward
      :desc "dslide deck backwards"
      :n "k" #'dslide-deck-backward)

(defun my-present-start-hook ()
  (+zen/toggle-fullscreen)
  (hide-mode-line-mode)
  (org-display-inline-images))

(defun my-present-quit-hook ()
  (toggle-frame-fullscreen)
  (hide-mode-line-mode -0)
  (org-remove-inline-images))
