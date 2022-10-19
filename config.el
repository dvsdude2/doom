;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Some functionality uses this to identify you
(setq user-full-name "dvsdude"
      user-mail-address "john@doe.com")

;; toggle debugger ;;;;
;; (toggle-debug-on-error)
;; (add-hook 'after-init-hook 'toggle-debug-on-error)

;; This is only needed once, near the top of the file
;; (require 'use-package)

;; integrates straight with use-package ;;;;
(straight-use-package 'use-package)

(require 'mixed-pitch)
(mixed-pitch-mode)
(add-hook 'text-mode-hook #'mixed-pitch-mode)

;; fontset ;;;;
(setq doom-font (font-spec :family "Hack Nerd Font" :size 17 :weight 'bold)
;; (setq doom-font (font-spec :family "Iosevka" :size 17 :weight 'heavy)
     doom-variable-pitch-font (font-spec :family "DroidSansMono Nerd Font" :size 17)
     ;; doom-variable-pitch-font (font-spec :family "Iosevka" :size 18)
     doom-big-font (font-spec :family "Hack Nerd Font" :size 24))

(set-fontset-font t 'emoji
                      '("My New Emoji Font" . "iso10646-1") nil 'prepend)

;; (setq doom-theme 'doom-one)
(setq doom-theme 'doom-Iosvkem)

;; line number type
;; (setq display-line-numbers-type `relative)
(setq display-line-numbers-type 'visual)
;; set fancy splash-image
(setq fancy-splash-image "~/.doom.d/splash/doom-color.png")
;; set org-directory. It must be set before org loads
(setq org-directory "~/org/")
;; Sensible line breaking
(add-hook 'text-mode-hook 'visual-line-mode)
;; Maximize the window upon startup
(add-to-list 'initial-frame-alist '(fullscreen . maximized))
;; no fringe
(set-fringe-mode 0)

;; (setq initial-buffer-choice (lambda()(get-buffer "*dashboard*"))) ;; this is for use with emacsclient
(use-package! dashboard
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
             (all-the-icons-faicon "rss" :height 0.8 :face 'font-lock-keyword-face))
       "Elfeed"
       "Open elfeed"
       (lambda (&rest _) (elfeed)))
      (,(and (display-graphic-p)
             (all-the-icons-faicon "gitlab" :height 0.8 :face 'font-lock-keyword-face))
       "Homepage"
       "Browse Homepage"
       (lambda (&rest _) (browse-url"https://search.brave.com/")))
      (,(and (display-graphic-p)
             (all-the-icons-material "update" :height 1.0 :face 'font-lock-keyword-face))
       "Update"
       "Update emacs"
       (lambda (&rest _) (async-shell-command (format "doom s -u"))))
      (,(and (display-graphic-p)
             (all-the-icons-material "autorenew" :height 1.0 :face 'font-lock-keyword-face))
       "Restart"
       "Restar emacs"
       (lambda (&rest _) (restart-emacs)))
      (,(and (display-graphic-p)
               (all-the-icons-material "autorenew" :height 1.0 :face 'font-lock-keyword-face))
         "Doom-sync"
         "Doom-sync"
         (lambda (&rest _) (async-shell-command (format "doom s")))))))
  :config
       (setq dashboard-items '((recents . 7)
                              (bookmarks . 6)
                               (agenda . 3)))

       (dashboard-setup-startup-hook))
 ;; (setq dashboard-filter-agenda-entry 'dashboard-no-filter-agenda)
;; +doom-dashboard ;;

(add-to-list '+doom-dashboard-menu-sections
             '("Add journal entry"
               :icon (all-the-icons-octicon "calendar" :face 'doom-dashboard-menu-title)
               :when (featurep! :lang org +journal)
               :face (:inherit (doom-dashboard-menu-title bold))
               :action org-journal-new-entry))

;; default file for notes
(setq org-default-notes-file (concat org-directory "notes.org"))

(setq org-agenda-diary-file "~/org/notable-dates.org")
(setq diary-file "~/org/notable-dates.org")

;; org-journal
(setq org-journal-dir "~/org/journal/")
(require 'org-journal)
(setq org-journal-file-type 'yearly)
(add-hook 'org-journal-mode-hook 'auto-fill-mode)

;; jump to config.org
(map! :leader
      (:prefix ("o" . "open file")
       :desc "open org config" "p" (lambda () (interactive) (find-file "~/.doom.d/config.org"))))

;; jump to notes.org
(map! :leader
      (:prefix ("o" . "open file")
       :desc "open org notes" "n" (lambda () (interactive) (find-file "~/org/notes.org"))))

;; jump to org folder
(map! :leader
      (:prefix ("o" . "open file")
       :desc "open org folder" "o" (lambda () (interactive) (find-file "~/org/"))))

;; jump to org organizer
(map! :leader
      (:prefix ("o" . "open file")
       :desc "open org organizer" "0" (lambda () (interactive) (find-file "~/org/organizer.org"))))

;; jump to org wiki folder
(map! :leader
      (:prefix ("o" . "open file")
       :desc "open org wiki" "k" (lambda () (interactive) (find-file "~/org/wiki/"))))

;; Insert a file link. At the prompt, enter the filename
(defun +org-insert-file-link ()
  (interactive)
  (insert (format "[[%s]]" (org-link-complete-file))))
(map! :after org
      :map org-mode-map
      :leader
      (:prefix ("l" . "link")
       :desc "insert file link" "f" #'+org-insert-file-link))

;; C-c C-, brings up menu for adding code blocks
(require 'org-tempo)
(add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))

;; brings up a buffer for capturing
(require 'org-capture)
(add-to-list 'org-capture-templates
             '("l" "check out later" entry
               (file+headline "todo.org" "Check out later")
               "** IDEA %?\n %i\n %a" :prepend t))

(add-to-list 'org-capture-templates
              '("z" "organizer" entry
               (file+headline "~/org/organizer.org" "refile stuff")
               "** NEW %?\n  %i\n  " :prepend t))
(add-to-list 'org-capture-templates
              '("k" "keybindings" entry
               (file+headline "~/org/wiki/my-keybinding-list.org" "new ones")
               "** NEW %?\n  %i\n  " :prepend t))

;; org-refile
(setq org-refile-targets '((nil :maxlevel . 2)
                                (org-agenda-files :maxlevel . 2)))
(setq org-outline-path-complete-in-steps nil)         ;; Refile in a single go
(setq org-refile-use-outline-path 'file)              ;; this also set by vertico

;; uses Pandoc to convert selected file types to org
(after! org
(use-package org-pandoc-import))

;; org-src edit window
;; (setq org-src-window-setup 'other-frame)
(setq org-src-window-setup 'reorganize-frame)  ;; default
;; editing src-blocks this should autosave base file after edit
;; (setq org-edit-src-auto-save-idle-delay 5)

(after! org
(setq org-agenda-include-diary t
      org-agenda-inhibit-startup nil ;; default is showall
      org-agenda-timegrid-use-ampm 1
      org-startup-indented t
      org-pretty-entities t
      org-hide-emphasis-markers t
      org-startup-with-inline-images t
      org-image-actual-width '(300)))

;; un-hide emphasis-markers when under point ;;;;
(add-hook 'org-mode-hook 'org-appear-mode)

;; change header * for symbols ;;;;
(require 'org-superstar)
(after! org
(add-hook 'org-mode-hook (lambda () (org-superstar-mode 1))))

;; set font size for headers ;;
(after! org
(custom-set-faces
  '(org-level-1 ((t (:inherit outline-1 :height 1.2))))
  '(org-level-2 ((t (:inherit outline-2 :height 1.0))))
  '(org-level-3 ((t (:inherit outline-3 :height 1.0))))
  '(org-level-4 ((t (:inherit outline-4 :height 1.0))))
  '(org-level-5 ((t (:inherit outline-5 :height 1.0))))
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

(require 'evil-surround)
(add-hook 'org-mode-hook (lambda ()
                           (push '(?= . ("=" . "=")) evil-surround-pairs-alist)))
(add-hook 'emacs-lisp-mode-hook (lambda ()
                                  (push '(?` . ("`" . "'")) evil-surround-pairs-alist)))

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

(require 'key-chord)
(key-chord-mode 1)
;; Exit insert mode by pressing j and then j quickly
;; Max time delay between two key presses to be considered a key chord
(setq key-chord-two-keys-delay 0.2) ; default 0.1
;; Max time delay between two presses of the same key to be considered a key chord.
;; Should normally be a little longer than;key-chord-two-keys-delay.
(setq key-chord-one-key-delay 0.3) ; default 0.2
(key-chord-define evil-insert-state-map "jj" 'evil-normal-state)
(key-chord-define evil-insert-state-map "kn" 'evil-normal-state)
(key-chord-define evil-insert-state-map "dw" 'backward-kill-word)
(key-chord-define evil-insert-state-map ";l" 'org-end-of-line)
(key-chord-define evil-insert-state-map "hh" 'org-beginning-of-line)

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
;; Alternatively try `consult-completing-read-multiple' ;;;;
  (defun crm-indicator (args)
    (cons (concat "[CRM] " (car args)) (cdr args)))
  (advice-add #'completing-read-multiple :filter-args #'crm-indicator)

;; Do not allow the cursor in the minibuffer prompt ;;;;
(setq minibuffer-prompt-properties
      '(read-only t cursor-intangible t face minibuffer-prompt))
(add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)

;; Enable recursive minibuffers ;;;;
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

(use-package corfu
;; Optional customizations
  :custom
  (corfu-cycle t)                ;; Enable cycling for `corfu-next/previous'
  (corfu-auto t)                 ;; Enable auto completion
;; (corfu-separator ?\s)          ;; Orderless field separator
  (corfu-quit-at-boundary t)   ;; Never quit at completion boundary
  (corfu-quit-no-match t)      ;; Never quit, even if there is no match
;; (corfu-preview-current nil)    ;; Disable current candidate preview
  (corfu-preselect-first nil)    ;; Disable candidate preselection
;; (corfu-on-exact-match nil)     ;; Configure handling of exact matches
  (corfu-echo-documentation nil) ;; Disable documentation in the echo area
  (corfu-scroll-margin 3)        ;; Use scroll margin
  (corfu-auto-prefix 4)

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
  (global-corfu-mode))
(use-package orderless
  :init
  ;; (setq completion-styles '(basic substring flex partial-completion orderless)
  ;; (setq completion-styles '(basic substring partial-completion flex))
  ;; (setq completion-styles '(substring orderless)
  (setq completion-styles '(orderless)
        completion-category-defaults nil
        completion-category-overrides '((file (styles . (partial-completion))))))
;; Use dabbrev with Corfu!
(use-package dabbrev
;; Swap M-/ and C-M-/
  :bind (("M-/" . dabbrev-completion)
         ("C-M-/" . dabbrev-expand))
;; Other useful Dabbrev configurations.
  :custom
  (dabbrev-ignored-buffer-regexps '("\\.\\(?:pdf\\|jpe?g\\|png\\)\\'")))
(use-package emacs
  :init
;; TAB cycle if there are only few candidates
  (setq completion-cycle-threshold 3)
;; Enable indentation+completion using the TAB key.
;; `completion-at-point' is often bound to M-TAB.
  (setq tab-always-indent 'complete))

;; path to full word dictionary ;;;;
;; (setq ispell-complete-word-dict "/usr/share/dict/20k.txt")
;; (setq ispell-complete-word-dict "~/dict/dictionary-fullwords")

;; Add extensions
(use-package cape
  :init
;; Add `completion-at-point-functions', used by `completion-at-point'.;;;;
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-keyword)
  (add-to-list 'completion-at-point-functions #'cape-abbrev)
  (add-to-list 'completion-at-point-functions #'cape-ispell)
  (add-to-list 'completion-at-point-functions #'cape-dict)
  ;; (add-to-list 'completion-at-point-functions #'cape-symbol)
)

;; ;; Use Company backends as Capfs.
;; ;; (setq-local completion-at-point-functions
;; ;;   (mapcar #'cape-company-to-capf
;; ;;     (list #'company-files #'company-web #'company-dabbrev)))

;; ;; Merge the dabbrev, dict and keyword capfs, display candidates together.
(setq-local completion-at-point-functions
            (list (cape-super-capf #'cape-dabbrev #'cape-dict #'cape-ispell)))

;; (setq cape-dict-file "~/dict/dictionary-fullwords")

;; ;; (require 'company)
;; ;; ;; Use the company-dabbrev and company-elisp backends together.
;; ;; (setq completion-at-point-functions
;; ;;       (list
;; ;;        (cape-company-to-capf
;; ;;         (apply-partially #'company--multi-backend-adapter
;; ;;                          '(company-dabbrev company-elisp)))))

(use-package lsp-mode
  :custom
  (lsp-completion-provider :none) ;; we use Corfu!

  :init
  (defun my/orderless-dispatch-flex-first (_pattern index _total)
    (and (eq index 0) 'orderless-flex))

  (defun my/lsp-mode-setup-completion ()
    (setf (alist-get 'styles (alist-get 'lsp-capf completion-category-defaults))
          '(orderless)))

  ;; Optionally configure the first word as flex filtered.
  (add-hook 'orderless-style-dispatchers #'my/orderless-dispatch-flex-first nil 'local)

  ;; Optionally configure the cape-capf-buster.
  (setq-local completion-at-point-functions (list (cape-capf-buster #'lsp-completion-at-point)))

  :hook
  (lsp-completion-mode . my/lsp-mode-setup-completion))

(use-package flyspell-correct
  :after flyspell
  :bind (:map flyspell-mode-map ("C-;" . flyspell-correct-wrapper)))


(setq ispell-list-command "--list")
(add-to-list 'ispell-skip-region-alist '("^#+BEGIN_SRC" . "^#+END_SRC"))


(setq flyspell-persistent-highlight nil)

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
;;  "Hide the which-key indicator immediately when using the completing-read prompter."
  (which-key--hide-popup-ignore-command)
  (let ((embark-indicators
         (remq #'embark-which-key-indicator embark-indicators)))
      (apply fn args)))

(advice-add #'embark-completing-read-prompter
            :around #'embark-hide-which-key-indicator)

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
         ("M-g g" . consult-goto-line)             ;; orig. goto-line
         ("M-g M-g" . consult-goto-line)           ;; orig. goto-line
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

;; Enable richer annotations using the Marginalia package
(use-package marginalia
;; Either bind `marginalia-cycle` globally or only in the minibuffer
  :bind (("M-A" . marginalia-cycle)
         :map minibuffer-local-map
         ("M-A" . marginalia-cycle))
;; The :init configuration is always executed (Not lazy!)
  :init
;; Must be in the :init section of use-package such that the mode gets
;; enabled right away. Note that this forces loading the package.
  (marginalia-mode))

(setq read-file-name-completion-ignore-case t
      read-buffer-completion-ignore-case t
      completion-ignore-case t)

;; this should replicate scrolloff in vim ;;
(setq scroll-conservatively 222)
(setq scroll-margin 5)
(setq scroll-preserve-screen-position t)

(require 'whitespace)
(after! org
(setq whitespace-line-column 78)
(setq whitespace-style '(face lines-tail))
(setq global-whitespace-mode t))

(map! :leader
     (:prefix ("t". "toggle")
      :desc "whitespace toggle" "W" #'whitespace-mode))

;;;###autoload
(autoload 'whitespace-mode           "whitespace" "Toggle whitespace visualization"        t)

(defun move-line-up ()
  (interactive)
  (transpose-lines 1)
  (forward-line -2))

(defun move-line-down ()
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1))

(map! "M-<up>" #'move-line-up)
(map! "M-<down>" #'move-line-down)

;; save last place edited & update bookmarks
(global-auto-revert-mode 1)
(save-place-mode 1)
(setq save-place-forget-unreadable-files nil)
(setq save-place-file "~/.doom.d/saveplace")
(setq bookmark-save-flag t)

(global-set-key (kbd "<f6>") 'spray-mode)
(use-package! spray
  :load-path "~/builds/manual-packages/spray"
  :commands spray-mode
  :config
  (setq spray-wpm 220
        spray-height 800)
   (map! :after spray
         :map spray-mode-map "<f6>" #'spray-mode
                         "<return>" #'spray-start/stop
                                "f" #'spray-faster
                                "s" #'spray-slower
                                "t" #'spray-time
                          "<right>" #'spray-forward-word
                                "h" #'spray-forward-word
                           "<left>" #'spray-backward-word
                                "l" #'spray-backward-word
                                "q" #'spray-quit))
(add-hook 'spray-mode-hook #'cursor-intangible-mode)
;; "Minor modes to toggle off when in spray mode."
(setq spray-unsupported-minor-modes
  '(beacon-mode buffer-face-mode smartparens-mode highlight-symbol-mode
		     column-number-mode line-number-mode ))
(setq cursor-in-non-selected-windows nil)
(require 'spray)

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

;; function to get back to last place edited
(defun mu-back-to-last-edit ()
  "Jump back to the last change in the current buffer."
  (interactive)
  (ignore-errors
    (let ((inhibit-message t))
      (undo-only)
      (undo-redo))))

;; use trash
(setq delete-by-moving-to-trash t)
;; add packages manually by downloading the repo to here
(add-to-list 'load-path "~/builds/manual-packages/spray")

;; this keeps the workspace-bar visable
(after! persp-mode
  (defun display-workspaces-in-minibuffer ()
    (with-current-buffer " *Minibuf-0*"
      (erase-buffer)
      (insert (+workspace--tabline))))
  (run-with-idle-timer 1 t #'display-workspaces-in-minibuffer)
  (+workspace/display))

;; try vertical diff ;;;;
(setq ediff-split-window-function 'split-window-vertically)

;; should put  focus in the new window ;;;;
(setq evil-split-window-below t
      evil-vsplit-window-right t)

;; number of lines of overlap in page flip ;;;;
(setq next-screen-context-lines 7)

;;;  "Syntax color, highlighting code colors ;;;;
(add-hook 'prog-mode-hook #'rainbow-mode)

;; youtube download ;;;;
(require 'ytdl)

;; beacon highlight cursor ;;;;;
(beacon-mode t)

;; typing speed test ;;;;
(require 'typit)

;; ;; stem reading mode ;;;;
(require 'stem-reading-mode)
(set-face-attribute 'stem-reading-highlight-face nil :weight 'unspecified)
(set-face-attribute 'stem-reading-delight-face nil :weight 'light)

;; this should stop the warnings given in reg elisp docs/test files ;;;;
(with-eval-after-load 'flycheck
  (setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc)))

;; plantuml jar configuration ;;;;
(setq plantuml-jar-path "/usr/share/java/plantuml/plantuml.jar")
;; Enable plantuml-mode for PlantUML files ;;;;
(add-to-list 'auto-mode-alist '("\\.plantuml\\'" . plantuml-mode))
;; Enable exporting ;;;;
(org-babel-do-load-languages 'org-babel-load-languages '((plantuml . t)))

;; declutter ;;;;
(require 'declutter)
(setq declutter-engine 'rdrview)  ; rdrview will get and render html
; or
;; (setq declutter-engine 'eww)      ; eww will get and render html
(setq declutter-engine-path "/usr/bin/rdrview")


;; Show the current location and put it into the kill ring ;;;;
(defun copy-current-location (no-line-number)
;;     "\"Location\" means the filename and line number (after a colon).
;; Use the filename relative to the parent of the current VC root
;; directory, so it starts with the main project dir.  With \\[universal-argument],
;; the line number is omitted."
  (interactive "P")
  (let* ((file-name (file-relative-name
		     buffer-file-name
		     (file-name-concat (vc-root-dir) "..")))
	 (line-number (line-number-at-pos nil t))
	 (location
	  (format (if no-line-number "%s" "%s:%s")
		  file-name line-number)))
    (kill-new location)
    (message location)))

(setq dictionary-server "dict.org")

(map! :leader
     (:prefix ("i". "insert")
      :desc "copy current location to kill-ring" "c l" #'copy-current-location))
(map! :leader
    (:prefix ("i". "insert")
     :desc "append to buffer" "t" #'append-to-buffer))
(map! :leader
    (:prefix ("i". "insert")
     :desc "insert buffer at point" "b" #'insert-buffer))
;; close other window ;;;;
(map! "C-1" #'delete-other-windows)
;; toggle comment ;;;;
(map! "M-;" #'evilnc-comment-or-uncomment-lines)
;; start modes
(map! :prefix "C-c m"
      "o" #'org-mode
      "e" #'emacs-lisp-mode
      "f" #'fundamental-mode)
;; Make `v$' not include the newline character ;;;;
(general-define-key
:states '(visual state)
"$" '(lambda ()
        (interactive)
        (evil-end-of-line)))

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

;; (setq which-key-popup-type 'minibuffer)
;; (setq which-key-popup-type 'side-window)
;; (setq which-key-popup-type 'frame)

;; (which-key-setup-minibuffer)
(which-key-setup-side-window-bottom)
;;(which-key-setup-side-window-right)
;;(which-key-setup-side-window-right-bottom)
;; (setq which-key-use-C-h-commands nil)
(setq which-key-idle-delay 1)

(map! :leader
     (:prefix ("s". "search")
      :desc "avy goto char timer" "a" #'evil-avy-goto-char-timer))

(setq avy-timeout-seconds 1.0) ;;default 0.5
(setq avy-single-candidate-jump t)

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
         '(85 . 45) '(100 . 100)))))
(map! :leader
     (:prefix ("t". "toggle")
      :desc "toggle transparency" "t" #'toggle-transparency))

(add-hook 'dired-mode-hook
          'display-line-numbers-mode)
(add-hook 'dired-mode-hook
          'dired-hide-details-mode)
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
(setq dired-dwim-target t)

;; add org+mpv ;;;;
(org-link-set-parameters "mpv" :follow #'mpv-play)
(defun org-mpv-complete-link (&optional arg)
  (replace-regexp-in-string
   "file:" "mpv:"
   (org-link-complete-file arg)
   t t))
(defun my:mpv/org-metareturn-insert-playback-position ()
  (when-let ((item-beg (org-in-item-p)))
    (when (and (not org-timer-start-time)
               (mpv-live-p)
               (save-excursion
                 (goto-char item-beg)
                 (and (not (org-invisible-p)) (org-at-item-timer-p))))
      (mpv-insert-playback-position t))))
(add-hook 'org-metareturn-hook #'my:mpv/org-metareturn-insert-playback-position)
(add-hook 'org-open-at-point-functions #'mpv-seek-to-position-at-point)
;; mpv seek to position at point
(define-key global-map (kbd "C-x ,") 'mpv-seek-to-position-at-point)

;; mpv commands ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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
;; use mpv to open video files ;;;;
(map! :leader
      (:prefix ("v" . "video")
       :desc "play with mpv" "p" #'mpv-play))

;; mpv-hydra ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defhydra hydra-mpv (global-map "<f5>")
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

;;; deft ;;;; spc n d ;;;;
(require 'deft)
(setq deft-extensions '("md" "txt" "tex" "org"))
(setq deft-directory "~/org/")
(setq deft-recursive t)
;; (setq deft-use-filename-as-title t)
(map! :after deft
      :map deft-mode-map
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
        :n "q"   #'kill-current-buffer)

;;; elfeed ;;;;
(require 'elfeed)
(require 'elfeed-goodies)
(elfeed-goodies/setup)
(require 'elfeed-org)
(elfeed-org)
(setq rmh-elfeed-org-files (list "~/.doom.d/elfeed-feeds.org"))
;; "Watch a video from URL in MPV" ;;
(defun elfeed-v-mpv (url)
  (async-shell-command (format "mpv %s" url)))
(defun elfeed-view-mpv (&optional use-generic-p)
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
  (let ((default-directory "~/Videos"))
    (async-shell-command (format "yt-dlp %s" url))))
(defun elfeed-youtube-dl (&optional use-generic-p)
  (interactive "P")
  (let ((entries (elfeed-search-selected)))
    (cl-loop for entry in entries
             do (elfeed-untag entry 'unread)
             when (elfeed-entry-link entry)
             do (yt-dl-it it))
    (mapc #'elfeed-search-update-entry entries)
    (unless (use-region-p) (forward-line))))
;; browse with eww ;;;;
(defun elfeed-eww-open (&optional use-generic-p)
  (interactive "P")
  (let ((entries (elfeed-search-selected)))
    (cl-loop for entry in entries
             do (elfeed-untag entry 'unread)
             when (elfeed-entry-link entry)
             do (eww-browse-url it))
    (mapc #'elfeed-search-update-entry entries)
    (unless (use-region-p) (forward-line))))
;; define tag "star" ;;;;
(defalias 'elfeed-toggle-star
       (elfeed-expose #'elfeed-search-toggle-all 'star))

;; keymap ;;
(map! :leader
     (:prefix ("o". "open")
      :desc "open elfeed" "e" #'elfeed))
(map! :after elfeed
      :map elfeed-search-mode-map
        :n "8" #'elfeed-toggle-star
        :n "d" #'elfeed-youtube-dl
        :n "v" #'elfeed-view-mpv
        :n "w" #'elfeed-eww-open
        :n "R" #'elfeed-summary
        :n "6" #'elfeed-tube-fetch)
(map! :after elfeed
      :map elfeed-show-mode-map
        :n "v" #'elfeed-view-mpv
        :n "j" #'elfeed-goodies/split-show-next
        :n "k" #'elfeed-goodies/split-show-prev
        :n "x" #'elfeed-goodies/delete-pane
        :n "F" #'elfeed-tube-fetch
        :n "w" #'elfeed-eww-open
        :n "C-c C-f" #'elfeed-tube-mpv-follow-mode
        :n "C-c C-w" #'elfeed-tube-mpv-were)

;; (add-hook 'elfeed-new-entry-hook
;;           (elfeed-make-tagger :feed-url "youtube\\.com"
;;                               :add '(video yt)))
;;;; set default filter ;;;;
;; (setq-default elfeed-search-filter "@1-week-ago +unread ")
(setq-default elfeed-search-filter "@4-week-ago ")

;; (add-hook 'elfeed-new-entry-hook
;;           (elfeed-make-tagger :before "2 weeks ago"
;;                               :remove 'unread))

;; hook for summary and update
;; (add-hook! 'elfeed-search-mode-hook #'elfeed-update)
;; (add-hook! 'elfeed-search-mode-hook :append #'elfeed-summary)
;; (add-hook! 'elfeed-search-mode-hook :append #'elfeed-update)
;; (add-hook 'elfeed-search-mode-hook #'elfeed-summary)

(require 'elfeed-tube)
(after! elfeed
(elfeed-tube-setup)
(define-key elfeed-show-mode-map [remap save-buffer] 'elfeed-tube-save)
(define-key elfeed-search-mode-map [remap save-buffer] 'elfeed-tube-save))
(require 'elfeed-tube-mpv)

;; Add the `paywall' tag to a feed
(require 'elfeed-paywall)

(defun my-elfeed-transform-entry (entry)
;; "Transformation logic for ENTRYs."
  (elfeed-paywall-with-tag
   entry 'paywall
   (lambda ()
     (elfeed-log 'info "Processing Entry %s" (elfeed-deref (elfeed-entry-title entry)))
     ;; Remove the analytics URL forwarder that is put in front of
     ;; "The Register" articles
     (elfeed-paywall-replace-regexp-in-link
      entry "go.theregister.com/feed/" "")

     ;; Prefix the link for use with https://12ft.io (A direct
     ;; URL, no JS required)
     (elfeed-paywall-add-paywall-proxy entry)

     ;; Visit the entry link, bypass the paywall, and extract the
     ;; content from the page, then replace the content in the
     ;; entry with it
     (elfeed-paywall-extract-from-url entry))

   ;; Delete the tag after running the lambda
   t))

(add-hook 'elfeed-new-entry-hook #'my-elfeed-transform-entry)

(use-package elfeed-summary)

(setq elfeed-summary-settings
      '((group (:title . "news")
               (:elements
                (query . news))
               (:hide t))
        (group (:title . "humor")
               (:elements
                (query . fun))
               (:hide t))
        (group (:title . "repos")
               (:elements
                (query . github))
               (:hide t))
        (group (:title . "doom")
               (:elements
                (query . doom))
               (:hide t))
        (group (:title . "emacs")
               (:elements
                (query . emacs))
               (:hide t))
        (group (:title . "linux")
               (:elements
                (query . linux))
               (:hide t))
        (group (:title . "corbett")
               (:elements
                (query . corbet))
               (:hide t))
        (group (:title . "substack")
               (:elements
                (query . sub))
               (:hide t))
        (group (:title . "videos")
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
        ;; ...

        ;; ...
        (group (:title . "miscellaneous")
         (:elements
          (group
           (:title . "searches unread")
           (:elements
            (search
             (:filter . "+star +unread")
             (:title . "stared unread"))
            (search
             (:filter . "@1-day-ago +unread")
             (:title . "1 day unread"))
            (search
             (:filter . "@2-day-ago +unread")
             (:title . "2 days unread"))
            (search
             (:filter . "@3-day-ago +unread")
             (:title . "3 days unread"))
            (search
             (:filter . "@4-day-ago +unread")
             (:title . "4 days unread"))
            (search
             (:filter . "@6-months-ago +unread")
             (:title . "6 months unread"))))))
        (group (:title . "Miscellaneous")
               (:elements
                (group
                 (:title . "Searches all")
                 (:elements
                  (search
                   (:filter . "+star")
                   (:title . "stared"))
                  (search
                   (:filter . "@1-day-ago")
                   (:title . "1 day all"))
                  (search
                   (:filter . "@2-day-ago")
                   (:title . "2 days all"))
                  (search
                   (:filter . "@3-day-ago")
                   (:title . "3 days all"))
                  (search
                   (:filter . "@6-months-ago")
                   (:title . "6-months all")))
                 (:hide t))
                (group
                 (:title . "Ungrouped")
                 (:elements :misc))))))
(setq elfeed-summary-other-window t)

;; (add-hook! 'elfeed-summary-mode-hook :append #'elfeed-summary-update)
;; (add-hook 'elfeed-summary-mode-hook #'elfeed-summary-update)

;; found in manual for eww w/spc h R ;;;;
(setq eww-retrieve-command
     '("brave" "--headless" "--dump-dom"))

(use-package osm
  :bind (("C-c m h" . osm-home)
         ("C-c m s" . osm-search)
         ("C-c m v" . osm-server)
         ("C-c m t" . osm-goto)
         ("C-c m x" . osm-gpx-show)
         ("C-c m j" . osm-bookmark-jump))

  :custom
  ;; Take a look at the customization group `osm' for more options.
  (osm-server 'default) ;; Configure the tile server
  (osm-copyright t)     ;; Display the copyright information

  :init
  ;; Load Org link support
  (with-eval-after-load 'org
    (require 'osm-ol)))

(use-package dwim-shell-command
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

(use-package vterm
  :custom
(vterm-module-cmake-args "-DUSE_SYSTEM_LIBVTERM=yes")
(vterm-always-compile-module t))

;; vterm-toggle ;;;;
(global-set-key [f2] 'vterm-toggle)
(global-set-key [C-f2] 'vterm-toggle-cd)

;; you can cd to the directory where your previous buffer file exists
;; after you have toggle to the vterm buffer with `vterm-toggle'. ;;;;
(define-key vterm-mode-map [(control return)]   #'vterm-toggle-insert-cd)

;; Switch to next vterm buffer ;;;;
(define-key vterm-mode-map (kbd "s-n")   'vterm-toggle-forward)
;; Switch to previous vterm buffer ;;;;
(define-key vterm-mode-map (kbd "s-p")   'vterm-toggle-backward)

(use-package engine-mode
  :config
  (engine-mode t))
(defengine github
  "https://github.com/search?ref=simplesearch&q=%s"
  :keybinding "h")
(defengine google
  "http://www.google.com/search?ie=utf-8&oe=utf-8&q=%s"
  :keybinding "g")
(defengine brave
  "https://search.brave.com/search?q=%s"
  :keybinding "b")

(require 'yasnippet)
(yas-global-mode 1)
