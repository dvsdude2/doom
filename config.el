;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!
;; This is only needed once, near the top of the file

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "dvsdude"
      user-mail-address "john@doe.com")

;;;; package manament ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; =============================================================================

(straight-use-package 'use-package)

(eval-when-compile
(require 'use-package))

;;;; FONTS ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))
;;
;;; My font settings ;;;;;;;;;;;;;;;;;;;;;
(require 'mixed-pitch)
(mixed-pitch-mode)
(add-hook 'text-mode-hook #'mixed-pitch-mode)
(variable-pitch-mode t)


(setq doom-font (font-spec :family "Hack Nerd Font" :size 17 :weight 'bold)
     doom-variable-pitch-font (font-spec :family "DroidSansMono Nerd Font" :size 18 :weight 'book)
     doom-big-font (font-spec :family "Hack Nerd Font" :size 24))


;; DTs font config;;;;;;;;;;;;;;;;;;;;;;;

;; (setq doom-font (font-spec :family "Source Code Pro" :size 15)
;;       doom-variable-pitch-font (font-spec :family "Ubuntu" :size 15)
;;       doom-big-font (font-spec :family "Source Code Pro" :size 24))

;; motis theme creator config ;;;;;;;;;;
;; Using ~set-face-attribute
;;For me a monospaced font should be the standard, so in practice I
;; configure =default= and =fixed-pitch= to use the same typeface.

;; (set-face-attribute 'default nil :font "Hack-16")
;; (set-face-attribute 'fixed-pitch nil :font "Hack-16")
;; (set-face-attribute 'variable-pitch nil :font "FiraGO-18")

;; dieago zamboni's font favs ;;;;;;;;;;
;; (setq doom-font (font-spec :family "Fira Code Retina" :size 18)
;;       doom-variable-pitch-font (font-spec :family "ETBembo" :size 18))
#'+end_src

;;;; theme ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; =============================================================================

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-one)
(setq doom-theme 'doom-Iosvkem)

;;;; Line settings ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; =============================================================================

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type `relative)

;; Sensible line breaking
;; (add-hook 'text-mode-hook 'visual-line-mode)
(global-visual-line-mode 1)
;;no fringe;;;
(set-fringe-mode 0)

(require 'page-break-lines)
(global-page-break-lines-mode)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how

;;Maximize the window upon startup ;;;;;
(add-to-list 'initial-frame-alist '(fullscreen . maximized))

;; set fancy splash-image ;;;;;;;;;;;;;;
(setq fancy-splash-image "~/.doom.d/splash/doom-color.png")

;;; Dashboard ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (require 'dashboard)
;; (setq inhibit-startup-screen t)
;; ;; (use-package dashboard)
;; (setq dashboard-center-content t)
;; (setq dashboard-set-heading-icons t)
;; (setq dashboard-set-file-icons t)
;; (setq dashboard-set-navigator t)
;; (setq dashboard-set-init-info t)
;; ;; To disable shortcut "jump" indicators for each section, set
;; ;; (setq dashboard-show-shortcuts nil)
;; (setq dashboard-items '((recents  . 5)
;;                         (bookmarks . 5)
;;                         (projects . 5)
;;                         (agenda . 5)
;;                         (registers . 5)))
;; (dashboard-modify-heading-icons '((recents . "file-text")
;;                                   (bookmarks . "book")))
;; (dashboard-setup-startup-hook)
;; (setq dashboard-startup-banner "~/.doom.d/splash/doom-color.png")
;; (setq dashboard-banner-logo-title "Wecome to Dvsdude's E to the mother fuckin MACS")
;; (setq initial-buffer-choice (lambda()(get-buffer "*dashboard*")))
;; (setq doom-fallback-buffer "*dashboard*")
;; (provide 'init-dashboard)

(evil-embrace-enable-evil-surround-integration)

#'+begin_src
;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
;;;; org-settings ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; =============================================================================
;; (require 'org)
;; (setq dotfiles-dir (file-name-directory (or (buffer-file-name) load-file-name)))

;; (let* ((org-dir (expand-file-name
;;                  "lisp" (expand-file-name
;;                          "org" (expand-file-name
;;                                 "src" dotfiles-dir))))
;;        (org-contrib-dir (expand-file-name
;;                          "lisp" (expand-file-name
;;                                  "contrib" (expand-file-name
;;                                             ".." org-dir))))
;;        (load-path (append (list org-dir org-contrib-dir)
;;                           (or load-path nil))))
;;   ;; load up Org and Org-babel
;;   (require 'org)
;;   (require 'ob-tangle))

;; ;; load up all literate org-mode files in this directory
;; (mapc #'org-babel-load-file (directory-files dotfiles-dir t "\\.org$"))

;; jump to org folder;;;;;;;;;;;;;;;;;;;
(global-set-key (kbd "C-c o")
                (lambda () (interactive) (find-file "~/org/organizer.org")))

;; default file for notes ;;;;;;;;;;;;;;
(setq org-default-notes-file (concat org-directory "~/org/notes.org"))

;; ;; Better bullets; having an actual circular bullet, is just nice:
;; (font-lock-add-keywords 'org-mode)
;;                            '(("^ +\\([-*]\\) "
;;                               (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•")))))

;; (font-lock-add-keywords
;;  'org-mode
;;  '(("^[[:space:]]*\\(-\\) "
;;    ; 0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "—")))))

;; Org-wiki simple
(require 'plain-org-wiki)
(setq plain-org-wiki-directory "~/org/wiki")

(setq org-agenda-include-diary t)
(setq org-agenda-timegrid-use-ampm 1)

;; (require 'org-superstar)
;; (add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))

;; Improve org mode looks
(setq org-startup-indented t
      org-pretty-entities t
      org-hide-emphasis-markers t
      org-startup-with-inline-images t)
;
(custom-set-faces
  '(org-level-1 ((t (:inherit outline-1 :height 1.2))))
  '(org-level-2 ((t (:inherit outline-2 :height 1.0))))
  '(org-level-3 ((t (:inherit outline-3 :height 1.0))))
  '(org-level-4 ((t (:inherit outline-4 :height 1.0))))
  '(org-level-5 ((t (:inherit outline-5 :height 1.0))))
)
;; Nice bullets
;; (use-package org-superstar
;;     :config
;;     (setq org-superstar-special-todo-items t)
;;     (add-hook 'org-mode-hook (lambda ()
;;                                (org-superstar-mode 1))))

;;;; Markdown ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; =============================================================================

(add-hook 'markdown-mode-hook 'pandoc-mode)

;; default markdown-mode's markdown-live-preview-mode to vertical split
(setq split-height-threshold nil)

;;;; Whitespace -- is to color change text that goes beyond limit ;;;;;;;;;;;;;;
;; =============================================================================

;; lines-tail, highlight the part that goes beyond the
;; limit of whitespace-line-column
(require 'whitespace)
(setq whitespace-line-column 68)
(setq whitespace-style '(face lines-tail))
;; toggle whitespace ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key (kbd "C-c s") 'whitespace-mode)

;;;; Keychords ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; =============================================================================

(require 'key-chord)
(key-chord-mode 1)
;; Exit insert mode by pressing j and then j quickly
;; Max time delay between two key presses to be considered a key chord
(setq key-chord-two-keys-delay 0.5) ; default 0.1
;; Max time delay between two presses of the same key to be considered a key chord.
;; Should normally be a little longer than;key-chord-two-keys-delay.
(setq key-chord-one-key-delay 0.6) ; default 0.2
(key-chord-define evil-insert-state-map "jj" 'evil-normal-state)
(key-chord-define evil-insert-state-map "jh" 'evil-normal-state)

;;; Neotree ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'neotree)
(global-set-key [f8] 'neotree-toggle)
(setq neo-smart-open t)

;;;; Auto completion ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;==============================================================================

;; Completion words longer than 4 characters
   ;; (custom-set-variables
   ;;   '(ac-ispell-requires 4)
   ;;   '(ac-ispell-fuzzy-limit 4))

   ;; (eval-after-load "auto-complete"
   ;;   '(progn
   ;;       (ac-ispell-setup)))

   ;; (add-hook 'git-commit-mode-hook 'ac-ispell-ac-setup)
   ;; (add-hook 'mail-mode-hook 'ac-ispell-ac-setup)


;; (require 'orderless)
;; (setq completion-styles '(orderless))

;;;; company ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; =============================================================================

;; (use-package company
;;   :config
;;   (setq company-idle-delay 0
;;         company-minimum-prefix-length 3
;;         company-selection-wrap-around t))
;; (global-company-mode)

;;;; marginalia ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Enable richer annotations using the Marginalia package ;;;;;;;;;;;;;;;;;;;;;;
;; =============================================================================

(use-package marginalia
  ;; The :init configuration is always executed (Not lazy!)
  :init
  ;; Must be in the :init section of use-package such that the mode gets
  ;; enabled right away. Note that this forces loading the package.
  (marginalia-mode))

;;;; VERTICO ;;;;;;;;;;;;home page;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;==============================================================================

(use-package vertico
  :init
  (vertico-mode)
  (setq vertico-cycle t))
(use-package orderless
  :init
  ;; (setq completion-styles '(basic substring partial-completion flex))
  ;; (setq completion-styles '(substring orderless))
  (setq completion-styles '(orderless)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))
;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package savehist
  :init
  (savehist-mode))
(use-package emacs
  :init
  ;; Alternatively try `consult-completing-read-multiple'.
  (defun crm-indicator (args)
    (cons (concat "[CRM] " (car args)) (cdr args)))
  (advice-add #'completing-read-multiple :filter-args #'crm-indicator)
  ;; Do not allow the cursor in the minibuffer prompt
  (setq minibuffer-prompt-properties
        '(read-only t cursor-intangible t face minibuffer-prompt))
  (add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)

  ;; Enable recursive minibuffers
  (setq enable-recursive-minibuffers t))
;; Use `consult-completion-in-region' if Vertico is enabled.
;; Otherwise use the default `completion--in-region' function.
(setq completion-in-region-function
      (lambda (&rest args)
        (apply (if vertico-mode
                   #'consult-completion-in-region
                 #'completion--in-region)
               args)))
(advice-add #'completing-read-multiple
            :override #'consult-completing-read-multiple)
(setq org-refile-use-outline-path 'file
      org-outline-path-complete-in-steps nil)
(advice-add #'tmm-add-prompt :after #'minibuffer-hide-completions)
(use-package marginalia
  :after vertico
  :custom
  (marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light nil))
  :init
  (marginalia-mode))
;;;; corfu ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; =============================================================================

(use-package corfu
  ;; Optional customizations
  ;; :custom
  ;; (corfu-cycle t)                ;; Enable cycling for `corfu-next/previous'
  ;; (corfu-auto t)                 ;; Enable auto completion
  ;; (corfu-commit-predicate nil)   ;; Do not commit selected candidates on next input
  ;; (corfu-quit-at-boundary t)     ;; Automatically quit at word boundary
  ;; (corfu-quit-no-match t)        ;; Automatically quit if there is no match
  ;; (corfu-preview-current nil)    ;; Disable current candidate preview
  ;; (corfu-preselect-first nil)    ;; Disable candidate preselection
  ;; (corfu-echo-documentation nil) ;; Disable documentation in the echo area
  ;; (corfu-scroll-margin 5)        ;; Use scroll margin

  ;; You may want to enable Corfu only for certain modes.
  ;; :hook ((prog-mode . corfu-mode)
  ;;        (shell-mode . corfu-mode)
  ;;        (eshell-mode . corfu-mode))

  ;; Recommended: Enable Corfu globally.
  ;; This is recommended since dabbrev can be used globally (M-/).
  :init
  (corfu-global-mode))

(use-package orderless
  :init
  ;; (setq completion-styles '(basic substring partial-completion flex))
  ;; (setq completion-styles '(substring orderless))
  (setq completion-styles '(orderless)
        completion-category-defaults nil
        completion-category-overrides '((file (styles . (partial-completion))))))
;; Use dabbrev with Corfu!
(use-package dabbrev
  ;; Swap M-/ and C-M-/
  :bind (("M-/" . dabbrev-completion)
         ("C-M-/" . dabbrev-expand)))
(use-package emacs
  :init
  ;; TAB cycle if there are only few candidates
  (setq completion-cycle-threshold 3)
  ;; Enable indentation+completion using the TAB key.
  ;; `completion-at-point' is often bound to M-TAB.
  (setq tab-always-indent 'complete))

;;;; Embark;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; =============================================================================
(use-package embark
   :init
   ;; Optionally replace the key help with a completing-read interface
   (setq prefix-help-command #'embark-prefix-help-command)
   :config
   ;; Hide the mode line of the Embark live/completions buffers
   (add-to-list 'display-buffer-alist
 	       '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
 		 nil
 		 (window-parameters (mode-line-format . none)))))

(defun embark-which-key-indicator ()
;; An embark indicator that displays keymaps using which-key.
;; The which-key help message will show the type and value of the
;; current target followed by an ellipsis if there are further
;; targets."
  (lambda (&optional keymap targets prefix)
    (if (null keymap)
        (which-key--hide-popup-ignore-command)
      (which-key--show-keymap
       (if (eq (plist-get (car targets) :type) 'embark-become)
           "Become"
         (format "Act on %s '%s'%s"
                 (plist-get (car targets) :type)
                 (embark--truncate-target (plist-get (car targets) :target))
                 (if (cdr targets) "…" "")))
       (if prefix
           (pcase (lookup-key keymap prefix 'accept-default)
             ((and (pred keymapp) km) km)
             (_ (key-binding prefix 'accept-default)))
         keymap)
       nil nil t (lambda (binding)
                   (not (string-suffix-p "-argument" (cdr binding))))))))

(setq embark-indicators
  '(embark-which-key-indicator
    embark-highlight-indicator
    embark-isearch-highlight-indicator))

(defun embark-hide-which-key-indicator (fn &rest args)
  "Hide the which-key indicator immediately when using the completing-read prompter."
  (which-key--hide-popup-ignore-command)
  (let ((embark-indicators
         (remq #'embark-which-key-indicator embark-indicators)))
      (apply fn args)))

(advice-add #'embark-completing-read-prompter
            :around #'embark-hide-which-key-indicator)
;;;; CONSULT ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;==============================================================================
;; Example configuration for Consult
(use-package consult
  ;; Replace bindings. Lazily loaded due by `use-package'.
  :bind (;; C-c bindings (mode-specific-map)
         ;; ("C-c h" . consult-history)
         ;; ("C-c m" . consult-mode-command)
         ;; ("C-c b" . consult-bookmark)
         ;; ("C-c k" . consult-kmacro)
         ;; ;; C-x bindings (ctl-x-map)
         ;; ("C-x M-:" . consult-complex-command)     ;; orig. repeat-complex-command
         ;; ("C-x b" . consult-buffer)                ;; orig. switch-to-buffer
         ;; ("C-x 4 b" . consult-buffer-other-window) ;; orig. switch-to-buffer-other-window
         ;; ("C-x 5 b" . consult-buffer-other-frame)  ;; orig. switch-to-buffer-other-frame
         ;; ;; Custom M-# bindings for fast register access
         ;; ("M-#" . consult-register-load)
         ;; ("M-'" . consult-register-store)          ;; orig. abbrev-prefix-mark (unrelated)
         ;; ("C-M-#" . consult-register)
         ;; ;; Other custom bindings
         ;; ("M-y" . consult-yank-pop)                ;; orig. yank-pop
         ;; ("<help> a" . consult-apropos)            ;; orig. apropos-command
         ;; ;; M-g bindings (goto-map)
         ;; ("M-g e" . consult-compile-error)
         ;; ("M-g f" . consult-flymake)               ;; Alternative: consult-flycheck
         ;; ("M-g g" . consult-goto-line)             ;; orig. goto-line
         ;; ("M-g M-g" . consult-goto-line)           ;; orig. goto-line
          ("M-g o" . consult-outline))               ;; Alternative: consult-org-heading
         ;; ("M-g m" . consult-mark)
         ;; ("M-g k" . consult-global-mark)
         ;; ("M-g i" . consult-imenu)
         ;; ("M-g I" . consult-imenu-multi)
         ;; ;; M-s bindings (search-map)
         ;; ("M-s f" . consult-find)
         ;; ("M-s F" . consult-locate)
         ;; ("M-s g" . consult-grep)
         ;; ("M-s G" . consult-git-grep)
         ;; ("M-s r" . consult-ripgrep)
         ;; ("M-s l" . consult-line)
         ;; ("M-s L" . consult-line-multi)
         ;; ("M-s m" . consult-multi-occur)
         ;; ("M-s k" . consult-keep-lines)
         ;; ("M-s u" . consult-focus-lines)
         ;; Isearch integration
         ;; ("M-s e" . consult-isearch-history)
         ;; :map isearch-mode-map
         ;; ("M-e" . consult-isearch-history)         ;; orig. isearch-edit-string
         ;; ("M-s e" . consult-isearch-history)       ;; orig. isearch-edit-string
         ;; ("M-s l" . consult-line)                  ;; needed by consult-line to detect isearch
         ;; ("M-s L" . consult-line-multi))           ;; needed by consult-line to detect isearch

  ;; Enable automatic preview at point in the *Completions* buffer. This is
  ;; relevant when you use the default completion UI. You may want to also
  ;; enable `consult-preview-at-point-mode` in Embark Collect buffers.
  :hook (completion-list-mode . consult-preview-at-point-mode)
)

;;; ignore-case ;;;;;;;;;;;;;;;;;;;;;;;;
(setq read-file-name-completion-ignore-case t
      read-buffer-completion-ignore-case t
      completion-ignore-case t)

;;; whichkey ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(which-key-setup-minibuffer)
;; (which-key-setup-side-window-bottom)
;;(which-key-setup-side-window-right)
;;(which-key-setup-side-window-right-bottom)

;;; elfeed ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (require 'elfeed-goodies)
;; (elfeed-goodies/setup)

;;; this should replicate scrolloff in vim;;;;;;;;

(setq scroll-conservatively 111
      scroll-margin 9
      scroll-preserve-screen-position 't)


;;; move or transpose lines up/down;;;;;;;;;;;;;;;

(defun move-line-up ()
  (interactive)
  (transpose-lines 1)
  (forward-line -2))

(defun move-line-down ()
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1))

(global-set-key (kbd "M-<up>") 'move-line-up)
(global-set-key (kbd "M-<down>") 'move-line-down)


;;; save last & open last place edited;;;;;;;;;;;;

(save-place-mode 1)
(setq save-place-forget-unreadable-files nil)
(setq save-place-file "~/.emacs.d/saveplace")

;; save updated bookmarks;;;;;;;;;;;;;;;;;;;;;;;;;

(setq bookmark-save-flag 1)
;; (defcustom bookmark-save-flag 1)

;;;; personal keybindings ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; =============================================================================

(require 'all-the-icons)
;; (setq org-element-use-cache nil)
