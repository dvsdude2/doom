;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

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
;; DTs font config;;;;;;;;;;;;;;;;;;;;;;;
;;
;; (setq doom-font (font-spec :family "Source Code Pro" :size 15)
;;       doom-variable-pitch-font (font-spec :family "Ubuntu" :size 15)
;;       doom-big-font (font-spec :family "Source Code Pro" :size 24))

;; My font settings;;;;;;;;;;;;;;;;;;;;;;
;;
;; (setq doom-font (font-spec :family "Hack Nerd Font" :size 16)
;;      doom-variable-pitch-font (font-spec :family "Hack Nerd Font" :size 16)
;;      doom-big-font (font-spec :family "Hack Nerd Font" :size 24))

;;
(setq doom-font (font-spec :family "DroidSansMono Nerd Font" :size 16 :weight 'Regular)
     doom-variable-pitch-font (font-spec :family "DroidSansMono Nerd Font" :size 16)
     doom-big-font (font-spec :family "DroidSansMono Nerd Font" :size 24))


;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-Iosvkem)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type `relative)
;; Sensible line breaking
(add-hook 'text-mode-hook 'visual-line-mode)


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
;; they are implemented.


;;Maximize the window upon startup
(add-to-list 'initial-frame-alist '(fullscreen . maximized))

;;
;; org-settings ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; =============================================================================
(require 'org-tempo)
;; embrace-commander
(global-set-key (kbd "C-c s") 'embrace-commander)
(add-hook 'org-mode-hook 'embrace-org-mode-hook)
(evil-embrace-enable-evil-surround-integration)
;;
;; jump to org folder
(global-set-key (kbd "C-c o")
                (lambda () (interactive) (find-file "~/org/organizer.org")))

;; default file for notes
(setq org-default-notes-file (concat org-directory "~/org/notes.org"))
;;
;; ;; Better bullets; having an actual circular bullet, is just nice:
;; (font-lock-add-keywords 'org-mode)
;;                            '(("^ +\\([-*]\\) "
;;                               (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•")))))

;; (font-lock-add-keywords
;;  'org-mode
;;  '(("^[[:space:]]*\\(-\\) "
;;     0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "—")))))

;; Org-wiki simple
(require 'plain-org-wiki)
(setq plain-org-wiki-directory "~/org/wiki")
;;
;;
(setq org-agenda-include-diary t)
;;
;;
(setq org-agenda-timegrid-use-ampm 1)
;;
;;
(setq org-completion-use-vertico t)

;; Improve org mode looks
(setq org-startup-indented t
      org-pretty-entities t
      org-hide-emphasis-markers t
      org-startup-with-inline-images t
      org-image-actual-width '(300))
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
;; Whitespace -- is to color change text that goes beyond limit ;;;;;;;;;;;;;;;;
;; =============================================================================
;;
;; `lines-tail`, highlight the part that goes beyond the
;; limit of `whitespace-line-column`
(require 'whitespace)
(setq whitespace-line-column 68)
(setq whitespace-style '(face lines-tail trailing))
(global-whitespace-mode 1)
;; (add-hook 'org-mode-hook 'whitespace-mode)

;;
;; Keychords ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; =============================================================================
(require 'key-chord)
(key-chord-mode 1)
;;
;; Exit insert mode by pressing j and then j quickly
;; Max time delay between two key presses to be considered a key chord
(setq key-chord-two-keys-delay 0.5) ; default 0.1
;; Max time delay between two presses of the same key to be considered a key chord.
;; Should normally be a little longer than;key-chord-two-keys-delay.
(setq key-chord-one-key-delay 0.6) ; default 0.2
(key-chord-define evil-insert-state-map "jj" 'evil-normal-state)
(key-chord-mode 1)


;; Neotree ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ============================================================================
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)
(setq neo-smart-open t)

;; elfeed ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; =============================================================================
;; (require 'elfeed-goodies)
;; (elfeed-goodies/setup)

;; whichkey ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;==============================================================================
(which-key-setup-minibuffer)
;;
;; completion engine ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; =============================================================================
;;;; Auto completion
(use-package company
  :config
  (setq company-idle-delay 0
        company-minimum-prefix-length 3
        company-selection-wrap-around t))
(global-company-mode)
;;
;; this is a vertico as reveiwed by https://systemcrafters.cc/emacs-tips/streamline-completions-with-vertico/
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package vertico
  :init
  (vertico-mode))
(use-package orderless
  :init
;; (setq completion-styles '(basic substring partial-completion flex)
;; (setq completion-styles '(substring orderless)
  (setq completion-styles '(orderless)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))
;; this is to add the vim keybindings
(use-package vertico
  :bind (:map vertico-map
         ("C-j" . vertico-next)
         ("C-k" . vertico-previous)
         ("C-f" . vertico-exit)
         :map minibuffer-local-map
         ("M-h" . backward-kill-word))
  :custom
  (vertico-cycle t)
  :init
  (vertico-mode))
(use-package savehist
  :init
  (savehist-mode))
(use-package marginalia
  :after vertico
  :custom
  (marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light nil))
  :init
  (marginalia-mode))

;; Embark;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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
;;   "An embark indicator that displays keymaps using which-key.
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



;; this is verticos start config;;;;;;;;;;;
;;

;; Enable vertico
;; (use-package vertico
;;   :init
;;   (vertico-mode)

  ;; ;; Grow and shrink the Vertico minibuffer
  ;; (setq vertico-resize t)
  ;;

  ;; ;; Optionally enable cycling for `vertico-next' and `vertico-previous'.
  ;; (setq vertico-cycle t)
;;  )

;; ;; Optionally use the `orderless' completion style. See
;; ;; `+orderless-dispatch' in the Consult wiki for an advanced Orderless style
;; ;; dispatcher. Additionally enable `partial-completion' for file path
;; ;; expansion. `partial-completion' is important for wildcard support.
;; ;; Multiple files can be opened at once with `find-file' if you enter a
;; ;; wildcard. You may also give the `initials' completion style a try.

;; (use-package orderless
;;   :init
  ;; (setq completion-styles '(basic substring partial-completion flex)
  ;; (setq completion-styles '(basic substring partial-completion orderless)
  ;; (setq completion-styles '(substring orderless)
  ;; (setq completion-styles '(substring orderless)
  ;; (setq completion-styles '(orderless)
  ;;       completion-category-defaults nil
  ;;       completion-category-overrides '((file (styles partial-completion)))))

;; ;; Persist history over Emacs restarts. Vertico sorts by history position.
;; (use-package savehist
;;   :init
;;   (savehist-mode))

;; ;; A few more useful configurations...
;; (use-package emacs
;;   :init
  ;; ;; Add prompt indicator to `completing-read-multiple'.
  ;; ;; Alternatively try `consult-completing-read-multiple'.
  ;; (defun crm-indicator (args)
  ;;   (cons (concat "[CRM] " (car args)) (cdr args)))
  ;; (advice-add #'completing-read-multiple :filter-args #'crm-indicator)


  ;; Enable recursive minibuffers
(setq enable-recursive-minibuffers t)

(setq read-file-name-completion-ignore-case t
      read-buffer-completion-ignore-case t
      completion-ignore-case t)


;; this should replicate scrolloff in vim;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq scroll-conservatively 111
      scroll-margin 9
      scroll-preserve-screen-position 't)

;; move or transpose lines up/down;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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


;; save last & open last place edited;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(save-place-mode 1)
(setq save-place-forget-unreadable-files nil)
(setq save-place-file "~/.emacs.d/saveplace")


;; save updated bookmarks;;;;;;;;;;;;;;
(setq bookmark-save-flag 1)

;;this was suppose to open multi files;;??;;;;;;;
(defun dired-find-marked-files ()
 (interactive)
 (dolist (f (dired-get-marked-files))
  (find-file f)))
;;no fringe;;;
(set-fringe-mode 0)
