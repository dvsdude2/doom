;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Some functionality uses this to identify you
(setq user-full-name "dvsdude"
      user-mail-address "john@doe.com")

;;; package manament ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; this should speed up load time ;;
;; (setq straight-check-for-modifications '(check-on-save find-when-checking))
(straight-use-package 'use-package)

;; This is only needed once, near the top of the file
(eval-when-compile
  (require 'use-package))

;;; FONTS ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; My font settings ;;;;;;;;;;;;;;;;;;;;;

(require 'mixed-pitch)
(mixed-pitch-mode)
;; (add-hook 'text-mode-hook #'mixed-pitch-mode)
(variable-pitch-mode t)


(setq doom-font (font-spec :family "Hack Nerd Font" :size 17 :weight 'bold)
     doom-variable-pitch-font (font-spec :family "Source Code Pro" :size 17)
     doom-big-font (font-spec :family "Hack Nerd Font" :size 24))

;;; theme ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (setq doom-theme 'doom-one)
(setq doom-theme 'doom-Iosvkem)

;;; Line settings ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq display-line-numbers-type `relative)

;; Sensible line breaking
;; (add-hook 'text-mode-hook 'visual-line-mode)
(global-visual-line-mode 1)

;;no fringe;;;
(set-fringe-mode 0)

;; Maximize the window upon startup
(add-to-list 'initial-frame-alist '(fullscreen . maximized))

;; load icons ;;
;; (when (display-graphic-p)
;;   (require 'all-the-icons))
;; set fancy splash-image
(setq fancy-splash-image "~/.doom.d/splash/doom-color.png")

;;; Dashboard ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(use-package! dashboard
  :demand
  ;; :if (< (length command-line-args) 2)
  ;; :bind (:map dashboard-mode-map
  ;;             ("U" . auto-package-update-now)
  ;;             ("R" . restart-emacs)
  ;;             ("ZZ" . save-buffers-kill-emacs))
  :custom
  (dashboard-startup-banner (concat  "~/.doom.d/splash/doom-color.png"))
  (dashboard-banner-logo-title "Wecome to Dvsdude's E to the mother f*ck*n MACS")
  (dashboard-set-heading-icons t)
  (dashboard-set-file-icons t)
  (dashboard-set-init-info t)
  (dashboard-set-navigator t)
  (dashboard-center-content t)
  (dashboard-navigator-buttons
   `(
     ((,(and (display-graphic-p)
             (all-the-icons-faicon "gitlab" :height 1.0 :face 'font-lock-keyword-face))
       "Homepage"
       "Browse Homepage"
       (lambda (&rest _) (browse-url"https://search.brave.com/")))
      (,(and (display-graphic-p)
             (all-the-icons-material "update" :height 1.0 :face 'font-lock-keyword-face))
       "Update"
       "Update emacs"
       (lambda (&rest _) (auto-package-update-now)))
      (,(and (display-graphic-p)
             (all-the-icons-material "autorenew" :height 1.0 :face 'font-lock-keyword-face))
       "Restart"
       "Restar emacs"
       (lambda (&rest _) (restart-emacs))))))
  :config
(setq dashboard-items '((recents  . 8)
                        (bookmarks . 8)))
  (dashboard-setup-startup-hook))
;; (setq initial-buffer-choice (lambda()(get-buffer "*dashboard*"))) ;; this is for use with emacsclient

(setq org-directory "~/org/")

;;; org-settings ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; default file for notes ;;;;;;;;;;;;;;
(setq org-default-notes-file (concat org-directory "notes.org"))

;; jump to config.org ;;
(map! :leader
      (:prefix ("o" . "open file")
       :desc "open org config" "p" (lambda () (interactive) (find-file "~/.doom.d/config.org"))))

;; jump to notes.org ;;
(map! :leader
      (:prefix ("o" . "open file")
       :desc "open org notes" "n" (lambda () (interactive) (find-file "~/org/notes.org"))))

;; jump to org folder ;;
(map! :leader
      (:prefix ("o" . "open file")
       :desc "open org config" "o" (lambda () (interactive) (find-file "~/org/"))))

;; jump to org wiki folder;;
(map! :leader
      (:prefix ("o" . "open file")
       :desc "open org wiki" "k" (lambda () (interactive) (find-file "~/org/wiki/"))))


(setq org-agenda-include-diary t)
(setq org-agenda-timegrid-use-ampm 1)

(setq org-refile-targets '((nil :maxlevel . 2)
                                (org-agenda-files :maxlevel . 2)))
(setq org-outline-path-complete-in-steps nil)         ;; Refile in a single go
(setq org-refile-use-outline-path 'file)              ;; this also set by vertico
;; Improve org mode looks ;;;;;;;;;;;;;;;;;;;;;;;;

(setq org-startup-indented t
      org-pretty-entities t
      org-hide-emphasis-markers t
      org-startup-with-inline-images t
      org-image-actual-width '(300))

;; change header * for symbols ;;
(require 'org-superstar)
(after! 'org
(add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))
;; add org-appear-mode
(add-hook 'org-mode-hook 'org-appear-mode))

;; use dash instead of hyphin ;;
(after! 'org-superstar
(font-lock-add-keywords
 'org-mode
 '(("^[[:space:]]*\\(-\\) "
    0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "—"))))))

;; set font size for headers ;;
(custom-set-faces
  '(org-level-1 ((t (:inherit outline-1 :height 1.2))))
  '(org-level-2 ((t (:inherit outline-2 :height 1.0))))
  '(org-level-3 ((t (:inherit outline-3 :height 1.0))))
  '(org-level-4 ((t (:inherit outline-4 :height 1.0))))
  '(org-level-5 ((t (:inherit outline-5 :height 1.0))))
)

(defface my-org-emphasis-bold
  '((default :inherit bold)
    (((class color) (min-colors 88) (background light))
     :foreground "#a60000")
    (((class color) (min-colors 88) (background dark))
     :foreground "#ff8059"))
  "My bold emphasis for Org.")

(defface my-org-emphasis-italic
  '((default :inherit italic)
    (((class color) (min-colors 88) (background light))
     :foreground "#005e00")
    (((class color) (min-colors 88) (background dark))
     :foreground "#44bc44"))
  "My italic emphasis for Org.")

(defface my-org-emphasis-underline
  '((default :inherit underline)
    (((class color) (min-colors 88) (background light))
     :foreground "#813e00")
    (((class color) (min-colors 88) (background dark))
     :foreground "#d0bc00"))
  "My underline emphasis for Org.")

(defface my-org-emphasis-strike-through
  '((((class color) (min-colors 88) (background light))
     :strike-through "#972500" :foreground "#505050")
    (((class color) (min-colors 88) (background dark))
     :strike-through "#ef8b50" :foreground "#a8a8a8"))
  "My strike-through emphasis for Org.")

;;; evil surround ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'evil-surround)
(after! 'org
(add-hook 'org-mode-hook (lambda ()
                            (push '(?= . ("=" . "=")) evil-surround-pairs-alist)))
(add-hook 'org-mode-hook (lambda ()
                            (push '(?` . ("`" . "`")) evil-surround-pairs-alist))))

;;; Markdown ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package markdown-mode
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "pandoc"))

(add-hook 'markdown-mode-hook 'pandoc-mode)

;; default markdown-mode's markdown-live-preview-mode to vertical split
(setq markdown-split-window-direction 'right)

;;; Keychords ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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

;;; Auto completion ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(map! :map ac-mode-map
      :leader
     (:prefix ("t". "toggle")
      :desc "auto complete" "a" #'auto-complete))
(ac-config-default)
;; Completion words longer than 3 characters
;;    (custom-set-variables
;;      '(ac-ispell-requires 3)
;;      '(ac-ispell-fuzzy-limit 3))

;; (eval-after-load "auto-complete"
;;   '(progn
;;       (ac-ispell-setup)))

;; (add-hook 'git-commit-mode-hook 'ac-ispell-ac-setup)
;; (add-hook 'org-mode-hook 'ac-ispell-ac-setup)


;; (require 'orderless)
;; (setq completion-styles '(orderless))

;;; VERTICO ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package vertico
  :init
  (vertico-mode)
  (setq vertico-cycle t))
(use-package orderless
   :init
  ;; (setq completion-styles '(basic substring partial-completion flex))
  ;; (setq completion-styles '(substring orderless)
  (setq completion-styles '(orderless)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))
;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package savehist
  :init
  (savehist-mode 1))
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
;; (setq completion-in-region-function
;;       (lambda (&rest args)
;;         (apply (if vertico-mode
;;                    #'consult-completion-in-region
;;                  #'completion--in-region)
;;                args)))
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

;;; corfu ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package corfu
  ;; Optional customizations
  :custom
  (corfu-cycle t)                ;; Enable cycling for `corfu-next/previous'
  (corfu-auto t)                 ;; Enable auto completion
  ;; (corfu-commit-predicate nil)   ;; Do not commit selected candidates on next input
  ;; (corfu-quit-at-boundary t)     ;; Automatically quit at word boundary
  ;; (corfu-quit-no-match t)        ;; Automatically quit if there is no match
  ;; (corfu-preview-current nil)    ;; Disable current candidate preview
  (corfu-preselect-first nil)    ;; Disable candidate preselection
  (corfu-echo-documentation nil) ;; Disable documentation in the echo area
  (corfu-scroll-margin 5)        ;; Use scroll margin
  ;; Use TAB for cycling, default is `corfu-complete'.
  :bind
  (:map corfu-map
        ("TAB" . corfu-next)
        ([tab] . corfu-next)
        ("S-TAB" . corfu-previous)
        ([backtab] . corfu-previous))

;; You may want to enable Corfu only for certain modes.
;; :hook ((prog-mode . corfu-mode)
;;        (shell-mode . corfu-mode)
;;        (org-mode . corfu-mode)
;;        (text-mode . corfu-mode)
;;        (eshell-mode . corfu-mode))

;; Recommended: Enable Corfu globally.
;; This is recommended since dabbrev can be used globally (M-/).
:init
(corfu-global-mode))
(use-package orderless
  :init
  ;; (setq completion-styles '(basic substring partial-completion flex))
  ;; (setq completion-styles '(substring orderless)
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

;;; Embark;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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

;;; CONSULT ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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
         ("M-y" . consult-yank-pop)                ;; orig. yank-pop
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

;;; marginalia ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package marginalia
;;   ;; The :init configuration is always executed (Not lazy!)
  :init
;;   ;; Must be in the :init section of use-package such that the mode gets
;;   ;; enabled right away. Note that this forces loading the package.
  (marginalia-mode))

;;; ignore-case ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq read-file-name-completion-ignore-case t
      read-buffer-completion-ignore-case t
      completion-ignore-case t)

;;; elfeed ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (require 'elfeed-goodies)
;; (elfeed-goodies/setup)

;;; scroll margin ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; this should replicate scrolloff in vim ;;

(setq scroll-conservatively 222
      maximum-scroll-margin 0.50
      scroll-margin 11
      scroll-preserve-screen-position 't)

;;; Whitespace ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'whitespace)
(after! org
(setq whitespace-line-column 68)
(setq whitespace-style '(face lines-tail)))
(setq global-whitespace-mode t)


(map! :leader
     (:prefix ("t". "line")
      :desc "whitespace toggle" "W" #'whitespace-mode))

;;;###autoload
(autoload 'whitespace-mode           "whitespace" "Toggle whitespace visualization"        t)

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

;;; save last place edited & update bookmarks ;;;;

(save-place-mode 1)
(setq save-place-forget-unreadable-files nil)
(setq save-place-file "~/.emacs.d/saveplace")
(setq bookmark-save-flag t)

;;; spray ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'spray)
(global-set-key (kbd "<f6>") 'spray-mode)
(use-package! spray
  :commands spray-mode
  :config
  (setq spray-wpm 200
        spray-height 800)
  (defun spray-mode-hide-cursor ()
    "Hide or unhide the cursor as is appropriate."
    (if spray-mode
        (setq-local spray--last-evil-cursor-state evil-normal-state-cursor
                    evil-normal-state-cursor '(nil))
      (setq-local evil-normal-state-cursor spray--last-evil-cursor-state)))
  (add-hook 'spray-mode-hook #'spray-mode-hide-cursor)
  (map! :map spray-mode-map
        "<return>" #'spray-start/stop
        "f" #'spray-faster
        "s" #'spray-slower
        "t" #'spray-time
        "<right>" #'spray-forward-word
        "h" #'spray-forward-word
        "<left>" #'spray-backward-word
        "l" #'spray-backward-word
        "q" #'spray-quit))

;;; pdf-tools ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (pdf-tools-install)
(pdf-loader-install) ;; this helps load time
(use-package pdf-view
  :hook (pdf-tools-enabled . pdf-view-midnight-minor-mode)
  :hook (pdf-tools-enabled . hide-mode-line-mode)
  :config
  (setq pdf-view-midnight-colors '("#ABB2BF" . "#282C35")))

;; (setq-default pdf-view-display-size 'fit-page)
(require 'saveplace-pdf-view)
(save-place-mode 1)

;; should put  focus in the new window
(setq evil-split-window-below t
      evil-vsplit-window-right t)

(map! :leader
    (:prefix ("i". "insert")
     :desc "insert buffer at point" "b" #'insert-buffer))

;; number of lines of overlap in page flip
(setq next-screen-context-lines 5)

(require 'org-tempo)
(add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))

;;; evil snipe ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'evil-snipe)
(evil-snipe-mode t)
(evil-snipe-override-mode 1)
(define-key evil-snipe-parent-transient-map (kbd "C-;")
  (evilem-create 'evil-snipe-repeat
                 :bind ((evil-snipe-scope 'line)
                        (evil-snipe-enable-highlight)
                        (evil-snipe-enable-incremental-highlight))))
(push '(?\[ "[[{(]") evil-snipe-aliases)
(add-hook 'magit-mode-hook 'turn-off-evil-snipe-override-mode)

;; whichkey ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(which-key-setup-minibuffer)
;; (which-key-setup-side-window-bottom)
;;(which-key-setup-side-window-right)
;;(which-key-setup-side-window-right-bottom)

(map! :leader
     (:prefix ("s". "search")
      :desc "avy goto char timer" "a" #'evil-avy-goto-char-timer))

(setq avy-timeout-seconds 1.0) ;;default 0.5
(setq avy-single-candidate-jump t)

;;; transparency ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun toggle-transparency ()
   (interactive)
   (let ((alpha (frame-parameter nil 'alpha)))
     (set-frame-parameter
      nil 'alpha
      (if (eql (cond ((numberp alpha) alpha)
                     ((numberp (cdr alpha)) (cdr alpha))
                     ;; Also handle undocumented (<active> <inactive>) form.
                     ((numberp (cadr alpha)) (cadr alpha)))
              100)
         '(85 . 55) '(100 . 100)))))
(map! :leader
     (:prefix ("t". "toggle")
      :desc "toggle transparency" "t" #'toggle-transparency))

(add-hook 'dired-mode-hook
          'display-line-numbers-mode)
(add-hook 'dired-mode-hook
          'dired-hide-details-mode)
;; (add-hook 'dired-mode-hook
;;           'treemacs-icons-dired-mode)
;; peep dired ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(map! :leader
     (:prefix ("t". "toggle")
      :desc "peep dired toggle" "p" #'peep-dired))
(setq peep-dired-cleanup-on-disable t)
(setq peep-dired-enable-on-directories t)
(evil-define-key 'normal peep-dired-mode-map (kbd "n") 'peep-dired-scroll-page-down
                                             (kbd "p") 'peep-dired-scroll-page-up
                                             (kbd "j") 'peep-dired-next-file
                                             (kbd "<down>") 'peep-dired-next-file
                                             (kbd "k") 'peep-dired-prev-file
                                             (kbd "<up>") 'peep-dired-prev-file)
(add-hook 'peep-dired-hook 'evil-normalize-keymaps)

;;; auto package update ;;;;;;;;;;;;;;;;;;;;;;;;
(require 'auto-package-update)
(auto-package-update-maybe)

;;;  "Syntax color for code colors 「#ff1100」
;; (require 'rainbow-mode)
;; (rainbow-mode t)
;; (add-hook 'prog-mode-hook #'rainbow-mode)

;; add org+mpv ;;;;
(org-link-set-parameters "mpv" :follow #'mpv-play)
(defun org-mpv-complete-link (&optional arg)
  (replace-regexp-in-string
   "file:" "mpv:"
   (org-link-complete-file arg)
   t t))
(add-hook 'org-open-at-point-functions #'mpv-seek-to-position-at-point)
