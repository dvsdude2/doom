;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Some functionality uses this to identify you
(setq user-full-name "dvsdude"
      user-mail-address "john@doe.com")

;; This is only needed once, near the top of the file
(eval-when-compile
  (require 'use-package))

;; integrates straight with use-package ;;;;
(straight-use-package 'use-package)

;; add packages manually by downloading the repo

;; spray
;; (add-to-list 'load-path "~/builds/manual-packages/spray")

;; kill-file-path
(add-to-list 'load-path "~/builds/manual-packages/kill-file-path")
(require 'kill-file-path)


;; webdriver
;; (add-to-list 'load-path "~/builds/manual-packages/webdriver")

;; Corfu-extensions to load path
(add-to-list 'load-path
               (expand-file-name "~/.emacs.d/.local/straight/repos/corfu/extensions/"
                                 straight-base-dir))

(require 'mixed-pitch)
(mixed-pitch-mode)
(add-hook 'text-mode-hook #'mixed-pitch-mode)

;; fontset ;;;;
(setq doom-font (font-spec :family "Hack Nerd Font" :size 17 :weight 'bold)
;; (setq doom-font (font-spec :family "Iosevka" :size 17 :weight 'heavy)
      doom-variable-pitch-font (font-spec :family "DroidSansMono Nerd Font" :size 17)
      ;; doom-variable-pitch-font (font-spec :family "Iosevka" :size 18)
      ;; doom-unicode-font (font-spec :family "DejaVu Sans Mono")
      doom-unicode-font (font-spec :family "DroidSansMono Nerd Font")
      doom-big-font (font-spec :family "Hack Nerd Font" :size 24 :weight 'bold))

(set-fontset-font t 'emoji
                      '("My New Emoji Font" . "iso10646-1") nil 'prepend)

;; (setq doom-theme 'doom-one)
(setq doom-theme 'doom-Iosvkem)

;; was required for error fix
(require 'compat)
;; hl line mode
(global-hl-line-mode +1)
;; no fringe
(set-fringe-mode 0)
;; declare language
;; (set-language-environment "UTF-8")
;; save last place edited & update bookmarks
(save-place-mode 1)
(setq save-place-file "~/.config/doom/saveplace")
(setq save-place-forget-unreadable-files nil)
(setq bookmark-save-flag t)
;; line number type
(setq display-line-numbers-type 'visual)
;; Only line numbers when coding
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
;; should put  focus in the new window ;;;;
(setq evil-split-window-below t
      evil-vsplit-window-right t)
;; set fancy splash-image
(setq fancy-splash-image "~/.config/doom/splash/doom-color.png")
;; set org-directory. It must be set before org loads
(setq org-directory "~/org/")
;; dictionary server ;;;;
(setq dictionary-server "dict.org")
;; number of lines of overlap in page flip ;;;;
(setq next-screen-context-lines 7)
;; use trash
(setq trash-directory "~/.local/share/Trash/files/")
(setq delete-by-moving-to-trash t)
;; lazy-load agenda-files
(setq org-agenda-inhibit-startup nil)
;; ignore-case
(setq read-file-name-completion-ignore-case t
      read-buffer-completion-ignore-case t
      completion-ignore-case t)
;; set scratch buffer mode
;; (setq doom-scratch-initial-major-mode 'lisp-interaction-mode)
(setq doom-scratch-initial-major-mode 'org-mode)
;; gives isearch total number of matches
(setq-default isearch-lazy-count t)
;; Sensible line breaking
(add-hook 'text-mode-hook 'visual-line-mode)
;; Maximize the window upon startup
(add-to-list 'initial-frame-alist '(fullscreen . maximized))
;;;  "Syntax color, highlighting code colors ;;;;
(add-hook 'prog-mode-hook #'rainbow-mode)
;; automatic chmod +x when you save a file with a #! shebang
(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)

(use-package! dashboard
  :demand t
  :custom
  (dashboard-startup-banner (concat  "~/.config/doom/splash/doom-color.png"))
  (dashboard-banner-logo-title "wecome to dvsdude's e to the mother f*ck*n macs")
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
             (nerd-icons-faicon "nf-fa-calendar" :height 1.0 :face 'font-lock-keyword-face))
       "agenda"
       "agenda all todos"
       (lambda (&rest _) (org-agenda nil "n")))
      (,(and (display-graphic-p)
             (nerd-icons-faicon "nf-fa-book" :height 1.0 :face 'font-lock-keyword-face))
       "journal"
       "journal new entry"
       (lambda (&rest _) (org-journal-new-entry nil)))
      (,(and (display-graphic-p)
             (nerd-icons-mdicon "nf-md-update" :height 1.0 :face 'font-lock-keyword-face))
       "config"
       "open config"
       (lambda (&rest _) (find-file "~/.config/doom/config.org")))
      (,(and (display-graphic-p)
               (nerd-icons-faicon "nf-fa-check" :height 1.0 :face 'font-lock-keyword-face))
         "doom-sync"
         "doom-sync"
         (lambda (&rest _) (async-shell-command (format "doom s"))))
      (,(and (display-graphic-p)
             (nerd-icons-mdicon "nf-md-restore" :height 1.0 :face 'font-lock-keyword-face))
       "restart"
       "restar emacs"
       (lambda (&rest _) (restart-emacs))))))
  :config
       (setq dashboard-items '((recents . 7)
                              (bookmarks . 6)
                               (agenda . 3)))

       (dashboard-setup-startup-hook))
       ;; this is for use with emacsclient
(setq initial-buffer-choice (lambda() (dashboard-refresh-buffer)(get-buffer "*dashboard*")))

;; +doom-dashboard [[file:~/.emacs.d/modules/ui/doom-dashboard/config.el][Doom-dashboard-mod-config]]
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

;; use org web tools to download webpage text content
(require 'org-web-tools)
;; default file for notes
(setq org-default-notes-file (concat org-directory "notes.org"))
;; default diary files
(setq org-agenda-diary-file "~/org/notable-dates.org")
;; (setq diary-file "~/.config/doom/diary")

;; org-keybindings
(map! :after org
      :leader
      (:prefix ("o" . "open")
      :desc "open org config"
      :n "i" (lambda () (interactive) (find-file "~/.config/doom/config.org"))
      ;; jump to notes.org
      :desc "open org notes"
      :n "n" (lambda () (interactive) (find-file "~/org/notes.org"))
      ;; jump to org folder
      :desc "open org folder"
      :n "o" (lambda () (interactive) (find-file "~/org/"))
      ;; jump to org organizer
      :desc "open org organizer"
      :n "0" (lambda () (interactive) (find-file "~/org/organizer.org"))
      ;; jump to org wiki folder
      :desc "open org wiki"
      :n "k" (lambda () (interactive) (find-file "~/org/wiki/"))))

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

;; Org empty buffer creation
    "https://tecosaur.github.io/emacs-config/config.html#org-buffer-creation"
(evil-define-command +evil-buffer-org-new (count file)
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
        (setq-local doom-real-buffer-p t)))))

;; `map': new-org-buffer (space b o)
(map! :leader
      (:prefix "b"
       :desc "New empty Org buffer" "o" #'+evil-buffer-org-new))

;; `map': org insert structural temolate (C-c C-,) menu for adding code blocks
(require 'org-tempo)
(add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))

;; brings up a buffer for capturing
(require 'org-capture)
;; org-capture-templates will be put in org-capture-projects-local
;; older ones left for reference, eval the `add-to-list' function

;; org-refile
(setq org-refile-targets '((nil :maxlevel . 2) (org-agenda-files :maxlevel . 2)))
(setq org-outline-path-complete-in-steps nil)         ;; Refile in a single go
(setq org-refile-use-outline-path 'file)              ;; this also set by vertico

;; pkg tecosaur/org-pandoc-import
;; uses Pandoc to convert selected file types to org
(use-package! org-pandoc-import :after org)
(map! :leader
      (:prefix "i"
       :desc "import to Org buffer" "o" #'org-pandoc-import-as-org  ;; opens in new buf
       :desc "import to org file" "O" #'org-pandoc-import-to-org))  ;; saves to file opens file

(map! :leader
      (:prefix "e"
       :desc "export to Org buffer" "o" #'org-org-export-as-org  ;; opens in new buf
       :desc "export to org file" "O" #'org-org-export-to-org))  ;; saves to file opens file

;; org-src edit window  C-c '
(setq org-src-window-setup 'reorganize-frame)  ;; default

;; set org-id to a timestamp instead of uuid
(setq org-id-method 'ts)
(setq org-attach-id-to-path-function-list
  '(org-attach-id-ts-folder-format
    org-attach-id-uuid-folder-format))

;; this for images
(setq org-return-follows-link t)

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

(setq org-journal-dir "~/org/journal/")
(require 'org-journal)
(setq org-journal-file-type 'yearly)
(setq org-journal-enable-agenda-integration t)
(setq org-journal-carryover-items "")
;; (add-hook 'org-journal-mode-hook #'org-modern-mode)

;; function needed to make an org-capture-template for org-journal
(defun org-journal-find-location ()
  (org-journal-new-entry t)
  (unless (eq org-journal-file-type 'yearly)
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

;; save and exit journal easily
(map! :after org
      :map org-journal-mode-map
      :desc "doom save and kill" "C-c C-c" #'doom/save-and-kill-buffer)

(require 'evil-surround)
(add-hook 'org-mode-hook (lambda ()
                           (push '(?= . ("=" . "=")) evil-surround-pairs-alist)))
(add-hook 'org-mode-hook (lambda ()
                                  (push '(?' . ("`" . "'")) evil-surround-pairs-alist)))

(require 'evil-snipe)
(evil-snipe-mode t)
(evil-snipe-override-mode 1)
(after! evil-snipe
(define-key! evil-snipe-parent-transient-map (kbd "C-;")
  (evilem-create 'evil-snipe-repeat
                 :bind ((evil-snipe-scope 'line)
                        (evil-snipe-enable-highlight)
                        (evil-snipe-enable-incremental-highlight)))))
(push '(?\[ "[[{(]") evil-snipe-aliases)
(add-hook 'magit-mode-hook 'turn-off-evil-snipe-override-mode)

(map! :leader
     (:prefix ("s". "search")
      :desc "avy goto char timer" "a" #'evil-avy-goto-char-timer))

(setq avy-timeout-seconds 1.0) ;;default 0.5
(setq avy-single-candidate-jump t)


;; evil-easymotion "prefix"
(evilem-default-keybindings "C-c a")

(require 'key-chord)
(key-chord-mode 1)
;; Exit insert mode by pressing j and then j quickly
;; Max time delay between two key presses to be considered a key chord
(setq key-chord-two-keys-delay 0.1) ; default 0.1
;; Max time delay between two presses of the same key to be considered a key chord.
;; Should normally be a little longer than;key-chord-two-keys-delay.
(setq key-chord-one-key-delay 0.2) ; default 0.2
(key-chord-define evil-insert-state-map "jj" 'evil-normal-state)
(key-chord-define evil-insert-state-map "dw" 'backward-kill-word)
(key-chord-define evil-insert-state-map ";l" 'org-end-of-line)
(key-chord-define evil-insert-state-map "hh" 'org-beginning-of-line)
(key-chord-define evil-normal-state-map "vv" 'evil-visual-line)
(key-chord-define evil-normal-state-map "cx" 'evilnc-comment-or-uncomment-lines)

;; this should replicate scrolloff in vim ;;
(setq scroll-conservatively 10)
(setq scroll-margin 7)
(setq scroll-preserve-screen-position t)

(use-package corfu
;; Optional customizations
  :custom
  (corfu-cycle t)                ;; Enable cycling for `corfu-next/previous'
  (corfu-auto t)                 ;; Enable auto completion
;; (corfu-separator ?\s)         ;; Orderless field separator
  (corfu-quit-at-boundary t)     ;; Never quit at completion boundary
  (corfu-quit-no-match t)        ;; Never quit, even if there is no match
  (corfu-preselect 'prompt)      ;; Always preselect the prompt
;; (corfu-preview-current nil)   ;; Disable current candidate preview
;; (corfu-preselect-first nil)   ;; Disable candidate preselection
;; (corfu-on-exact-match nil)    ;; Configure handling of exact matches
  (corfu-scroll-margin 3)        ;; Use scroll margin
  ;; (corfu-auto-prefix 4)
;; Use TAB for cycling, default is `corfu-complete'.
  :bind
  (:map corfu-map
        ("TAB" . corfu-next)
        ([tab] . corfu-next)
        ("S-TAB" . corfu-previous)
        ([backtab] . corfu-previous))
;; Recommended: Enable Corfu globally.
  :init
  (global-corfu-mode))
(use-package orderless
  :init
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles . (partial-completion))))))

(use-package emacs
  :init
;; Enable indentation+completion using the TAB key.
  (setq tab-always-indent 'complete))

;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package savehist
  :init
  (savehist-mode))

;; corfu history
(use-package corfu-history
  :after corfu
  :hook (corfu-mode . (lambda ()
                        (corfu-history-mode 1)
                        (savehist-mode 1)
                        (add-to-list 'savehist-additional-variables 'corfu-history))))

(use-package cape
  :after corfu
  ;; Bind dedicated completion commands
  ;; Alternative prefix keys: C-c p, M-p, M-+, ...
  :bind (("C-c c p" . completion-at-point) ;; capf
         ("C-c c t" . complete-tag)        ;; etags
         ("C-c c d" . cape-dabbrev)        ;; or dabbrev-completion
         ("C-c c h" . cape-history)
         ("C-c c f" . cape-file)
         ("C-c c k" . cape-keyword)
         ("C-c c s" . cape-elisp-symbol)
         ("C-c p e" . cape-elisp-block)
         ("C-c c a" . cape-abbrev)
         ("C-c c l" . cape-line)
         ("C-c c w" . cape-dict))
  :init
  ;; Add `completion-at-point-functions', used by `completion-at-point'.
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-elisp-block)
  (add-to-list 'completion-at-point-functions #'cape-history)
  ;; (add-to-list 'completion-at-point-functions #'cape-keyword)
  ;;(add-to-list 'completion-at-point-functions #'cape-tex)
  ;;(add-to-list 'completion-at-point-functions #'cape-sgml)
  ;;(add-to-list 'completion-at-point-functions #'cape-rfc1345)
  ;; (add-to-list 'completion-at-point-functions #'cape-abbrev)
  (add-to-list 'completion-at-point-functions #'cape-dict)
  ;; (add-to-list 'completion-at-point-functions #'cape-elisp-symbol)
  ;;(add-to-list 'completion-at-point-functions #'cape-line)
  )

;; ;; grab this from github wiki page
;;      "https://github.com/minad/corfu/wiki#using-cape-to-tweak-and-combine-capfs"
;; (defun my/ignore-elisp-keywords (cand)
;;   (or (not (keywordp cand))
;;       (eq (char-after (car completion-in-region--data)) ?:)))

;; (defun my/elisp-capf ()
;;   (setq-local completion-at-point-functions
;;               `(,(cape-super-capf
;;                   (cape-capf-predicate
;;                    #'elisp-completion-at-point
;;                    #'my/ignore-elisp-keywords)
;;                   #'cape-dabbrev
;;                   #'cape-file))
;;               cape-dabbrev-min-length 5))
;; (add-hook 'emacs-lisp-mode-hook #'my/elisp-capf)
;;  `todo' check this does not work well getting error now after commented

;; new capf function
(defun dvs/elisp-capf ()
   (setq-local completion-at-point-functions
        (list (cape-capf-super
               #'elisp-completion-at-point
               #'cape-dabbrev
               #'cape-elisp-block
               #'cape-history
               #'cape-keyword
               #'cape-elisp-symbol
               ;; #'cape-file
               ))))
(add-hook 'prog-mode-hook #'dvs/elisp-capf)

(defun dvs/text-capf ()
   (setq-local completion-at-point-functions
        (list (cape-capf-super
               #'cape-file
               #'cape-dict
               #'cape-elisp-block
               #'cape-history))))
(add-hook 'text-mode-hook #'dvs/text-capf)

(map!(:prefix ("M-s i" . "info")
      :desc "consult info emacs"
      :n "e" #'consult-info-emacs
      :desc "consult info org"
      :n "o" #'consult-info-org
      :desc "consult-info-completion"
      :n "c" #'consult-info-completion))

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
  (consult-info "marginalia" "orderless" "embark"
                "corfu" "cape" "tempel"))

(use-package flyspell-correct
  :after flyspell
  :bind (:map flyspell-mode-map ("C-;" . flyspell-correct-wrapper)))

(setq ispell-list-command "--list")
(add-to-list 'ispell-skip-region-alist '("^#+BEGIN_SRC" . "^#+END_SRC"))

;; this should stop the warnings given in reg elisp docs/test files ;;;;
(with-eval-after-load 'flycheck
  (setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc)))

(setq flyspell-persistent-highlight nil)

(setq flyspell-issue-message-flag nil)

(defun flyspell-buffer-after-pdict-save (&rest _)
  (flyspell-buffer))

(advice-add 'flyspell-mode-off :after #'flyspell-buffer-after-pdict-save)

(use-package spray
  ;; :load-path "~/builds/manual-packages/spray"
  :defer t
  :commands spray-mode
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
      :n doom-leader-key nil
      :n "spc" #'spray-start/stop
      :n "<return>" #'spray-start/stop
      :n "f" #'spray-faster
      :n "s" #'spray-slower
      :n "t" #'spray-time
      :n "<right>" #'spray-forward-word
      :n "h" #'spray-forward-word
      :n "<left>" #'spray-backward-word
      :n "l" #'spray-backward-word
      :n [remap keyboard-quit] 'spray-quit
      :n "q" #'spray-quit)
;; "Minor modes to toggle off when in spray mode."
(setq spray-unsupported-minor-modes
  '(beacon-mode buffer-face-mode smartparens-mode
		     column-number-mode line-number-mode ))
(setq cursor-in-non-selected-windows nil)

;; Show the current location and put it into the kill ring ;;;;
(defun my/kill-current-path (no-line-number)
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

;; copy current path to kill ring
(map! :leader
     (:prefix ("k" . "kill")
      :desc "copy current path to kill-ring" "l" #'my/kill-current-path))

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

;; function to get back to last place edited
(defun mu-back-to-last-edit ()
  ;; "Jump back to the last change in the current buffer."
  (interactive)
  (ignore-errors
    (let ((inhibit-message t))
      (undo-only)
      (undo-redo))))

;; this keeps the workspace-bar visable
(after! persp-mode
  (defun display-workspaces-in-minibuffer ()
    (with-current-buffer " *Minibuf-0*"
      (erase-buffer)
      (insert (+workspace--tabline))))
  (run-with-idle-timer 1 t #'display-workspaces-in-minibuffer)
  (+workspace/display))

;; center scroll minor mode
(define-minor-mode prot/scroll-center-cursor-mode
  "Toggle centred cursor scrolling behavior"
  :init-value nil
  :lighter " S="
  :global nil
  (if prot/scroll-center-cursor-mode
      (setq-local scroll-margin (* (frame-height) 2)
                  scroll-conservatively 0
                  maximum-scroll-margin 0.5)
    (dolist (local '(scroll-preserve-screen-position
                     scroll-conservatively
                     maximum-scroll-margin
                     scroll-margin))
      (kill-local-variable `,local))))

;; beacon highlight cursor
(beacon-mode t)

;; plantuml jar configuration
(setq plantuml-jar-path "/usr/share/java/plantuml/plantuml.jar")
  ;; Enable plantuml-mode for PlantUML files
(add-to-list 'auto-mode-alist '("\\.plantuml\\'" . plantuml-mode))
  ;; Enable exporting
(org-babel-do-load-languages 'org-babel-load-languages '((plantuml . t)))

;; declutter
;; (require 'declutter)
(use-package! declutter
  :defer t)
(setq declutter-engine-path "/usr/bin/rdrview")
(setq declutter-engine 'rdrview)  ; rdrview will get and render html
;; (setq declutter-engine 'eww)      ; eww will get and render html

;; addes new lines without RET
(after! org
  (setq next-line-add-newlines t))

(use-package org-rich-yank
  :demand t
  :bind (:map org-mode-map
              ("C-M-y" . org-rich-yank)))

;; read url's readable content to org buffer
(map! :leader
     (:prefix ("e" . "export")
      :desc "url's readable-content to org" "u" #'org-web-tools-read-url-as-org))
;; list-processes
(map! :leader
     (:prefix ("l" . "lang/list")
      :desc "center scrolling" "p" #'list-processes))
;; centered-cursor-mode
(map! :leader
     (:prefix ("t" . "toggle")
      :desc "center scrolling" "C" #'prot/scroll-center-cursor-mode))
;; adds selected text to chosen buffer
(map! :leader
    (:prefix ("i" . "insert")
     :desc "append to buffer" "t" #'append-to-buffer))
;; adds entire buffer to chosen buffer
(map! :leader
    (:prefix ("i" . "insert")
     :desc "insert buffer at point" "b" #'insert-buffer))
;; dictioary-lookup-definition better than spc s t
(map! "M-#" #'dictionary-lookup-definition)
(map! "<f7>" #'dictionary-lookup-definition)
;; fetches selected text and gives you a list of synonyms to replace it with
(map! "M-&" #'powerthesaurus-lookup-word-dwim)
(map! "<f8>" #'powerthesaurus-lookup-word-dwim)
;; close other window ;;;;
(map! "C-1" #'delete-other-windows)
;; switch other window
(map! "C-2" #'switch-to-buffer-other-window)
;; ;; start modes
;; (map! (:prefix ("C-c m" . "mode command")
;;       "o" #'org-mode
;;       "e" #'emacs-lisp-mode
;;       "f" #'fundamental-mode))
;; Make `v$' not include the newline character ;;;;
(general-define-key
:states '(visual state)
"$" '(lambda ()
        (interactive)
        (evil-end-of-line)))

;; (setq which-key-popup-type 'minibuffer)
;; (setq which-key-popup-type 'side-window)
;; (setq which-key-popup-type 'frame)

;; (which-key-setup-minibuffer)
(which-key-setup-side-window-bottom)
;;(which-key-setup-side-window-right)
;;(which-key-setup-side-window-right-bottom)
;; (setq which-key-use-C-h-commands nil)
(setq which-key-idle-delay 1.5)

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
     (:prefix ("t" . "toggle")
      :desc "toggle transparency" "T" #'toggle-transparency))

(add-hook 'dired-mode-hook
          'display-line-numbers-mode)
(add-hook 'dired-mode-hook
          'dired-hide-details-mode)

(use-package! dired-preview
  :after dired)
(add-hook 'dired-mode-hook #'dired-preview-mode)


(map! :leader
     (:prefix ("t". "toggle")
      :desc "dired preview mode" "p" #'dired-preview-mode))

(setq dired-dwim-target t)


(use-package! treemacs-icons-dired
  :defer t
  :after dired)

(after! org
(use-package org-mpv-notes
  :defer t))
    ;; "Org minor mode for Note taking alongside audio and video.
    ;; Uses mpv.el to control mpv process"
;; mpv.el ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun org-mpv-complete-link (&optional arg)
  (replace-regexp-in-string
   "file:" "mpv:"
   (org-link-complete-file arg)
   t t))
(org-link-set-parameters "mpv"
  :follow #'mpv-play :complete #'org-mpv-complete-link)
(add-hook 'org-open-at-point-functions #'mpv-seek-to-position-at-point)

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
       :desc "play file with mpv" "f" #'mpv-play))

;; use mpv to open video url ;;;;
(map! :leader
      (:prefix ("v" . "video")
       :desc "play link with mpv" "l" #'mpv-play-url))
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

;;;; mpv-play-url
;; https://gist.github.com/bsless/19ca4a37eee828b1b62c84971181f506#file-yt-mpv-el
;;;###autoload
(defun c1/mpv-play-url (&optional url &rest _args)
  ;; "Start mpv for URL."
  (interactive"sURL: ")
  (mpv-start url))

;; version 2 from github (worked)
;; (defun mpv-play-url (url &rest args)
;;   ;; "start mpv process"
;;   (interactive)
;;   (start-process "mpv" "*mpv*" "mpv" url))

;; https://mbork.pl/2022-10-24_Playing_videos_from_the_last_position_in_mpv
;; (defun dvs/browse-url-with-mpv (url)
;;   "Open URL using mpv."
;;   (mpv-start url "--fs --osd-level=2"))


(setq browse-url-handlers
    '(("\\.\\(gifv?\\|avi\\|AVI\\|mp[4g]\\|MP4\\|MP3\\|webm\\)$" . c1/mpv-play-url)
     ;; ("^https?://\\(www\\.youtube\\.com\\|youtu\\.be\\|odysee\\.com\\|rumble\\.com\\)/" . c1/mpv-play-url)
     ("^https?://\\(www\\.youtube\\.com\\|youtu\\.be\\)/" . c1/mpv-play-url)
     ("^https?://\\(odysee\\.com\\|rumble\\.com\\)/" . c1/mpv-play-url)
     ("^https?://\\(off-guardian.org\\|\\.substack\\.com\\|tomluongo\\.me\\)/" . dvs-eww)
     ("." . browse-url-xdg-open)))

(require 'ytdl)

(setq ytdl-music-folder (expand-file-name "~/music")
      ytdl-video-folder (expand-file-name "~/videos")
      ytdl-always-query-default-filename 'never)

(ytdl-add-field-in-download-type-list "podcasts"
                                       "p"
                                       (expand-file-name "~/podcasts")
                                       nil)

(setq deft-extensions '("md" "txt" "tex" "org"))
(setq deft-directory "~/org/")
(setq deft-recursive t)
(setq deft-use-filename-as-title t)
(setq deft-strip-summary-regexp
      (concat "\\("
          "[\n\t]" ;; blank
          "\\|^#\\+[[:alpha:]_]+:.*$" ;; org-mode metadata
          "\\|^:PROPERTIES:\n\\(.+\n\\)+:END:\n"
          "\\)"))

;; (require 'elfeed)
;; (require 'elfeed-org)
;; (elfeed-org)
(setq rmh-elfeed-org-files (list "~/.config/doom/elfeed-feeds.org"))

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

;; Declutter-it ;;;;
(defun declutter-it (&optional use-generic-p)
  (interactive "P")
  (let ((entries (elfeed-search-selected)))
    (cl-loop for entry in entries
             do (elfeed-untag entry 'unread)
             when (elfeed-entry-link entry)
             do (declutter it))
    (mapc #'elfeed-search-update-entry entries)
    (unless (use-region-p) (forward-line))))

;; youtube-sub-extractor ;;;;
(defun yt-sub-ex (&optional use-generic-p)
  (interactive "P")
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


(defun elfeed-expose (function &rest args)
  "Return an interactive version of FUNCTION, 'exposing' it to the user."
  (lambda () (interactive) (apply function args)))
;; define tag "star" ;;;; FIXME not sure why this throws an error
;; void fuction elfeed-expose was the error
(defalias 'elfeed-toggle-star
       (elfeed-expose #'elfeed-search-toggle-all 'star))

;; keymap ;;
(map! :leader
     (:prefix ("o". "open")
      :desc "open elfeed" "e" #'elfeed))

(map! :after elfeed
      :leader
      (:prefix "c"
      :desc "rss copy link"
      :n "l" #'+rss/copy-link))
(map! :after elfeed
      :map elfeed-search-mode-map
      :n [remap save-buffer] 'elfeed-tube-save
      :n "8" #'elfeed-toggle-star
      :n "T" #'my/elfeed-reddit-show-commments
      :n "d" #'elfeed-youtube-dl
      :n "Y" #'yt-sub-ex
      :n "v" #'elfeed-view-mpv
      :n "e" #'elfeed-eww-open
      :n "R" #'elfeed-summary
      :n "C-c d c" #'declutter-it
      :n "F" #'elfeed-tube-fetch)
(map! :after elfeed
      :map elfeed-show-mode-map
      :n [remap save-buffer] 'elfeed-tube-save
      :n "d" #'yt-dl-it
      :n "m" #'elfeed-v-mpv
      :n "x" #'elfeed-kill-buffer
      :n "F" #'elfeed-tube-fetch
      :n "e" #'elfeed-eww-open
      :n "C-c C-f" #'elfeed-tube-mpv-follow-mode
      :n "C-c C-w" #'elfeed-tube-mpv-were)

;;;; set default filter ;;;;
;; (setq-default elfeed-search-filter "@1-week-ago +unread ")
(setq-default elfeed-search-filter "@4-week-ago ")

(use-package elfeed-tube
  :after elfeed
  :demand t
  :config
  (elfeed-tube-setup))
(use-package elfeed-tube-mpv
  :after elfeed)

(use-package! elfeed-summary
  :defer t
  :after elfeed)
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
        (group (:title . "Substack")
               (:elements
                (query . sub))
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
                (query . corbet))
               (:hide t))
        (group (:title . "stared")
               (:elements
                (search
               (:filter . "+star")
               (:title . "")))
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
(setq elfeed-summary-other-window t)

(map! :map elfeed-summary-mode-map
      :desc "unjam elfeed"
      :n "m" #'elfeed-unjam)

;; found in manual for eww w/spc h R ;;;;
;; (setq eww-retrieve-command
;;      '("brave" "--headless" "--dump-dom"))

;; open links in eww
(defun dvs-eww (url &optional arg)
    "Pass URL to appropriate client"
  (interactive
   (list (prot-eww--interactive-arg "URL: ")
         current-prefix-arg))
  (let ((url-parsed (url-generic-parse-url url)))
    (pcase (url-type url-parsed)
            (_ (eww url arg)))))

(defvar prot-eww--occur-feed-regexp
  (concat "\\(rss\\|atom\\)\\+xml.\\(.\\|\n\\)"
          ".*href=[\"']\\(.*?\\)[\"']")
    "Regular expression to match web feeds in HTML source.")

;;;###autoload
(defun prot-eww-find-feed ()
    "Produce buffer with RSS/Atom links from XML source."
  (interactive)
  (let* ((url (or (plist-get eww-data :start)
                  (plist-get eww-data :contents)
                  (plist-get eww-data :home)
                  (plist-get eww-data :url)))
         (title (or (plist-get eww-data :title) url))
         (source (plist-get eww-data :source))
         (buf-name (format "*feeds: %s # eww*" title)))
    (with-temp-buffer
      (insert source)
      (occur-1 prot-eww--occur-feed-regexp "\\3" (list (current-buffer)) buf-name))
    ;; Handle relative URLs, so that we get an absolute URL out of them.
    ;; Findings like "rss.xml" are not particularly helpful.
    ;;
    ;; NOTE 2021-03-31: the base-url heuristic may not always be
    ;; correct, though it has worked in all cases I have tested it on.
    (when (get-buffer buf-name)
      (with-current-buffer (get-buffer buf-name)
        (let ((inhibit-read-only t)
              (base-url (replace-regexp-in-string "\\(.*/\\)[^/]+\\'" "\\1" url)))
          (goto-char (point-min))
          (unless (re-search-forward prot-common-url-regexp nil t)
            (re-search-forward ".*")
            (replace-match (concat base-url "\\&"))))))))

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

(use-package! osm
  :defer t
  :bind ("C-c m" . osm-prefix-map) ;; Alternative: `osm-home'
  :custom
  ;; Take a look at the customization group `osm' for more options.
  (osm-server 'default) ;; Configure the tile server
  (osm-copyright t)     ;; Display the copyright information
  :init
  ;; Load Org link support
  (with-eval-after-load 'org
    (require 'osm-ol)))

(use-package! dwim-shell-command
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

(use-package! vterm
  :defer t
  :custom
(vterm-module-cmake-args "-DUSE_SYSTEM_LIBVTERM=yes")
(vterm-always-compile-module t))

;; vterm-toggle ;;;;
(map! "<f2>" #'vterm-toggle
      "C-<f2>" #'vterm-toggle-cd)

(use-package! engine-mode
  :defer t
  :config
  (engine-mode t))
(defengine nitter
"https://nitter.net/search?f=tweets"
  :keybinding "n")
(defengine gist
  "https://gist.github.com/search?ref=simplesearch&q=%s"
  :keybinding "i")
(defengine github
  "https://github.com/search?ref=simplesearch&q=%s"
  :keybinding "h")
(defengine presearch
  "https://presearch.com/search?q=%s"
  :keybinding "p")
(defengine google
  "http://www.google.com/search?ie=utf-8&oe=utf-8&q=%s"
  :keybinding "g")
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

(use-package! youtube-sub-extractor
  :defer t
  :commands (youtube-sub-extractor-extract-subs)
  :config
  (map! :map youtube-sub-extractor-subtitles-mode-map
      :desc "copy timestamp URL" :n "RET" #'youtube-sub-extractor-copy-ts-link
      :desc "browse at timestamp" :n "C-c C-o" #'youtube-sub-extractor-browse-ts-link))

(setq youtube-sub-extractor-timestamps 'left-side-text)

(require 'thingatpt)
(defun youtube-sub-extractor-extract-subs-at-point ()
   "extract subtitles from a youtube link at point"
(interactive)
(youtube-sub-extractor-extract-subs (thing-at-point-url-at-point)))

(map! :leader
      :prefix "v"
      :desc "YouTube subtitles" "E" #'youtube-sub-extractor-extract-subs)

(map! :leader
      :prefix "v"
      :desc "YouTube subtitles at point" "e" #'youtube-sub-extractor-extract-subs-at-point)

(use-package! markdown-mode
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

(use-package! languagetool
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

;; (require 'denote)
(use-package! denote
  :defer t)
(setq denote-directory (expand-file-name "~/org/denote/"))
(setq denote-known-keywords '("emacs" "package" "info" "perman"))
(setq denote-infer-keywords t)
(setq denote-sort-keywords t)
;; (setq denote-file-type org) ; Org is the default, set others here
;; (setq denote-prompts '(title keywords))
;; (setq denote-excluded-directories-regexp nil)
;; (setq denote-excluded-keywords-regexp nil)
;; ;; Pick dates, where relevant, with Org's advanced interface:
;; (setq denote-date-prompt-use-org-read-date t)


;; ;; Read this manual for how to specify `denote-templates'.  We do not
;; ;; include an example here to avoid potential confusion.


;; ;; We do not allow multi-word keywords by default.  The author's
;; ;; personal preference is for single-word keywords for a more rigid
;; ;; workflow.
;; (setq denote-allow-multi-word-keywords t)

;; (setq denote-date-format nil) ; read doc string

;; ;; By default, we do not show the context of links.  We just display
;; ;; file names.  This provides a more informative view.
;; (setq denote-backlinks-show-context t)

;; ;; Also see `denote-link-backlinks-display-buffer-action' which is a bit
;; ;; advanced.

;; ;; If you use Markdown or plain text files (Org renders links as buttons
;; ;; right away)
;; (add-hook 'find-file-hook #'denote-link-buttonize-buffer)

;; map! "spc d n" #'denote
(map! :leader
      :prefix "d"
      :desc "denote"
      :n "n" #'denote)

(use-package! yeetube
  :after mpv
  :init
(setq yeetube-download-directory "~/Videos"))

(map! :leader
     (:prefix ("s". "search")
      :desc "search yeetube" "y" #'yeetube-search))

;; TODO check to see if this works or not
;; (require 'logos)
(use-package! logos
  :defer t
  :init
;; If you want to use outlines instead of page breaks (the ^L):
(setq logos-outlines-are-pages t)
;; This is the default value for the outlines:
(setq logos-outline-regexp-alist
      `((emacs-lisp-mode . "^;;;+ ")
        (org-mode . "^\\*+ +")
        (markdown-mode . "^\\#+ +")))
;; These apply when `logos-focus-mode' is enabled.  Their value is
;; buffer-local.
(setq-default logos-hide-cursor nil
              logos-hide-mode-line t
              logos-hide-buffer-boundaries t
              logos-hide-fringe t
              logos-variable-pitch nil
              logos-buffer-read-only t
              logos-scroll-lock nil
              logos-olivetti t))

;; Also check this manual for `logos-focus-mode-hook'.  It lets you
;; extend `logos-focus-mode'.

(let ((map global-map))
  (define-key map [remap narrow-to-region] #'logos-narrow-dwim)
  (define-key map [remap forward-page] #'logos-forward-page-dwim)
  (define-key map [remap backward-page] #'logos-backward-page-dwim)
  (define-key map (kbd "<f9>") #'logos-focus-mode))

;; Also consider adding keys to `logos-focus-mode-map'.  They will take
;; effect when `logos-focus-mode' is enabled.

(use-package! olivetti
  :defer t
  :init
(setq olivetti-body-width 0.7
      olivetti-minimum-body-width 80
      olivetti-recall-visual-line-mode-entry-state t))

(setq shr-max-width fill-column)

(use-package! monkeytype
  :defer t)
(defun my/monkeytype-mode-hook ()
    "Hooks for monkeytype-mode."
  (evil-escape-mode -1)
  (writeroom-mode +1)
  (flyspell-mode -0)
  (text-scale-set 4)
  (corfu-mode -0)
  (evil-insert -1))
(add-hook 'monkeytype-mode-hook #'my/monkeytype-mode-hook)
(setq monkeytype-dowcase -0)

;; speed-type typing exercise
;; Executing M-x speed-type-text will start the typing exercise
(use-package! speed-type
  :defer t)

(use-package! browser-hist
  :defer t
  :init
  (require 'embark) ; load Embark before the command (if you're using it)
  :config
  (setq browser-hist-default-browser 'brave)
  :commands (browser-hist-search))
(setq browser-hist-default-browser 'brave)
(setq browser-hist-db-paths
        '((brave . "~/.config/BraveSoftware/Brave-Browser/Default/History")))

(map! :leader
      :prefix "s"
      :desc "search browser history"
      :n "h" #'browser-hist-search)

;;(defun view-text-file-as-info-manual ()
;;  (interactive)
;;  (require 'ox-texinfo)
;;  (let ((org-export-with-broken-links 'mark))
;;    (pcase (file-name-extension (buffer-file-name))
;;      (`"info"
;;       (info (buffer-file-name)))
;;      (`"texi"
;;       (info (org-texinfo-compile (buffer-file-name))))
;;      (`"org"
;;       (info (org-texinfo-export-to-info)))
;;      (`"md"
;;       (let ((org-file-name (concat (file-name-sans-extension (buffer-file-name)) ".org")))
;;         (apply #'call-process "pandoc" nil standard-output nil
;;                `("-f" "markdown"
;;                  "-t" "org"
;;                  "-o" , org-file-name
;;                  , (buffer-file-name)))
;;         (with-current-buffer (find-file-noselect org-file-name)
;;           (info (org-texinfo-export-to-info)))))
;;      (_ (user-error "Don't know how to convert `%s' to an `info' file"
;;                     (file-name-extension (buffer-file-name)))))))

;;(global-set-key (kbd "C-x x v") 'view-text-file-as-info-manual)
