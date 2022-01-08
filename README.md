# doom
my doom-Emacs configs


**<h2 align="left">MY DEADLY DOOM CONFIG</h2>**                  
![DOOM](/splash/doom-emacs-slant-out-color.png)

**<h3 align="left">description</h3>**
_______________________________
#### More than just dotconfigs
<img src="/splash/screenshot2.png" width="" height="">


# Table of Contents

1.  [;;;; the lexical-binding ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;](#orgbfef3b6)
2.  [;;;; name ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;](#orgbf22e90)
3.  [;;;; package manament ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;](#orgd89497c)
4.  [;;;; FONTS ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;](#orgb7633ec)
5.  [;;;; theme ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;](#orga92fc3a)
6.  [;;;; Line settings ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;](#orge69fa33)
7.  [;;;; Maximize the window upon startup ;;;;;;;;;;;;;;;;;;;;;;;;;;;;](#org2063805)
8.  [;;;; set fancy splash-image ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;](#orgcc02b63)
9.  [;;;; Dashboard ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;](#org86bfd0f)
10. [;;;; org-settings ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;](#org1792694)
11. [;;;; Markdown ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;](#org870ac27)
12. [;;;; Keychords ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;](#org0bc4421)
13. [;;;; Neotree ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;](#org6c630a9)
14. [;;;; Auto completion ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;](#orgd51d9f2)
15. [;;;; company ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;](#org9a31523)
16. [;;;; marginalia ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;](#orgaf900e3)
17. [;;;; VERTICO ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;](#org3782f53)
18. [;;;; corfu ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;](#orgd4f9f22)
19. [;;;; Embark ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;](#orgab10552)
20. [;;;; CONSULT ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;](#orgf4d14e9)
21. [;;;; ignore-case ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;](#orga736f82)
22. [;;;; elfeed ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;](#orgc60d722)
23. [;;;; scroll margin ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;](#orga2b1e7b)
24. [;;;; Whitespace ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;](#org896e89f)
25. [;;;; move or transpose lines up/down ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;](#org5202473)
26. [;;;; save last place edited update bookmarks ;;;;;;;;;;;;;;;;;;;;;](#org3e5708c)
27. [;;;; spray ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;](#org341351e)
28. [;;;; pdf-tools ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;](#org00a57e0)
29. [;;;; personel random settings ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;](#orgb0aea56)
30. [;;;; avy ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;](#orgb9c0b5c)
31. [;;;; transparency ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;](#orgd2c20d1)

`================================================================================`
#
#"stole all"
#
#
# "regret none"
# *A DASTARDLY DVS DOOM CONFIG*

`================================================================================`


<a id="orgbfef3b6"></a>

# ;;;; the lexical-binding ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; `=============================================================================`

    ;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-


<a id="orgbf22e90"></a>

# ;;;; name ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; `=============================================================================`

    ;; Some functionality uses this to identify you
    (setq user-full-name "dvsdude"
          user-mail-address "john@doe.com")


<a id="orgd89497c"></a>

# ;;;; package manament ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; `=============================================================================`

    ;;; package manament ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
    (straight-use-package 'use-package)
    
    ;; This is only needed once, near the top of the file
    (eval-when-compile
      (require 'use-package))


<a id="orgb7633ec"></a>

# ;;;; FONTS ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; `=============================================================================`

    ;;; FONTS ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
    ;;; My font settings ;;;;;;;;;;;;;;;;;;;;;
    
    (require 'mixed-pitch)
    (mixed-pitch-mode)
    (add-hook 'text-mode-hook #'mixed-pitch-mode)
    (variable-pitch-mode t)
    
    
    (setq doom-font (font-spec :family "Hack Nerd Font" :size 17 :weight 'bold)
         doom-variable-pitch-font (font-spec :family "DroidSansMono Nerd Font" :size 18 :weight 'regular)
         doom-big-font (font-spec :family "Hack Nerd Font" :size 24))

;; DTs font config;;;;;;;;;;;;;;;;;;;;;;;

;; (setq doom-font (font-spec :family &ldquo;Source Code Pro&rdquo; :size 15)
;;       doom-variable-pitch-font (font-spec :family &ldquo;Ubuntu&rdquo; :size 15)
;;       doom-big-font (font-spec :family &ldquo;Source Code Pro&rdquo; :size 24))

;; motis theme creator config ;;;;;;;;;;
;; Using ~set-face-attribute
;;For me a monospaced font should be the standard, so in practice I
;; configure `default` and `fixed-pitch` to use the same typeface.

;; (set-face-attribute &rsquo;default nil :font &ldquo;Hack-16&rdquo;)
;; (set-face-attribute &rsquo;fixed-pitch nil :font &ldquo;Hack-16&rdquo;)
;; (set-face-attribute &rsquo;variable-pitch nil :font &ldquo;FiraGO-18&rdquo;)

;; dieago zamboni&rsquo;s font favs ;;;;;;;;;;
;; (setq doom-font (font-spec :family &ldquo;Fira Code Retina&rdquo; :size 18)
;;       doom-variable-pitch-font (font-spec :family &ldquo;ETBembo&rdquo; :size 18))


<a id="orga92fc3a"></a>

# ;;;; theme ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; `============================================================================`

    ;;; theme ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
    ;; (setq doom-theme 'doom-one)
    (setq doom-theme 'doom-Iosvkem)


<a id="orge69fa33"></a>

# ;;;; Line settings ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; `============================================================================`

    ;;; Line settings ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
    (setq display-line-numbers-type `relative)
    
    ;; Sensible line breaking
    ;; (add-hook 'text-mode-hook 'visual-line-mode)
    (global-visual-line-mode 1)
    
    ;;no fringe;;;
    (set-fringe-mode 0)


<a id="org2063805"></a>

# ;;;; Maximize the window upon startup ;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; `============================================================================`

    ;; Maximize the window upon startup
    (add-to-list 'initial-frame-alist '(fullscreen . maximized))


<a id="orgcc02b63"></a>

# ;;;; set fancy splash-image ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; `=============================================================================`

    ;; set fancy splash-image
    (setq fancy-splash-image "~/.doom.d/splash/doom-color.png")


<a id="org86bfd0f"></a>

# ;;;; Dashboard ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; `=============================================================================`

    ;;; Dashboard ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
    (use-package dashboard
      :demand
      :if (< (length command-line-args) 2)
      :bind (:map dashboard-mode-map
                  ("U" . auto-package-update-now)
                  ("R" . restart-emacs)
                  ("K" . kill-emacs))
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
                 (all-the-icons-faicon "gitlab" :height 0.8 :face 'all-the-icons-orange))
           "Homepage"
           "Browse Homepage"
           (lambda (&rest _) (browse-url Homepage)))
          (,(and (display-graphic-p)
                 (all-the-icons-material "update" :height 0.7 :face 'all-the-icons-green))
           "Update"
           "Update emacs"
           (lambda (&rest _) (auto-package-update-now)))
          (,(and (display-graphic-p)
                 (all-the-icons-material "autorenew" :height 0.7 :face 'all-the-icons-yellow))
           "Restart"
           "Restar emacs"
           (lambda (&rest _) (restart-emacs))))))
      :config
    
    (setq dashboard-items '((recents  . 7)
                            (bookmarks . 7)
                            (agenda . 5)))
      (dashboard-setup-startup-hook))
      ;; (dashboard-modify-heading-icons '((recents . "file-text")
      ;;                                    (bookmarks . "book")))
    ;; (setq doom-fallback-buffer-name "*dashboard*")
      ;; (provide 'init-dashboard)
    ;; (setq initial-buffer-choice (lambda()(get-buffer "*dashboard*"))) ;; this is for use with emacsclient

;; If you use \`org&rsquo; and don&rsquo;t want your org files in the default location ,
;; change \`org-directory&rsquo;. It must be set before org loads!

    (setq org-directory "~/org/")


<a id="org1792694"></a>

# ;;;; org-settings ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; `============================================================================`

    ;;; org-settings ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
    ;; jump to org folder;;;;;;;;;;;;;;;;;;;
    (global-set-key (kbd "C-c o")
                    (lambda () (interactive) (find-file "~/org/")))
    
    ;; default file for notes ;;;;;;;;;;;;;;
    (setq org-default-notes-file (concat org-directory "~/org/notes.org"))
    
    
    ;; (font-lock-add-keywords
    ;;  'org-mode
    ;;  '(("^[[:space:]]*\\(-\\) "
    ;;    ; 0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "—")))))
    
    ;; Org-wiki simple
    (require 'plain-org-wiki)
    (setq plain-org-wiki-directory "~/org/wiki")
    
    
    ;; jump to org wiki folder;;
    
    ;; (global-set-key (kbd "C-c k")
    ;;                 (lambda () (interactive) (find-file "~/org/wiki")))
    
    (map! :leader
         (:prefix ("o". "open")
          :desc "open org wiki" "k" #'find-file "~/org/wiki/"))
    
    (setq org-agenda-include-diary t)
    (setq org-agenda-timegrid-use-ampm 1)
    
    ;; org auto-complete ;;
    (require 'org-ac)
    
    ;; Make config suit for you. About the config item, eval the following sexp.
    ;; (customize-group "org-ac")
    
    (org-ac/config-default)
    ;; Improve org mode looks ;;;;;;;;;;;;;;;;;;;;;;;;
    
    (setq org-startup-indented t
          org-pretty-entities t
          org-hide-emphasis-markers t
          org-startup-with-inline-images t)
    
    ;; change header * for symbols ;;
    (require 'org-superstar)
    (add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))
    (setq inhibit-compacting-font-caches t)
    
    ;; set font size for headers ;;
    (custom-set-faces
      '(org-level-1 ((t (:inherit outline-1 :height 1.2))))
      '(org-level-2 ((t (:inherit outline-2 :height 1.0))))
      '(org-level-3 ((t (:inherit outline-3 :height 1.0))))
      '(org-level-4 ((t (:inherit outline-4 :height 1.0))))
      '(org-level-5 ((t (:inherit outline-5 :height 1.0))))
    )
    
    ;; set how emphasis look ;;
    (setq org-emphasis-alist
          '(("*" bold)
            ("/" italic)
            ("_" underline)
            ("=" org-verbatim verbatim)
            ("~" org-code verbatim)
            ("+" (:strike-through t))))
    
    (defface my-org-emphasis-bold
      '((default :inherit bold)
        (((class color) (min-colors 88) (background dark))
         :foreground "#ff8059"))
      "My bold emphasis for Org.")
    
    (defface my-org-emphasis-italic
      '((default :inherit italic)
        (((class color) (min-colors 88) (background dark))
         :foreground "#44bc44"))
      "My italic emphasis for Org.")
    
    (defface my-org-emphasis-underline
      '((default :inherit underline)
        (((class color) (min-colors 88) (background dark))
         :foreground "#d0bc00"))
      "My underline emphasis for Org.")
    
    (defface my-org-emphasis-strike-through
        '((((class color) (min-colors 88) (background dark))
         :strike-through "#ef8b50" :foreground "#a8a8a8"))
      "My strike-through emphasis for Org.")


<a id="org870ac27"></a>

# ;;;; Markdown ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; `============================================================================`

;; use C-c / for menu

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


<a id="org0bc4421"></a>

# ;;;; Keychords ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; `============================================================================`

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


<a id="org6c630a9"></a>

# ;;;; Neotree ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; `============================================================================`

    ;;; Neotree ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
    (require 'neotree)
    (global-set-key [f8] 'neotree-toggle)
    (setq neo-smart-open t)


<a id="orgd51d9f2"></a>

# ;;;; Auto completion ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; `============================================================================`

    ;;; Auto completion ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
    ;; Completion words longer than 4 characters
    ;;    (custom-set-variables
    ;;      '(ac-ispell-requires 4)
    ;;      '(ac-ispell-fuzzy-limit 4))
    
    ;; (eval-after-load "auto-complete"
    ;;   '(progn
    ;;       (ac-ispell-setup)))
    
    ;; (add-hook 'git-commit-mode-hook 'ac-ispell-ac-setup)
    ;; (add-hook 'mail-mode-hook 'ac-ispell-ac-setup)
    
    
    ;; (require 'orderless)
    ;; (setq completion-styles '(orderless))


<a id="org9a31523"></a>

# ;;;; company ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; `============================================================================`

    ;;; company ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
    ;; (use-package company
    ;;   :config
    ;;   (setq company-idle-delay 0
    ;;         company-minimum-prefix-length 3
    ;;         company-selection-wrap-around t))
    ;; (global-company-mode)


<a id="orgaf900e3"></a>

# ;;;; marginalia ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; `============================================================================`

    ;;; marginalia ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
    ;; (use-package marginalia
    ;;   ;; The :init configuration is always executed (Not lazy!)
    ;;   :init
    ;;   ;; Must be in the :init section of use-package such that the mode gets
    ;;   ;; enabled right away. Note that this forces loading the package.
    ;;   (marginalia-mode))


<a id="org3782f53"></a>

# ;;;; VERTICO ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; `============================================================================`

    ;;; VERTICO ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
    (use-package vertico
      :init
      (vertico-mode)
      (setq vertico-cycle t))
    ;; (use-package orderless
    ;;   :init
      ;; (setq completion-styles '(basic substring partial-completion flex))
      ;; (setq completion-styles '(substring orderless))
      ;; (setq completion-styles '(orderless)
      ;;       completion-category-defaults nil
      ;;       completion-category-overrides '((file (styles partial-completion)))))
    ;; Persist history over Emacs restarts. Vertico sorts by history position.
    (use-package savehist
      :init
      (savehist-mode 1))
    ;; (use-package emacs
    ;;   :init
      ;; Alternatively try `consult-completing-read-multiple'.
      ;; (defun crm-indicator (args)
      ;;   (cons (concat "[CRM] " (car args)) (cdr args)))
      ;; (advice-add #'completing-read-multiple :filter-args #'crm-indicator)
    
    ;; Do not allow the cursor in the minibuffer prompt
    ;; (setq minibuffer-prompt-properties
    ;;       '(read-only t cursor-intangible t face minibuffer-prompt))
    ;; (add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)
    
      ;; Enable recursive minibuffers
      ;; (setq enable-recursive-minibuffers t))
    ;; Use `consult-completion-in-region' if Vertico is enabled.
    ;; Otherwise use the default `completion--in-region' function.
    ;; (setq completion-in-region-function
    ;;       (lambda (&rest args)
    ;;         (apply (if vertico-mode
    ;;                    #'consult-completion-in-region
    ;;                  #'completion--in-region)
    ;;                args)))
    ;; (advice-add #'completing-read-multiple
    ;;             :override #'consult-completing-read-multiple)
    (setq org-refile-use-outline-path 'file
          org-outline-path-complete-in-steps nil)
    (advice-add #'tmm-add-prompt :after #'minibuffer-hide-completions)
    (use-package marginalia
      :after vertico
      :custom
      (marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light nil))
      :init
      (marginalia-mode))


<a id="orgd4f9f22"></a>

# ;;;; corfu ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; `============================================================================`

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


<a id="orgab10552"></a>

# ;;;; Embark ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; `============================================================================`

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


<a id="orgf4d14e9"></a>

# ;;;; CONSULT ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; `============================================================================`

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


<a id="orga736f82"></a>

# ;;;; ignore-case ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; `============================================================================`

    ;;; ignore-case ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
    (setq read-file-name-completion-ignore-case t
          read-buffer-completion-ignore-case t
          completion-ignore-case t)


<a id="orgc60d722"></a>

# ;;;; elfeed ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; `============================================================================`

    ;;; elfeed ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
    ;; (require 'elfeed-goodies)
    ;; (elfeed-goodies/setup)


<a id="orga2b1e7b"></a>

# ;;;; scroll margin ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; `============================================================================`

    ;;; scroll margin ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
    ;; this should replicate scrolloff in vim
    (setq scroll-conservatively 111
          scroll-margin 20
          scroll-preserve-screen-position 't)


<a id="org896e89f"></a>

# ;;;; Whitespace ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; `============================================================================`

;; this is to color change text that goes beyond a set limit

    ;;; Whitespace ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
    (require 'whitespace)
    (setq whitespace-line-column 68)
    (setq whitespace-style '(face lines-tail trailing))
    (setq global-whitespace-mode nil)
    
    (autoload 'whitespace-mode           "whitespace" "Toggle whitespace visualization"        t)
    ;; (autoload 'whitespace-toggle-options "whitespace" "Toggle local `whitespace-mode' options" t)
    
    
    (map! :leader
         (:prefix ("l". "line")
          :desc "whitespace toggle" "t" #'whitespace-mode))
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; ;; lines-tail, highlight the part that goes beyond the
    ;; ;; limit of whitespace-line-column
    ;; (require 'whitespace)
    ;; (setq whitespace-line-column 68)
    ;; (setq whitespace-style '(face lines-tail))
    ;; ;; (after! org)
    ;; ;; (add-hook 'org-mode-hook (lambda () (whitespace-mode 1)))
    ;; ;; toggle whitespace ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; (global-set-key (kbd "C-c w") 'whitespace-mode)
    ;; (autoload 'whitespace-mode           "whitespace" "Toggle whitespace visualization."        t)
    ;; (autoload 'whitespace-toggle-options "whitespace" "Toggle local `whitespace-mode' options." t)


<a id="org5202473"></a>

# ;;;; move or transpose lines up/down ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; `============================================================================`

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


<a id="org3e5708c"></a>

# ;;;; save last place edited update bookmarks ;;;;;;;;;;;;;;;;;;;;;

;; `============================================================================`

    ;;; save last place edited & update bookmarks ;;;;
    
    (save-place-mode 1)
    (setq save-place-forget-unreadable-files nil)
    (setq save-place-file "~/.emacs.d/saveplace")
    (setq bookmark-save-flag 1)


<a id="org341351e"></a>

# ;;;; spray ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; `============================================================================`

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


<a id="org00a57e0"></a>

# ;;;; pdf-tools ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; `=============================================================================`

    ;;; pdf-tools ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
    ;; (pdf-tools-install)
    (pdf-loader-install) ;; this helps load time
    
    (use-package pdf-view
      :hook (pdf-tools-enabled . pdf-view-midnight-minor-mode)
      :hook (pdf-tools-enabled . hide-mode-line-mode)
      :config
      (setq pdf-view-midnight-colors '("#ABB2BF" . "#282C35")))


<a id="orgb0aea56"></a>

# ;;;; personel random settings ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; `=============================================================================`

    (require 'evil-snipe)
    (evil-snipe-mode +1)
    
    (require 'all-the-icons)
    
    (map! :leader
        (:prefix ("e". "end")
         :desc "end of line" "l" #'end-of-line))
    
    (require 'page-break-lines)
    (page-break-lines-mode)

    ;; whichkey ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
    (which-key-setup-minibuffer)
    ;; (which-key-setup-side-window-bottom)
    ;;(which-key-setup-side-window-right)
    ;;(which-key-setup-side-window-right-bottom)


<a id="orgb9c0b5c"></a>

# ;;;; avy ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; `===========================================================================`

    (map! :leader
         (:prefix ("v". "avy")
          :desc "avy goto char timer" "g" #'evil-avy-goto-char-timer))
    
    (setq avy-timeout-seconds 0.8) ;;default 0.5
    (setq avy-single-candidate-jump t)


<a id="orgd2c20d1"></a>

# ;;;; transparency ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; `============================================================================`

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

;; auto package update ;;

    (use-package cl-lib)
    (require 'misc)
    
    (use-package auto-package-update
      :custom
      (auto-package-update-last-update-day-path (concat cache-dir ".last-package-update-day"))
      (auto-package-update-delete-old-versions t))

