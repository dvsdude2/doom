;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

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
(add-to-list 'load-path "~/.config/doom/myrepo/champagne")
(add-to-list 'load-path "~/.config/doom/myrepo/svg-clock")
(add-to-list 'load-path "~/.config/doom/myrepo/video-trimmer")
(add-to-list 'load-path "~/.config/doom/myrepo/my-reformat-paragraph")

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

(setq doom-scratch-initial-major-mode "org")
;; add newlines auto
(setq next-line-add-newlines t)
;; v$ not include \n character
(setq! evil-v$-excludes-newline t)
(setq evil-respect-visual-line-mode t)
(setq evil-cross-lines t)
(global-visual-line-mode 1)
(map! :map evil-org-mode-map
      [remap evil-org-end-of-line] #'evil-end-of-line)

;; repeat-mode
(repeat-mode 1)
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
;; ;; use trash
;; (setq trash-directory "~/.local/share/Trash/files/")
;; (setq delete-by-moving-to-trash t)
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
;; let v$ not include newline char
(setq evil-v$-excludes-newline t)
;; Maximize the window upon startup
(add-to-list 'initial-frame-alist '(fullscreen . maximized))
;;;  "Syntax color, highlighting code colors ;;;;
(add-hook 'prog-mode-hook #'rainbow-mode)
;; Sensible line breaking
(add-hook 'text-mode-hook 'visual-line-mode)
;; automatic chmod +x when you save a file with a #! shebang
(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)
;; this should make it easier to change custom-variables
;; using `csetq'
(defmacro csetq (sym val)
  "Set a SYM custom VAL with csetq."
  `(funcall (or (get ',sym 'custom-set) 'set-default) ',sym ,val))
;; use current clocked in time in modline.
(csetq org-clock-mode-line-total 'current)
;; decided this was not needed
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
  (setq dashboard-items '((recents . 9)
                          (agenda . 10)))
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

(use-package! dirvish
  :commands dirvish-find-entry-a dirvish-dired-noselect-a
  :general (dired-mode-map "C-c C-r" #'dirvish-rsync)
  :init
  (setq dirvish-cache-dir (file-name-concat doom-cache-dir "dirvish/"))
  ;; HACK: ...
  (advice-add #'dired--find-file :override #'dirvish--find-entry)
  (advice-add #'dired-noselect :around #'dirvish-dired-noselect-a)
  :config
  (dirvish-override-dired-mode)
  (set-popup-rule! "^ ?\\*\\(?:[Dd]irvish\\|SIDE :: \\).*" :ignore t)

  ;; Fixes #8038. This setting is for folks who expect to be able to switch back
  ;; to dired buffers where the file is opened from.  In other cases, don't
  ;; recycle sessions. We don't want leftover buffers lying around, especially
  ;; if users are reconfiguring Dirvish or trying to recover from an error. It's
  ;; too easy to accidentally break Dirvish (e.g. by focusing the header window)
  ;; at the moment.  Starting from scratch isn't even that expensive, anyway.
  (setq dirvish-reuse-session 'open)

  (if (modulep! +dirvish)
      (setq dirvish-attributes '(file-size)
            dirvish-mode-line-format
            '(:left (sort file-time symlink) :right (omit yank index)))
    (setq dirvish-attributes '(file-size nerd-icons)
          dirvish-use-header-line nil
          dirvish-use-mode-line nil))

  ;; Match the height of `doom-modeline', if it's being used.
  ;; TODO: Make this respect user changes to these variables.
  (when (modulep! :ui modeline)
    (add-hook! 'dired-mode-hook
      (defun +dired-update-mode-line-height-h ()
        (when-let (height (bound-and-true-p doom-modeline-height))
          (setq dirvish-mode-line-height height
                dirvish-header-line-height height)))))

  (when (modulep! :ui vc-gutter)
    ;; The vc-gutter module uses `diff-hl-dired-mode' + `diff-hl-margin-mode'
    ;; for diffs in dirvish buffers. `vc-state' uses overlays, so they won't be
    ;; visible in the terminal.
    (when (or (daemonp) (display-graphic-p))
      (push 'vc-state dirvish-attributes)))

  (when (modulep! +icons)
    (setq dirvish-subtree-always-show-state t)
    (cl-callf append dirvish-attributes '(nerd-icons subtree-state)))

  (setq dirvish-hide-details '(dired dirvish dirvish-side)
        dirvish-hide-cursor '(dirvish dirvish-side))

  (when (modulep! :ui tabs)
    (after! centaur-tabs
      (add-hook 'dired-mode-hook #'centaur-tabs-local-mode)
      (add-hook 'dirvish-directory-view-mode-hook #'centaur-tabs-local-mode)))

  ;; TODO: Needs more polished keybinds for non-Evil users
  (map! :map dirvish-mode-map
        :n  "?"   #'dirvish-dispatch
        :n  "q"   #'dirvish-quit
        :n  "b"   #'dirvish-quick-access
        :ng "f"   #'dirvish-file-info-menu
        :n  "p"   #'dirvish-yank
        :ng "S"   #'dirvish-quicksort
        :n  "F"   #'dirvish-layout-toggle
        :n  "z"   #'dirvish-history-jump
        :n  "gh"  #'dirvish-subtree-up
        :n  "gl"  #'dirvish-subtree-toggle
        :n  "h"   #'dired-up-directory
        :n  "l"   #'dired-find-file
        :gm [left]  #'dired-up-directory
        :gm [right] #'dired-find-file
        :ng "[d" #'xah-move-to-parent-dir
        :m  "[h"  #'dirvish-history-go-backward
        :m  "]h"  #'dirvish-history-go-forward
        :m  "[e"  #'dirvish-emerge-next-group
        :m  "]e"  #'dirvish-emerge-previous-group
        :n  "TAB" #'dirvish-subtree-toggle
        :ng "M-b" #'dirvish-history-go-backward
        :ng "M-f" #'dirvish-history-go-forward
        :ng "M-n" #'dirvish-narrow
        :ng "M-m" #'dirvish-mark-menu
        :ng "M-s" #'dirvish-setup-menu
        :ng "M-e" #'dirvish-emerge-menu
        (:prefix ("y" . "yank")
         :n "l"   #'dirvish-copy-file-true-path
         :n "n"   #'dirvish-copy-file-name
         :n "p"   #'dirvish-copy-file-path
         :n "r"   #'dirvish-copy-remote-path
         :n "y"   #'dired-do-copy)
        (:prefix ("s" . "symlinks")
         :n "s"   #'dirvish-symlink
         :n "S"   #'dirvish-relative-symlink
         :n "h"   #'dirvish-hardlink))

  ;; HACK: Kill Dirvish session before switching projects/workspaces, otherwise
  ;;   it errors out on trying to delete/change dedicated windows.
  (add-hook! '(persp-before-kill-functions
               persp-before-switch-functions
               projectile-before-switch-project-hook)
    (defun +dired--cleanup-dirvish-h (&rest _)
      (when-let ((dv (cl-loop for w in (window-list)
                              if (window-dedicated-p w)
                              if (with-current-buffer (window-buffer w) (dirvish-curr))
                              return it)))
        (let (dirvish-reuse-session)
          (with-selected-window (dv-root-window dv)
            (dirvish-quit)))))))

;; use open window for default target

(setq dired-dwim-target t)
(setq dired-hide-details-mode t)

;; this needed to use arrow-keys with dired-preview
(define-key! dired-mode-map
  ;; Evil remaps
  [remap evil-next-line]     #'dired-next-line
  [remap evil-previous-line] #'dired-previous-line)

(map! :map dired-mode-map
      :desc "replace space with dash"
      :n "C-c -" #'my/dired-rename-space-to-hyphen)

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
  :after-call after-find-file pre-command-hook
  :config
  (ready-player-mode +1))

(after! dired
  (use-package! dired-open
    :config
    (setq dired-open-extensions '(("mkv" . "mpv")
                                  ("mp4" . "mpv")
                                  ("pdf" . "evince")
                                  ("webm" . "mpv")))))

(defun my/dired-rename-space-to-hyphen ()
  "In dired, rename current or marked files by replacing space to hyphen -.
If not in `dired', do nothing."
  (interactive)
  (require 'dired-aux)
  (if (eq major-mode 'dired-mode)
      (progn
        (mapc (lambda (x)
                (when (string-match " " x )
                  (dired-rename-file x (string-replace " " "-" x) nil)))
              (dired-get-marked-files ))
        (dired-revert))
    (user-error "%s: Not in dired" real-this-command)))

;; default file for notes
(setq org-default-notes-file (concat org-directory "notes.org"))
;; set future deadlines to not show
(setq org-agenda-show-future-repeats nil)
;; default diary files
(setq org-agenda-diary-file "~/org/notable-dates.org")
;; (setq diary-file "~/.config/doom/diary")

;; set org-todo-keywords
(after! org
  (setq org-todo-keywords
        '((sequence "TODO(t)" "PROJ(p)" "NOTE(r)" "STRT(s)" "WAIT(w)" "HOLD(h)" "IDEA(i)" "DRIL(l)" "|" "DONE(d)" "KILL(k)")
          (sequence "[ ](T)" "[-](S)" "[?](W)" "|" "[X](D)")
          (sequence "|" "OKAY(o)" "YES(y)" "NO(n)"))))

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

;; resume clock when clocking into task with open clock.
(setq org-clock-in-resume t)

;; save buffer after clock-in
(add-hook 'org-clock-in-hook 'save-buffer)

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
        org-startup-folded 'show2levels
        org-pretty-entities t
        org-hide-emphasis-markers t
        org-startup-with-inline-images t
        org-image-actual-width '(300)))

(add-hook 'org-mode-hook 'variable-pitch-mode)

;; set font size for headers ;;
(after! org
  (custom-set-faces
   '(org-level-1 ((t (:inherit outline-1 :height 1.5))))
   '(org-level-2 ((t (:inherit outline-2 :height 1.2))))
   '(org-level-3 ((t (:inherit outline-3 :height 1.1))))
   '(org-level-4 ((t (:inherit outline-4 :height 1.0))))
   '(org-level-5 ((t (:inherit outline-5 :height 1.0))))
   '(org-document-title ((t (:height 1.8 :underline t))))
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

(after! org (load! "myrepo/capture-templates/capture-templates.el"))
(add-hook 'org-mode-hook #'set-org-capture-templates)

(setq org-journal-file-type 'weekly)
(setq org-journal-date-format "%A, %d %B %Y")
;; (setq org-journal-enable-agenda-integration t)
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
  (set-fill-column 90)
  (auto-fill-mode)
  (doom-disable-line-numbers-h)
  (buffer-disable-undo)
  (turn-on-visual-line-mode)
  (+zen/toggle))

;; ;; save and exit journal easily
(map! :after org
      :map org-journal-mode-map
      :desc "save and kill journal"
      :ni "C-q" #'doom/save-and-kill-buffer)

(after! org
  (use-package! org-download
    :defer 15
    :config
    (setq-default org-download-image-dir "~/org/wiki/note-images")
    (setq org-download-heading-lvl nil)
    (add-hook 'dired-mode-hook 'org-download-enable)))

(after! org
  (use-package org-rich-yank
    :demand t
    :bind (:map org-mode-map
                ("M-p" . org-rich-yank))))

;; copy and paste images into an org-file
(after! org
  (use-package! org-ros
    :defer t))

;; org insert structural template (C-c C-,) menu for adding code blocks
(after! org
  (use-package! org-tempo
    :config
    (add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))))

(require 'org-web-tools)
;; use to download webpage text content
;; (use-package! org-web-tools)

(defun my-open-calendar ()
  (interactive)
  (calfw-open-calendar-buffer
   :contents-sources
   (list
    (calfw-org-create-source "Green")  ; org-agenda source
    (calfw-org-create-file-source "cal" "~/org/notable-dates.org" "Cyan")  ; other org source
    (calfw-cal-create-source "Orange") ; diary source
    (calfw-ical-create-source "Moon" "~/moon.ics" "Gray")))) ; ICS source1

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
      :n "S" #'embrace-commander)

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
      ;; :m "j" #'evilem-motion-next-line)
      :m "j" #'evil-avy-goto-line-below)
(map! :leader
      :prefix "k"
      :desc "avy goto prev line"
      :m "k" #'evil-avy-goto-line-above)
(setq avy-timeout-seconds 1.5) ;;default 0.5
(setq avy-single-candidate-jump t)

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
      :n "/" #'find-in-dotfiles
      :desc "browse files in ~/.config/"
      :n "." #'browse-dotfiles)

(defun my-github-search(&optional search)
  (interactive (list (read-string "Search: " (thing-at-point 'symbol))))
  (let* ((language (cond ((eq major-mode 'python-mode) "Python")
                 ((eq major-mode 'emacs-lisp-mode) "Emacs Lisp")
                 ((eq major-mode 'org-mode) "Emacs Lisp")
                         (t "Text")))
         (url (format "https://github.com/search/?q=\"%s\"+language:\"%s\"&type=Code" (url-hexify-string search) language)))
    (browse-url url)))

(defun grokipedia-word-lookup ()
  "look up grokipedia of current word."
  (interactive)
  (let ((xword (current-word t t))
        xurl)
    (setq xurl (concat "https://grokipedia.com/search?q=" xword))
    (browse-url xurl)))

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

;;;###autoload
(defvar my/notes-directory "~/org/wiki")

(defun my/notes-directory ()
  "Open dired with my notes files"
  (interactive)
  (dired my/notes-directory "-lt"))

(defun my/notes-new (title)
  "Create a new note given a title"
  (interactive "sTitle: ")
  (let ((default-directory (concat my/notes-directory "/")))
    (find-file (concat (my/title-to-filename title) ".org"))
    (when (= 0 (buffer-size))
      (insert "#+title: " title "\n"
              "#+date: ")
      (org-insert-time-stamp nil)
      (insert "\n\n")))
  (auto-fill-mode)
  (set-fill-column 95))

(defun my/title-to-filename (title)
  "Convert TITLE to a reasonable filename."
  ;; Based on the slug logic in org-roam, but org-roam also uses a
  ;; timestamp, and I use only the slug. BTW "slug" comes from
  ;; <https://en.wikipedia.org/wiki/Clean_URL#Slug>
  (setq title (s-downcase title))
  (setq title (s-replace-regexp "[^a-zA-Z0-9]+" "-" title))
  (setq title (s-replace-regexp "-+" "-" title))
  (setq title (s-replace-regexp "^-" "" title))
  (setq title (s-replace-regexp "-$" "" title))
  title)

(map! :leader
      :prefix "n"
      :desc "make named file & buffer"
      "b" #'my/notes-new)

(defun my/org-drill ()
  "Open my drill file and run org-drill"
  (interactive)
  (find-file (concat org-directory "/wiki/drill.org"))
  (org-drill))

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

(defun toggle-transparency ()
  "Toggle frame alpha-background between 75 and 100."
  (interactive)
  (let* ((current-alpha (or (frame-parameter nil 'alpha-background) 100))
         (new-alpha (if (= current-alpha 100) 75 100)))
    (set-frame-parameter nil 'alpha-background new-alpha)
    (message "Alpha-background set to %d" new-alpha)))

(map! :leader
      (:prefix ("t" . "toggle")
       :desc "toggle transparency" "T" #'toggle-transparency))

;; this keeps the workspace-bar visable
(after! persp-mode
  (defun display-workspaces-in-minibuffer ()
    (with-current-buffer " *Minibuf-0*"
      (erase-buffer)
      (insert (+workspace--tabline))))
  (run-with-idle-timer 1 t #'display-workspaces-in-minibuffer)
  (+workspace/display))

(defun xah-move-to-parent-dir ()
  "move current file or marked file up one dir."
  (interactive)
  (let ((xfiles (dired-get-marked-files))
        xcur-dir
        xparent-dir)
    (setq xcur-dir (file-name-directory (car xfiles)))
    (setq xparent-dir (file-name-parent-directory xcur-dir))
    (mapc
     (lambda (x)
       (rename-file x (concat xparent-dir (file-name-nondirectory x))))
     xfiles)))

(defun dvs/zen-scratch-pad ()
  "Create a new org-mode buffer for random stuff."
  (interactive)
  (let ((buffer (generate-new-buffer "*org scratchy*")))
    (switch-to-buffer buffer)
    (setq buffer-offer-save t)
    (org-mode)
    (auto-fill-mode)
    (set-fill-column 90)
    (doom-disable-line-numbers-h)
    (turn-on-visual-line-mode)
    (+zen/toggle)))

(map! :leader
      :prefix "o"
      :desc "open zen scratch"
      "X" #'dvs/zen-scratch-pad)

(beacon-mode t)

(use-package! champagne
  :after org
  :load-path "/champagne/champagne.el")

(use-package! drag-stuff
  :defer t
  :init
  (map! "<M-up>"    #'drag-stuff-up
        "<M-down>"  #'drag-stuff-down
        "<M-left>"  #'drag-stuff-left
        "<M-right>" #'drag-stuff-right))

(use-package! eshell-git-prompt
  :after eshell
  :config
  (eshell-git-prompt-use-theme 'powerline))

(use-package my-reformat-paragraph
  :after-call doom-first-input-hook
  :load-path "my-reformat-paragraph/my-reformat-paragraph.el")

(use-package! hnreader
  :after elfeed
  :config
  (set-popup-rules!
    '(("^\\*\\(HN\\|HNComments\\)"
       :slot -1 :vslot 2 :size '(+popup-shrink-to-fit)
       :select t :quit t))))

;; (setq greader-keymap-prefix "C-c r")
(use-package! greader
  :commands (greader-mode)
  :hook (elfeed-show-mode . greader-mode)
  :custom
  (greader-keymap-prefix "C-c r")
  :config
  (map! :map greader-prefix-keymap
        "SPC" nil
        "s" #'greader-toggle-tired-mode
        "r" #'greader-read
        "l" #'greader-set-language
        "t" #'greader-toggle-timer
        "b" #'greader-change-backend)
  (map! :map greader-reading-map
        (:prefix-map ("C-c r" . greader-mode)
        "SPC" nil
        "r" #'greader-stop
        "p" #'greader-toggle-punctuation
        "." #'greader-stop-with-timer
        "+" #'greader-inc-rate
        "-" #'greader-dec-rate
        "<left>" #'greader-backward
        "<RIGHT>" #'greader-forward)))



(map! :leader
      :prefix "t"
      :desc "toggle greader"
      :n "G" #'greader-mode)

(use-package! journalctl-mode
  :defer t)

(use-package! olivetti
  :defer t)

(setq plantuml-jar-path "/usr/share/java/plantuml/plantuml.jar")
  ;; Enable plantuml-mode for PlantUML files
(add-to-list 'auto-mode-alist '("\\.plantuml\\'" . plantuml-mode))
  ;; Enable exporting
(org-babel-do-load-languages 'org-babel-load-languages '((plantuml . t)))

(use-package piper-mode
  :defer t
  :custom
  ;; Set your preferred voice model (will be auto-downloaded on first use)
  (piper-voice-model "en_US-joe-medium.onnx")
  :config
  (piper-mode))

(use-package! powerthesaurus
  :defer t)

(use-package video-trimmer
  :after-call doom-first-input-hook
  :load-path "video-trimmer/video-trimmer.el")

(use-package! rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode)
  :custom (rainbow-delimiters-max-face-count 6))

(use-package! svg-clock
  :defer 30
  :load-path "svg-clock/svg-clock.el")

(use-package! substitute
  :after-call after-find-file pre-command-hook
  :config
  ;; Use C-c s as a prefix for all Substitute commands.
  (define-key global-map (kbd "C-c s") #'substitute-prefix-map)
  ;; upper and lower case will not change if this is nil
  (setq substitute-fixed-letter-case t)
  ;; report the number of changes
  (add-hook 'substitute-post-replace-functions #'substitute-report-operation))

(use-package! tray
  :after-call doom-first-input-hook
  :load-path "tray/tray.el")

(use-package! wiktionary-bro
  :commands (wiktionary-bro-dwim))
;; :config
(map! :leader
      :prefix ("s" . search)
      :desc "Wiktionary"
      "w" #'wiktionary-bro-dwim)

(use-package! wiki-summary
  :after-call doom-first-input-hook
  :load-path "/wiki-summary/wiki-summary.el")

;; (zone-when-idle 60)

;; trays
(map! (:prefix-map ("<f5>" . "list trays")
                   "t" #'tray-term
                   "l" #'tray-lookup
                   "a" #'tray-evilem-motion
                   "s" #'tray-smart-parens
                   "v" #'tray-vertico-menu
                   "g" #'tray-epa-dispatch
                   "y" #'tray-epa-key-list-dispatch))

(map! "<f6>" #'scroll-lock-mode)
(map! "<f7>" #'evil-forward-sentence-begin)
(map! "<f8>" #'tray-lookup)
(map! "<f9>" #'engine/search-brave)

;; (b) create source-block
(map! :after org
      :leader
      :prefix "c"
      :desc "create code block"
      :n "b" #'org-insert-structure-template
      :desc "break/split code block"
      :n "B" #'org-babel-demarcate-block)

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
      :desc "write region"
      :n "R" #'write-region
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
(map! :leader
      ;; "o" nil ; we need to unbind it first as Org claims this prefix
      (:prefix-map ("o" . "open")
      :desc "cycle agenda files"
      :n    "a f" #'org-cycle-agenda-files
      :desc "open calendar"
      :n    "c" #'=calendar
      :desc "open Dashboard"
      :n    "D" #'dashboard-open
      :desc "open defalt scratch-buffer"
      :n    "x" #'scratch-buffer
      :desc "run org-drill on drill file"
      :n    "l" #'my/org-drill
      :desc "open org config in workspace"
      :n    "I" #'=config
      :desc "open org config"
      :n    "i" (lambda () (interactive) (find-file "~/.config/doom/config.org"))
      :desc "open org notes"
      :n    "n" (lambda () (interactive) (find-file "~/org/notes.org"))
      :desc "open org organizer"
      :n    "0" (lambda () (interactive) (find-file "~/org/organizer.org"))
      :desc "open org Directory"
      :n    "o" (lambda () (interactive) (find-file "~/org/"))
      :desc "open org wiki"
      :n    "k" (lambda () (interactive) (find-file "~/org/wiki/"))
      :desc "update readme using ediff"
      :n    "u" #'dvs/readme-update-ediff))

;; (t) toogle
(map! :leader
      :prefix ("t" . "toggle")
      :desc "start count down timer"
      :n "C" #'champagne
      :desc "toggle eshell"
      :n "e" #'+eshell/toggle
      :desc "toggle olivetti-mode"
      :n "o" 'olivetti-mode
      :desc "toggle pandoc-mode"
      :n "P" #'pandoc-mode
      :desc "toggle focus-mode"
      :n "u" #'focus-mode
      :desc "toogle spray-mode"
      :n "y" #'spray-mode)

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
;; insert structural template
(map! "C-c b" #'org-insert-structure-template)
;; start modes
(map! (:prefix-map ("C-c M" . "mode-command")
                   "o" #'org-mode
                   "i" #'lisp-interaction-mode
                   "e" #'emacs-lisp-mode
                   "f" #'fundamental-mode))
;; trays
(map! (:prefix-map ("C-c t" . "list trays")
                   "t" #'tray-term
                   "l" #'tray-lookup
                   "a" #'tray-evilem-motion
                   "s" #'tray-smart-parens
                   "v" #'tray-vertico-menu
                   "g" #'tray-epa-dispatch
                   "y" #'tray-epa-key-list-dispatch))
;; video related
(map! (:prefix-map ("C-c v" . "video-related")
       :desc "extract subtitles"
       :n    "e" #'youtube-sub-extractor-extract-subs-at-point
       :desc "extract subtitles at point"
       :n    "E" #'youtube-sub-extractor-extract-subs
       :desc "video trimmer"
       :n    "t" #'video-trimmer-trim))

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
(map! "C-3" #'find-file-other-window)

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
        ("^https?://\\(t\\.co/[a-zA-Z0-9]?*\\|x\\.com/[A-Za-z0-9]?*/status/[0-9]?*\\)" . my/mpv-play-url)
        ("^https?://\\(off-guardian\.org\\|\.substack\\.com\\|tomluongo\\.me\\)/" . dvs-eww)
        ("^https?://\\(news.ycombinator.com\\)/" . elfeed-open-hnreader-url)
        ("." . browse-url-default-browser)))
;; * NOTE this `was' a customized variable

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
      :n "y" #'spray-mode)

(map! :map spray-mode-map
        "<return>" #'spray-start/stop
        "M-u" #'spray-faster
        "M-d" #'spray-slower
        "M-n" #'spray-forward-word
        "M-b" #'spray-backward-word
        "q" #'spray-quit)

(defun my/elfeed-search-filter-point (entry)
  "Filter elfeed search buffer by the feed under cursor."
  (interactive (list (elfeed-search-selected :ignore-region)))
  (when (elfeed-entry-p entry)
    (elfeed-search-set-filter
     (concat
      "@6-months-ago "
      ;; "+unread "
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
(defun elfeed-v-mpv (url)
  "open URL in mpv"
  (interactive "P")
  (message "just a sec...video will start soon")
  (start-process "mpv" nil "mpv" url))

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
             do (eww it))
    (mapc #'elfeed-search-update-entry entries)
    (unless (use-region-p) (forward-line))))

;; Open a URL with eww.
(defun my/elfeed-show-visit-eww ()
  "Visit the current entry in eww"
  (interactive)
  (let ((link (elfeed-entry-link elfeed-show-entry)))
    (when link
      (eww-follow-link link))))

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
      :desc "open elfeed" "s" #'=rss)

;; elfeed
(use-package! elfeed
  :commands (elfeed)
  :init
  (setq elfeed-db-directory (concat doom-local-dir "elfeed/db/")
        elfeed-enclosure-default-dir (concat doom-local-dir "elfeed/enclosures/"))
  :config
  (setq elfeed-search-filter "@6-months-ago "
        elfeed-show-entry-switch #'pop-to-buffer
        elfeed-show-entry-delete #'+rss/delete-pane
        elfeed-sort-order 'ascending
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
        :n "F" #'my/elfeed-search-filter-point
        :n "h" #'dvs/elfeed-hn-show-comments
        :n "m" #'elfeed-curate-toggle-star
        :n "r" #'elfeed-search-update--force
        :n "R" #'elfeed-summary
        :n "q" #'elfeed-kill-buffer
        :n "T" #'my/elfeed-reddit-show-commments
        :n "v" #'elfeed-view-mpv
        :n "x" #'elfeed-curate-export-entries
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
  :config
  (elfeed-tube-setup)
  (setq elfeed-tube-invidious-url "https://iv.ggtyler.dev")))

(after! elfeed
(use-package elfeed-tube-mpv))

(load! "myrepo/elfeed-summary-layout/+elfeed-summary-settings")
(use-package! elfeed-summary
  :commands (elfeed-summary)
  :config
  (setq elfeed-summary-settings elfeed-summary-settings)
  (setq elfeed-summary-other-window t))

;; Ensure elfeed buffers are treated as real
(add-hook! 'doom-real-buffer-functions
  (defun elfeed-summary-buffer-p (buf)
    (string-match-p "^\\*elfeed-summary" (buffer-name buf))))

(use-package osm
  :defer t
  :bind ("C-x m" . osm-prefix-map) ;; Alternative: `osm-home'
  :custom
  ;; Take a look at the customization group `osm' for more options.
  (osm-server 'google-maps-roads) ;; Configure the tile server
  (osm-copyright t)     ;; Display the copyright information
  :config
  (global-visual-line-mode -0)
  (osm-add-server 'google-maps-roads
    :name "Google Maps Roads"
    :description "(Non-free API)"
    :url "https://%s.google.com/vt/lyrs=m&x=%x&y=%y&z=%z"
    :subdomains '("mt0" "mt1" "mt2" "mt3")
    :max-connections 16
    :ext 'png
    :group "Google Maps")
  (osm-add-server 'google-maps-hybrid
    :name "Google Maps Hybrid"
    :description "(Non-free API)"
    :url "https://%s.google.com/vt/lyrs=y&x=%x&y=%y&z=%z"
    :subdomains '("mt0" "mt1" "mt2" "mt3")
    :max-connections 16
    :ext 'jpeg
    :group "Google Maps")
  (osm-add-server 'google-maps-satellite
    :name "Google Maps Satellite"
    :description "(Non-free API)"
    :url "https://%s.google.com/vt/lyrs=s&x=%x&y=%y&z=%z"
    :subdomains '("mt0" "mt1" "mt2" "mt3")
    :max-connections 16
    :ext 'jpeg
    :group "Google Maps")
  (osm-add-server 'google-maps-terrain
    :name "Google Maps Terrain"
    :description "(Non-free API)"
    :url "https://%s.google.com/vt/lyrs=p&x=%x&y=%y&z=%z"
    :subdomains '("mt0" "mt1" "mt2" "mt3")
    :ext 'jpeg
    :group "Google Maps"))

(use-package dwim-shell-command
  :defer t
  :bind (([remap shell-command] . dwim-shell-command)
         :map dired-mode-map
         ([remap dired-do-async-shell-command] . dwim-shell-command)
         ([remap dired-do-shell-command] . dwim-shell-command)
         ([remap dired-smart-shell-command] . dwim-shell-command))
  :config
(setq dwim-shell-commands-git-clone-dirs
  '("~/builds" "~/builds/doom-emacs-pkgs"))
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
   :focus-now t)))

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

(setq! +lookup-provider-url-alist
       '(("Doom issues" "https://github.com/orgs/doomemacs/projects/2/views/30?filterQuery=%s")
         ("Doom discourse" "https://discourse.doomemacs.org/search?q=%s")
         ("Google" +lookup--online-backend-google "https://google.com/search?q=%s")
         ("Google images" "https://www.google.com/images?q=%s")
         ("Google maps" "https://maps.google.com/maps?q=%s")
         ("Kagi" "https://kagi.com/search?q=%s")
         ("Project Gutenberg" "http://www.gutenberg.org/ebooks/search/?query=%s")
         ("DuckDuckGo" +lookup--online-backend-duckduckgo "https://duckduckgo.com/?q=%s")
         ("DuckDuckGo tor" "https://duckduckgogg42xjoc72x3sjasowoarfbgcmvfimaftt6twagswzczad.onion/?q=%s")
         ("brave" "https://search.brave.com/?q=%s")
         ("brave tor" "https://search.brave4u7jddbv7cyviptqjc7jusxh72uik7zt6adtckl5f4nwy2v72qd.onion/")
         ("brave llm" "https://search.brave.com/ask?q=%s")
         ("DevDocs.io" "https://devdocs.io/#q=%s")
         ("StackOverflow" "https://stackoverflow.com/search?q=%s")
         ("StackExchange" "https://stackexchange.com/search?q=%s")
         ("Github" "https://github.com/search?ref=simplesearch&q=%s")
         ("Youtube" "https://youtube.com/results?aq=f&oq=&search_query=%s")
         ("Wolfram alpha" "https://wolframalpha.com/input/?i=%s")
         ("Wikipedia" "https://wikipedia.org/search-redirect.php?language=en&go=Go&search=%s")
         ("MDN" "https://developer.mozilla.org/en-US/search?q=%s")
         ("Internet archive" "https://web.archive.org/web/*/%s")
         ("Sourcegraph" "https://sourcegraph.com/search?q=context:global+%s&patternType=literal")))

(use-package markdown-mode
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
  (denote-rename-buffer-mode))

;; ;; By default, we do not show the context of links.  We just display
;; ;; file names.  This provides a more informative view.
;; (setq denote-backlinks-show-context t)

;; map! "spc d n" #'denote
(map! :leader
      (:prefix-map ("d" . "denote")
       :desc "create note"
       :n "n" #'denote
       :desc "denote link"
       :n "l" #'denote-link
       :desc "denote grep"
       :n "g" #'denote-grep
       :desc "denote dired"
       :n "d" #'denote-dired
       :desc "denote rename"
       :n "r" #'denote-rename-file))

(use-package! denote-org
  :defer t)

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
  :commands (ediff ediff-buffers ediff-files)
  :init
  (setq ediff-split-window-function 'split-window-horizontally)
  (setq ediff-window-setup-function 'ediff-setup-windows-plain)
  :config
  (custom-set-faces
   '(ediff-current-diff-A ((t (:background "#663333"))))
   '(ediff-fine-diff-A ((t (:background "indian red"))))
   '(ediff-current-diff-B ((t (:background "#336633"))))
   '(ediff-fine-diff-B ((t (:background "#558855")))))
  (setq ediff-diff-options "-w") ; turn off whitespace checking
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
