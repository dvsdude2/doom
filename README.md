# doom
my doom-Emacs configs


**<h2 align="left">MY DEADLY DOOM CONFIG</h2>**                  
![DOOM](/splash/doom-emacs-slant-out-color.png)

**<h3 align="left">description</h3>**
_______________________________
#### More than just dotconfigs
<img src="/splash/screenshot2.png" width="" height="">



# Table of Contents

1.  [;;;; the lexical-binding ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;](#org58c1313)
2.  [;;;; name ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;](#org4e97ce1)
3.  [;;;; package manament ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;](#orge446a2e)
4.  [;;;; FONTS ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;](#orgf5b184f)
5.  [;;;; theme ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;](#orgfa59dcd)
6.  [;;;; Line settings ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;](#orgf898aeb)
7.  [;;;; Maximize on startup ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;](#org2045c25)
8.  [;;;; load splash-image & icons ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;](#org2373aed)
9.  [;;;; Dashboard ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;](#org98abaf5)
10. [;;;; org-settings ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;](#orgd3bf802)
11. [;;;; Markdown ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;](#orga73503b)
12. [;;;; Keychords ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;](#org6bce5cf)
13. [;;;; Auto completion ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;](#orgb477780)
14. [;;;; company ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;](#org208dd2a)
15. [;;;; marginalia ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;](#orge48dfd9)
16. [;;;; VERTICO ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;](#org9237961)
17. [;;;; corfu ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;](#org543c6b8)
18. [;;;; Embark ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;](#org46d7239)
19. [;;;; CONSULT ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;](#org7232f7d)
20. [;;;; ignore-case ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;](#orgc26763f)
21. [;;;; elfeed ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;](#org90f32a6)
22. [;;;; scroll margin ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;](#orgd334017)
23. [;;;; Whitespace ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;](#org587920a)
24. [;;;; move or transpose lines up/down ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;](#org5654eb4)
25. [;;;; save last place edited update bookmarks ;;;;;;;;;;;;;;;;;;;;;](#orge364b6b)
26. [;;;; spray ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;](#orgc7b15ba)
27. [;;;; pdf-tools ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;](#org71ceaf7)
28. [;;;; personel random settings ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;](#org00b8c7c)
29. [;;;; evil snipe ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;](#org34b6b08)
30. [;;;; avy ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;](#orgf0fb207)
31. [;;;; transparency ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;](#org9592da1)
32. [;;;; peep dired ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;](#org8dd88d4)
33. [;;;; auto package update ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;](#org7903da8)
34. [;;;; syntax for color codes ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;](#orgf7a0675)
````

`====================================================================================`
;;          _               _           _                                           ;;
;;       __| |_   _____  __| |_   _  __| | ___ "stole all"                          ;;
;;      / _  \ \ / / __|/ _  | | | |/ _  |/ _ \                                     ;;
;;     | (_| |\ V /\__ \ (_| | |_| | (_| |  __/                                     ;;
;;      \__ _| \_/ |___/\__ _|\__ _|\__ _|\___| "regret none"                       ;;
;;     *A DASTARDLY DVS DOOM CONFIG*                                                ;;
`====================================================================================`


````
<a id="org58c1313"></a>

## ;;;; the lexical-binding ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


   ```elisp
    ;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

```

<a id="org4e97ce1"></a>

## ;;;; name ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


   ```elisp
    ;; Some functionality uses this to identify you
    (setq user-full-name "dvsdude"
          user-mail-address "john@doe.com")

```

<a id="orge446a2e"></a>

## ;;;; package manament ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


   ```elisp
    ;; this should speed up load time ;;
    ;; (setq straight-check-for-modifications '(check-on-save find-when-checking))
    (straight-use-package 'use-package)
    
    ;; This is only needed once, near the top of the file
    (eval-when-compile
    (require 'use-package))

```

<a id="orgf5b184f"></a>

## ;;;; FONTS ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


   ```elisp
    ;;; My font settings ;;;;;;;;;;;;;;;;;;;;;
    
    (require 'mixed-pitch)
    (mixed-pitch-mode)
    (add-hook 'text-mode-hook #'mixed-pitch-mode)
    (variable-pitch-mode t)
    
    
    (setq doom-font (font-spec :family "Hack Nerd Font" :size 17 :weight 'bold)
    doom-variable-pitch-font (font-spec :family "DroidSansMono Nerd Font" :size 18 :weight 'regular)
    doom-big-font (font-spec :family "Hack Nerd Font" :size 24))

```

<a id="orgfa59dcd"></a>

## ;;;; theme ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


   ```elisp
    ;; (setq doom-theme 'doom-one)
    (setq doom-theme 'doom-Iosvkem)

```

<a id="orgf898aeb"></a>

## ;;;; Line settings ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

   ```elisp
    (setq display-line-numbers-type `relative)
    
    ;; Sensible line breaking
    ;; (add-hook 'text-mode-hook 'visual-line-mode)
    (global-visual-line-mode 1)
    
    ;;no fringe;;;
    (set-fringe-mode 0)

```

<a id="org2045c25"></a>

## ;;;; Maximize on startup ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

   ```elisp
    ;; Maximize the window upon startup
    (add-to-list 'initial-frame-alist '(fullscreen . maximized))

```

<a id="org2373aed"></a>

## ;;;; load splash-image & icons ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

   ```elisp
    ;; load icons ;;
    (when (display-graphic-p)
    (require 'all-the-icons))
    ;; set fancy splash-image
    (setq fancy-splash-image "~/.doom.d/splash/doom-color.png")

```

<a id="org98abaf5"></a>

## ;;;; Dashboard ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

   ```elisp
    (use-package! dashboard
    :demand
    :if (< (length command-line-args) 2)
    :bind (:map dashboard-mode-map
    ("U" . auto-package-update-now)
    ("R" . restart-emacs)
    ("Z" . save-buffers-kill-emacs))
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
    (all-the-icons-faicon "gitlab" :height 0.8 :face 'all-the-icons))
    "Homepage"
    "Browse Homepage"
    (lambda (&rest _) (browse-url [[https://search.brave.com][homepage]])))
    (,(and (display-graphic-p)
    (all-the-icons-material "update" :height 0.7 :face 'all-the-icons))
    "Update"
    "Update emacs"
    (lambda (&rest _) (auto-package-update-now)))
    (,(and (display-graphic-p)
    (all-the-icons-material "autorenew" :height 0.7 :face 'all-the-icons))
    "Restart"
    "Restar emacs"
    (lambda (&rest _) (restart-emacs))))))
    :config
    (setq dashboard-items '((recents  . 8)
    (bookmarks . 8)))
    (dashboard-setup-startup-hook))
    ;; (dashboard-modify-heading-icons '((recents . "file-text")
    ;;                                    (bookmarks . "book")))
    ;; (setq initial-buffer-choice (lambda()(get-buffer "*dashboard*"))) ;; this is for use with emacsclient

```
;; If you use \`org&rsquo; and don&rsquo;t want your org files in the default location ,
;; change \`org-directory&rsquo;. It must be set before org loads!

   ```elisp
    (setq org-directory "~/org/")

```

<a id="orgd3bf802"></a>

## ;;;; org-settings ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

   ```elisp
    (require 'org)
    ;; jump to org folder;;;;;;;;;;;;;;;;;;;
    (global-set-key (kbd "C-c o")
    (lambda () (interactive) (find-file "~/org/")))
    
    ;; default file for notes ;;;;;;;;;;;;;;
    (setq org-default-notes-file (concat org-directory "~/org/notes.org"))
    
    ;; jump to config.org ;;
    (map! :leader
    (:prefix ("o" . "open file")
    :desc "open org config" "p" (lambda () (interactive) (find-file "~/.doom.d/config.org"))))
    
    ;; jump to org wiki folder;;
    (map! :leader
    (:prefix ("o" . "open file")
    :desc "open org wiki" "k" (lambda () (interactive) (find-file "~/org/wiki/"))))
    
    (setq org-agenda-include-diary t)
    (setq org-agenda-timegrid-use-ampm 1)
    
    ;; Improve org mode looks ;;;;;;;;;;;;;;;;;;;;;;;;
    
    (setq org-startup-indented t
    org-pretty-entities t
    org-hide-emphasis-markers t
    org-startup-with-inline-images t
    org-image-actual-width '(300))
    
    ;; change header * for symbols ;;
    (after! org)
    (require 'org-superstar)
    (add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))
    (setq inhibit-compacting-font-caches t)
    
    ;; use dash instead of hyphin ;;
    (font-lock-add-keywords
    'org-mode
    '(("^[[:space:]]*\\(-\\) "
    0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "—")))))
    
    ;; set font size for headers ;;
    (custom-set-faces
    '(org-level-1 ((t (:inherit outline-1 :height 1.2))))
    '(org-level-2 ((t (:inherit outline-2 :height 1.0))))
    '(org-level-3 ((t (:inherit outline-3 :height 1.0))))
    '(org-level-4 ((t (:inherit outline-4 :height 1.0))))
    '(org-level-5 ((t (:inherit outline-5 :height 1.0))))
    )

```

<a id="orga73503b"></a>

## ;;;; Markdown ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; use C-c / for menu

   ```elisp
    (use-package markdown-mode
    :commands (markdown-mode gfm-mode)
    :mode (("README\\.md\\'" . gfm-mode)
    ("\\.md\\'" . markdown-mode)
    ("\\.markdown\\'" . markdown-mode))
    :init (setq markdown-command "pandoc"))
    
    (add-hook 'markdown-mode-hook 'pandoc-mode)
    
    ;; default markdown-mode's markdown-live-preview-mode to vertical split
    (setq markdown-split-window-direction 'right)

```

<a id="org6bce5cf"></a>

## ;;;; Keychords ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

   ```elisp
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

```

<a id="orgb477780"></a>

## ;;;; Auto completion ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

   ```elisp
    ;; Completion words longer than 3 characters
    ;;    (custom-set-variables
    ;;      '(ac-ispell-requires 3)
    ;;      '(ac-ispell-fuzzy-limit 3))
    
    ;; (eval-after-load "auto-complete"
    ;;   '(progn
    ;;       (ac-ispell-setup)))
    
    ;; (add-hook 'git-commit-mode-hook 'ac-ispell-ac-setup)
    ;; (add-hook 'mail-mode-hook 'ac-ispell-ac-setup)
    
    
    ;; (require 'orderless)
    ;; (setq completion-styles '(orderless))

```

<a id="org208dd2a"></a>

## ;;;; company ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

   ```elisp
    ;; (use-package company
    ;;   :config
    ;;   (setq company-idle-delay 0
    ;;         company-minimum-prefix-length 3
    ;;         company-selection-wrap-around t))
    ;; (global-company-mode)

```

<a id="orge48dfd9"></a>

## ;;;; marginalia ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

   ```elisp
    ;; (use-package marginalia
    ;;   ;; The :init configuration is always executed (Not lazy!)
    ;;   :init
    ;;   ;; Must be in the :init section of use-package such that the mode gets
    ;;   ;; enabled right away. Note that this forces loading the package.
    ;;   (marginalia-mode))

```

<a id="org9237961"></a>

## ;;;; VERTICO ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

   ```elisp
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

```

<a id="org543c6b8"></a>

## ;;;; corfu ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

   ```elisp
    (use-package corfu
    ;; Optional customizations
    :custom
    (corfu-cycle t)                ;; Enable cycling for `corfu-next/previous'
    (corfu-auto t)                 ;; Enable auto completion
    ;; (corfu-commit-predicate nil)   ;; Do not commit selected candidates on next input
    (corfu-quit-at-boundary t)     ;; Automatically quit at word boundary
    (corfu-quit-no-match t)        ;; Automatically quit if there is no match
    ;; (corfu-preview-current nil)    ;; Disable current candidate preview
    (corfu-preselect-first nil)    ;; Disable candidate preselection
    ;; (corfu-echo-documentation nil) ;; Disable documentation in the echo area
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
    (setq completion-styles '(substring orderless)
    ;; (setq completion-styles '(orderless)
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

```

<a id="org46d7239"></a>

## ;;;; Embark ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

   ```elisp
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

```

<a id="org7232f7d"></a>

## ;;;; CONSULT ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

   ```elisp
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

```

<a id="orgc26763f"></a>

## ;;;; ignore-case ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

   ```elisp
    (setq read-file-name-completion-ignore-case t
    read-buffer-completion-ignore-case t
    completion-ignore-case t)

```

<a id="org90f32a6"></a>

## ;;;; elfeed ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

   ```elisp
    ;; (require 'elfeed-goodies)
    ;; (elfeed-goodies/setup)

```

<a id="orgd334017"></a>

## ;;;; scroll margin ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

   ```elisp
    ;; this should replicate scrolloff in vim ;;
    (setq scroll-conservatively 222
    maximum-scroll-margin 0.43
    scroll-margin 11
    scroll-preserve-screen-position 't)

```

<a id="org587920a"></a>

## ;;;; Whitespace ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; this is to color change text that goes beyond a set limit

   ```elisp
    (require 'whitespace)
    (after! org)
    (setq whitespace-line-column 68)
    (setq whitespace-style '(face lines-tail))
    (setq global-whitespace-mode t)
    
    
    (map! :leader
    (:prefix ("t". "line")
    :desc "whitespace toggle" "W" #'whitespace-mode))

;;;###autoload
(autoload 'whitespace-mode           "whitespace" "Toggle whitespace visualization"        t)

```

<a id="org5654eb4"></a>

## ;;;; move or transpose lines up/down ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

   ```elisp
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

```

<a id="orge364b6b"></a>

## ;;;; save last place edited update bookmarks ;;;;;;;;;;;;;;;;;;;;;

   ```elisp
    (save-place-mode 1)
    (setq save-place-forget-unreadable-files nil)
    (setq save-place-file "~/.emacs.d/saveplace")
    (setq bookmark-save-flag t)

```

<a id="orgc7b15ba"></a>

## ;;;; spray ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

   ```elisp
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

```

<a id="org71ceaf7"></a>

## ;;;; pdf-tools ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

   ```elisp
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

```

<a id="org00b8c7c"></a>

## ;;;; personel random settings ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    
   ```elisp
    (global-set-key (kbd "C-1") #'embrace-commander)
    (add-hook 'org-mode-hook #'embrace-org-mode-hook)
    (evil-embrace-enable-evil-surround-integration)
    ;; (evil-embrace-disable-evil-surround-integration)
    
    ;; should put  focus in the new window
    (setq evil-split-window-below t
    evil-vsplit-window-right t)
    
    (map! :leader
    (:prefix ("e". "end")
    :desc "end of line" "l" #'end-of-line))
    
    ;; number of lines of overlap in page flip
    (setq next-screen-context-lines 5)
    
    (require 'tempo)

```

<a id="org34b6b08"></a>

## ;;;; evil snipe ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

   ```elisp
    (require 'evil-snipe)
    (evil-snipe-mode t)
    (define-key evil-snipe-parent-transient-map (kbd "<f8>")
    (evilem-create 'evil-snipe-repeat
    :bind ((evil-snipe-scope 'buffer)
    (evil-snipe-enable-highlight)
    (evil-snipe-enable-incremental-highlight))))
    (push '(?\[ "[[{(]") evil-snipe-aliases)

```

   ```elisp
    (which-key-setup-minibuffer)
    ;; (which-key-setup-side-window-bottom)
    ;;(which-key-setup-side-window-right)
    ;;(which-key-setup-side-window-right-bottom)

```

<a id="orgf0fb207"></a>

## ;;;; avy ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

   ```elisp
    (map! :leader
    (:prefix ("s". "search")
    :desc "avy goto char timer" "a" #'evil-avy-goto-char-timer))
    
    (setq avy-timeout-seconds 0.8) ;;default 0.5
    (setq avy-single-candidate-jump t)

```

<a id="org9592da1"></a>

## ;;;; transparency ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

   ```elisp
    
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

```

<a id="org8dd88d4"></a>

## ;;;; peep dired ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    
   ```elisp
    
    (map! :leader
    (:prefix ("t". "toggle")
    :desc "peep dired toggle" "p" #'peep-dired))
    
    (setq peep-dired-cleanup-on-disable t)
    (evil-define-key 'normal peep-dired-mode-map (kbd "n") 'peep-dired-scroll-page-down
    (kbd "p") 'peep-dired-scroll-page-up
    (kbd "j") 'peep-dired-next-file
    (kbd "<down>") 'peep-dired-next-file
    (kbd "k") 'peep-dired-prev-file
    (kbd "<up>") 'peep-dired-prev-file)
    (add-hook 'peep-dired-hook 'evil-normalize-keymaps)

```

<a id="org7903da8"></a>

## ;;;; auto package update ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

   ```elisp
    
    (use-package cl-lib)
    (require 'misc)
    
    (use-package auto-package-update
    :custom
    (auto-package-update-last-update-day-path (concat cache-dir ".last-package-update-day"))
    (auto-package-update-delete-old-versions t))

```

<a id="orgf7a0675"></a>

## ;;;; syntax for color codes ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

   ```elisp
    ;;;  "Syntax color for code colors 「#ff1100」
    (require 'rainbow-mode)
    (add-hook 'prog-mode-hook #'rainbow-mode)

```
