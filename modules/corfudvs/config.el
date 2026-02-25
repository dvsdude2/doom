;;; completion/corfu/config.el -*- lexical-binding: t; -*-

(defvar +corfu-want-ret-to-confirm t
  "Configure how the user expects RET to behave.
Possible values are:
- t (default): Insert candidate if one is selected, pass-through otherwise;
- nil: Pass-through without inserting;
- `both': Insert candidate if one is selected, then pass-through;
- `minibuffer': Behaves like `both` in the minibuffer and `t` otherwise.")

(defvar +corfu-buffer-scanning-size-limit (* 1 1024 1024) ; 1 MB
  "Size limit for a buffer to be scanned by `cape-dabbrev'.")

(defvar +corfu-want-minibuffer-completion nil
  "Whether to enable Corfu in the minibuffer.
Setting this to `aggressive' will enable Corfu in more commands which
use the minibuffer such as `query-replace'.")

(defvar +corfu-want-tab-prefer-expand-snippets nil
  "If non-nil, prefer expanding snippets over cycling candidates with
TAB.")

(defvar +corfu-want-tab-prefer-navigating-snippets nil
  "If non-nil, prefer navigating snippets over cycling candidates with
TAB/S-TAB.")

(defvar +corfu-want-tab-prefer-navigating-org-tables nil
  "If non-nil, prefer navigating org tables over cycling candidates with
TAB/S-TAB.")

(map! :after corfu
      :map corfu-map
      [remap corfu-insert-separator] #'+corfu/smart-sep-toggle-escape
      "C-p" #'corfu-previous
      "C-n" #'corfu-next)

(map! :map corfu-map
      :gi [return] nil
      :gi "RET" nil
      "S-TAB" #'corfu-previous
      [backtab] #'corfu-previous
      :gi "TAB" #'corfu-next
      :gi "<tab>" #'corfu-next)

;;
;;; Packages

(use-package! corfu
  :hook (doom-first-input . global-corfu-mode)
  :config
  (setq corfu-auto t
        global-corfu-modes
        '((not erc-mode
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
  (add-to-list 'corfu-continue-commands #'+corfu/move-to-minibuffer)
  (add-to-list 'corfu-continue-commands #'+corfu/smart-sep-toggle-escape)
  (add-hook 'evil-insert-state-exit-hook #'corfu-quit))

(use-package! corfu-auto
  :defer t
  :config
  (setq corfu-auto-delay 0.24
        corfu-auto-prefix 3)
  (add-to-list 'corfu-auto-commands #'lispy-colon))

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
  (when (modulep! +dabbrev)
    (setq cape-dabbrev-check-other-buffers t)
    ;; Set up `cape-dabbrev' options.
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
                 ;; minibuffer-setup-hook
                 eshell-mode-hook)
      (defun +corfu-add-cape-dabbrev-h ()
        (add-hook 'completion-at-point-functions #'cape-dabbrev 20 t)))
    (after! dabbrev
      (setq dabbrev-friend-buffer-function #'+corfu-dabbrev-friend-buffer-p
            dabbrev-ignored-buffer-regexps
            '("\\` "
              "\\(?:\\(?:[EG]?\\|GR\\)TAGS\\|e?tags\\|GPATH\\)\\(<[0-9]+>\\)?")
            dabbrev-upcase-means-case-search t)
      (add-to-list 'dabbrev-ignored-buffer-modes 'pdf-view-mode)
      (add-to-list 'dabbrev-ignored-buffer-modes 'doc-view-mode)
      (add-to-list 'dabbrev-ignored-buffer-modes 'tags-table-mode)))

  ;; Make these capfs composable.
  (advice-add #'lsp-completion-at-point :around #'cape-wrap-noninterruptible)
  (advice-add #'lsp-completion-at-point :around #'cape-wrap-nonexclusive)
  (advice-add #'comint-completion-at-point :around #'cape-wrap-nonexclusive)
  (advice-add #'eglot-completion-at-point :around #'cape-wrap-nonexclusive)
  (advice-add #'pcomplete-completions-at-point :around #'cape-wrap-nonexclusive))

(use-package! yasnippet-capf
  :when (modulep! :editor snippets)
  :defer t
  :init
  (add-hook! 'yas-minor-mode-hook
    (defun +corfu-add-yasnippet-capf-h ()
      (add-hook 'completion-at-point-functions #'yasnippet-capf 30 t))))

(use-package! corfu-terminal
  :when (modulep! :os tty)
  :unless (featurep 'tty-child-frames)
  :hook ((corfu-mode . corfu-terminal-mode)))


;;
;;; Extensions

(use-package! corfu-history
  :hook ((corfu-mode . corfu-history-mode))
  :config
  (after! savehist (add-to-list 'savehist-additional-variables 'corfu-history)))

;; (use-package! corfu-popupinfo
;;   :hook ((corfu-mode . corfu-popupinfo-mode))
;;   :config
;;   (setq corfu-popupinfo-delay '(0.5 . 1.0)))

;; If vertico is not enabled, orderless will be installed but not configured.
;; That may break smart separator behavior, so we conditionally configure it.
(use-package! orderless
  :when (not (modulep! :completion vertico))
  :when (modulep! +orderless)
  :config
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles orderless partial-completion)))
        orderless-component-separator #'orderless-escapable-split-on-space))
