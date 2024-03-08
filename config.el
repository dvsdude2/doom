;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Some functionality uses this to identify you
(setq user-full-name "dvsdude"
      user-mail-address "john@doe.com")

;; add packages manually by downloading the repo

;; spray
;; (add-to-list 'load-path "~/builds/manual-packages/spray")

;; Corfu-extensions to load path
(add-to-list 'load-path
               (expand-file-name "~/.config/emacs/.local/straight/repos/corfu/extensions"))

;; (load "~/.config/doom/myrepo/+config/+config.el")

;; fontset ;;;;
(setq doom-font (font-spec :family "Hack Nerd Font" :size 17 :weight 'bold)
;; (setq doom-font (font-spec :family "Iosevka" :size 17 :weight 'heavy)
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
;; this should help with paging in which-key
(setq which-key-use-C-h-commands t)
;; save last place edited & update bookmarks
(save-place-mode 1)
(setq save-place-file "~/.config/doom/saveplace")
(setq save-place-forget-unreadable-files nil)
(setq bookmark-save-flag t)
;; line number type
;; (setq display-line-numbers-type 'visual)
(setq display-line-numbers-type nil)
;; should put  focus in the new window ;;;;
(setq evil-split-window-below t
      evil-vsplit-window-right t)
;; set fancy splash-image
(setq fancy-splash-image "~/.config/doom/splash/doom-color.png")
;; set org-directory. It must be set before org loads
(setq org-directory "~/org/")
;; number of lines of overlap in page flip ;;;;
(setq next-screen-context-lines 7)
;; use trash
(setq trash-directory "~/.local/share/Trash/files/")
(setq delete-by-moving-to-trash t)
;; lazy-load agenda-files
(setq org-agenda-inhibit-startup t)
;; ignore-case
(setq read-file-name-completion-ignore-case t
      read-buffer-completion-ignore-case t
      completion-ignore-case t)
;; set scratch buffer mode
(setq doom-scratch-initial-major-mode 'org-mode)
;; gives isearch total number of matches
(setq-default isearch-lazy-count t)
;; move mouse out of the way
(mouse-avoidance-mode t)
(setq mouse-avoidance-mode "banish")
;; dictionary server ;;;;
(setq dictionary-server "dict.org")
;; Maximize the window upon startup
(add-to-list 'initial-frame-alist '(fullscreen . maximized))
;;;  "Syntax color, highlighting code colors ;;;;
(add-hook 'prog-mode-hook #'rainbow-mode)
;; Sensible line breaking
(add-hook 'text-mode-hook 'visual-line-mode)
;; automatic chmod +x when you save a file with a #! shebang
(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)
;; get ediff to unfold everthing before
(with-eval-after-load 'outline
   (add-hook 'ediff-prepare-buffer-hook #'org-fold-show-all))

(when (display-graphic-p)
  (global-unset-key (kbd "C-z"))
  (global-unset-key (kbd "C-x C-z")))

(use-package dashboard
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
             (nerd-icons-faicon "nf-fa-book" :height 1.0 :face 'font-lock-keyword-face))
       "journal"
       "journal new entry"
       (lambda (&rest _) (org-journal-new-entry nil)))
      (,(and (display-graphic-p)
             (nerd-icons-codicon "nf-cod-settings" :height 1.0 :face 'font-lock-keyword-face))
       "config"
       "open config"
       ;;(lambda (&rest _) (+workspace/load "config")))
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
       (setq dashboard-items '((recents . 7)
                              (bookmarks . 6)
                               (agenda . 3)))

       (dashboard-setup-startup-hook))
       ;; this is for use with emacsclient
(setq initial-buffer-choice (lambda() (dashboard-refresh-buffer)(get-buffer "*dashboard*")))

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

;; default file for notes
(setq org-default-notes-file (concat org-directory "notes.org"))
;; default diary files
(setq org-agenda-diary-file "~/org/notable-dates.org")
;; (setq diary-file "~/.config/doom/diary")

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
;; https://tecosaur.github.io/emacs-config/config.html#org-buffer-creation
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
;; new-org-buffer (space b o)
(map! :leader
      :prefix "b"
      :desc "New empty Org buffer" "o" #'+evil-buffer-org-new)

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

;; this for images
;; NOTE believe this doesnt work with evil, needs looking into
;; (setq org-return-follows-link t)

;; start a header next line not jumping subheaders
;; NOTE this will need an after doom has already set this
;; (setq org-insert-heading-respect-content nil)

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
(after! org
  (use-package! org-capture))
;; org-capture-templates will be put in org-capture-projects-local
;; older ones left for reference, eval the `add-to-list' function
(after! org
(setq org-capture-templates
   '(("t" "Personal todo" entry
      (file+headline +org-capture-todo-file "Inbox")
      "** TODO %?\n%i\n%a" :prepend t)
     ("z" "organizer" entry
      (file+headline "~/org/organizer.org" "refile stuff")
      "** NEW %?\n  %i\n  " :prepend t)
     ("y" "tilt" entry
      (file+headline "~/org/wiki/tilt-doom.org" "TILT")
      "** NEW %?\n  %i\n  " :prepend t)
     ("s" "notable dates" plain #'org-journal-date-location
      "** TODO %?\n <%(princ org-journal--date-location-scheduled-time)>\n" :jump-to-captured t)
     ("j" "Journal entry" plain #'org-journal-find-location
      "** %(format-time-string org-journal-time-format)%?" :prepend t)
     ("k" "keybindings" entry
      (file+headline "~/org/wiki/my-keybinding-list.org" "new ones")
      "** NEW %?\n  %i\n  " :prepend t)
     ("x" "webmarks" entry
      (file+headline "~/org/webmarks.org" "bookmarks")
      "- %(org-cliplink-capture)\n" :prepend t)
     ("l" "check out later" entry
      (file+headline "todo.org" "Check out later")
      "** IDEA %?\n%i\n%a" :prepend t)
     ("n" "Personal notes" entry
      (file+headline +org-capture-notes-file "Inbox")
      "*  %?\n%i\n%a" :prepend t)
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
     ("ot" "Project todo" entry #'+org-capture-central-project-todo-file "* TODO %?\n %i\n %a" :heading "Tasks" :prepend nil)
     ("on" "Project notes" entry #'+org-capture-central-project-notes-file "* %U %?\n %i\n %a" :prepend t :heading "Notes")
     ("oc" "Project changelog" entry #'+org-capture-central-project-changelog-file "* %U %?\n %i\n %a" :prepend t :heading "Changelog"))))

(use-package! org-journal
  :defer t
  :init
  ;; HACK `org-journal' adds a `magic-mode-alist' entry for detecting journal
  ;;      files, but this causes us lazy loaders a big problem: an unacceptable
  ;;      delay on the first file the user opens, because calling the autoloaded
  ;;      `org-journal-is-journal' pulls all of `org' with it. So, we replace it
  ;;      with our own, extra layer of heuristics.
  (add-to-list 'magic-mode-alist '(+org-journal-p . org-journal-mode))

  (defun +org-journal-p ()
    "Wrapper around `org-journal-is-journal' to lazy load `org-journal'."
    (when-let (buffer-file-name (buffer-file-name (buffer-base-buffer)))
      (if (or (featurep 'org-journal)
              (and (file-in-directory-p
                    buffer-file-name (expand-file-name org-journal-dir org-directory))
                   (require 'org-journal nil t)))
          (org-journal-is-journal))))

  ;; `org-journal-dir' defaults to "~/Documents/journal/", which is an odd
  ;; default, so we change it to {org-directory}/journal (we expand it after
  ;; org-journal is loaded).
  (setq org-journal-dir "journal/"
        org-journal-cache-file (concat doom-cache-dir "org-journal"))
;;   (setq org-journal-file-type 'yearly)

  :config
  (setq org-journal-file-type 'daily)
  (setq org-journal-date-format "%A, %d %B %Y")
  ;; Remove the orginal journal file detector and rely on `+org-journal-p'
  ;; instead, to avoid loading org-journal until the last possible moment.
  (setq magic-mode-alist (assq-delete-all 'org-journal-is-journal magic-mode-alist))

  (setq org-journal-dir (expand-file-name org-journal-dir org-directory)
        org-journal-find-file #'find-file)

  (setq org-journal-enable-agenda-integration t)
  ;; Setup carryover to include all configured TODO states. We cannot carry over
  (setq org-journal-carryover-items  "TODO=\"TODO\"|TODO=\"PROJ\"|TODO=\"STRT\"|TODO=\"WAIT\"|TODO=\"HOLD\"")

  (add-hook 'org-journal-mode-hook #'my/org-journal-mode-hook)
  (map! (:map org-journal-mode-map
         :n "]f"  #'org-journal-next-entry
         :n "[f"  #'org-journal-previous-entry
         :n "C-n" #'org-journal-next-entry
         :n "C-p" #'org-journal-previous-entry)
        (:map org-journal-search-mode-map
         "C-n" #'org-journal-search-next
         "C-p" #'org-journal-search-previous)
        :localleader
        (:map org-journal-mode-map
         (:prefix "j"
          "c" #'org-journal-new-entry
          "d" #'org-journal-new-date-entry
          "n" #'org-journal-next-entry
          "p" #'org-journal-previous-entry)
         (:prefix "s"
          "s" #'org-journal-search
          "f" #'org-journal-search-forever
          "F" #'org-journal-search-future
          "w" #'org-journal-search-calendar-week
          "m" #'org-journal-search-calendar-month
          "y" #'org-journal-search-calendar-year))
        (:map org-journal-search-mode-map
         "n" #'org-journal-search-next
         "p" #'org-journal-search-prev)))

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

;; save and exit journal easily
(map! :after org
      :map org-journal-mode-map
      :desc "doom save and kill" "C-c C-c" #'doom/save-and-kill-buffer)

;; this is grabbed from Dooms config
(use-package! evil-surround
  :commands (global-evil-surround-mode
             evil-surround-edit
             evil-Surround-edit
             evil-surround-region)
  :config (global-evil-surround-mode 1))
(add-hook 'org-mode-hook (lambda ()
                           (push '(?= . ("=" . "=")) evil-surround-pairs-alist)))

(evil-embrace-disable-evil-surround-integration)

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

(map! :leader
      :prefix ("s" . "search")
      :desc "avy goto char timer" "a" #'evil-avy-goto-char-timer)

(setq avy-timeout-seconds 1.0) ;;default 0.5
(setq avy-single-candidate-jump t)

;; evil-easymotion "prefix"
;; (evilem-default-keybindings "C-c a")
(evilem-default-keybindings "SPC")

;; this should replicate scrolloff in vim ;;
(setq scroll-margin 7)
(setq scroll-preserve-screen-position t)

(use-package corfu
  ;; Optional customizations
  :custom
  (corfu-cycle t)                ;; Enable cycling for `corfu-next/previous'
  (corfu-auto t)                 ;; Enable auto completion
  ;; (corfu-separator ?\s)          ;; Orderless field separator
  ;; (corfu-quit-at-boundary nil)   ;; Never quit at completion boundary
  ;; (corfu-quit-no-match nil)      ;; Never quit, even if there is no match
  (corfu-preselect 'prompt)      ;; Preselect the prompt
  ;; (corfu-on-exact-match nil)     ;; Configure handling of exact matches
  ;; (corfu-scroll-margin 5)        ;; Use scroll margin
  ;; (corfu-auto-prefix 4)

  ;; Enable Corfu only for certain modes.
  ;; :hook ((prog-mode . corfu-mode)
  ;;        (shell-mode . corfu-mode)
  ;;        (eshell-mode . corfu-mode))

  :bind
  (:map corfu-map
        ("TAB" . corfu-next)
        ([tab] . corfu-next)
        ("S-TAB" . corfu-previous)
        ([backtab] . corfu-previous)
        ("RET" . nil))
  :init
  (global-corfu-mode))
;; Enable auto completion and configure quitting
(use-package orderless
  :init
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles . (partial-completion))))))

(use-package emacs
  :init
  ;; TAB cycle if there are only few candidates
  (setq completion-cycle-threshold 3)
;; Enable indentation+completion using the TAB key.
  (setq tab-always-indent 'complete))

;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package! savehist
  :defer t
  :init
  (savehist-mode))

;; corfu history
(after! corfu
(use-package corfu-history
  :load-path ".local/straight/repos/corfu/extensions"
  :hook (corfu-mode . (lambda ()
                        (corfu-history-mode 1)
                        (savehist-mode 1)
                        (add-to-list 'savehist-additional-variables 'corfu-history)))))

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
         ("C-c c b" . cape-elisp-block)
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
  ;; (add-to-list 'completion-at-point-functions #'cape-abbrev)
  (add-to-list 'completion-at-point-functions #'cape-dict)
  ;; (add-to-list 'completion-at-point-functions #'cape-elisp-symbol)
  ;;(add-to-list 'completion-at-point-functions #'cape-line)
  )

;; ;; grab this from github wiki page
;;      "https://github.com/minad/corfu/wiki#using-cape-to-tweak-and-combine-capfs"
;; (defun my/ignore-elisp-keywords (cand)
;;     "drops keywords from list, unless the text starts with a `:’."
;;   (or (not (keywordp cand))
;;       (eq (char-after (car completion-in-region--data)) ?:)))

;; (defun my/setup-elisp ()
;;   (setq-local completion-at-point-functions
;;               `(,(cape-super-capf
;;                   (cape-capf-predicate
;;                    #'elisp-completion-at-point
;;                    #'my/ignore-elisp-keywords)
;;                   #'cape-dabbrev)
;;                 cape-file)  ;; this is a backup
;;               cape-dabbrev-min-length 5))
;; (add-hook 'emacs-lisp-mode-hook #'my/setup-elisp)

;; NOTE check to see what difference after shutting this down
;; new capf function
;; (defun dvs/elisp-capf ()
;;    (setq-local completion-at-point-functions
;;         (list (cape-capf-super
;;                #'elisp-completion-at-point
;;                #'cape-dabbrev
;;                #'cape-history
;;                #'cape-keyword
;;                #'cape-elisp-symbol
;;                ;; #'cape-file
;;                ))))
;; (add-hook 'prog-mode-hook #'dvs/elisp-capf)

;; (defun dvs/text-capf ()
;;    (setq-local completion-at-point-functions
;;         (list (cape-capf-super
;;                #'cape-dict
;;                #'cape-dabbrev
;;                #'cape-history
;;                #'cape-elisp-block))))
;; (add-hook 'text-mode-hook #'dvs/text-capf)

;; Example configuration for Consult
;; (use-package consult
;;   ;; Replace bindings. Lazily loaded due by `use-package'.
;;   :bind (;; C-c bindings in `mode-specific-map'
;;          ("C-c M-x" . consult-mode-command)
;;          ("C-c h" . consult-history)
;;          ("C-c k" . consult-kmacro)
;;          ("C-c m" . consult-man)
;;          ("C-c i" . consult-info)
;;          ([remap Info-search] . consult-info)
;;          ;; C-x bindings in `ctl-x-map'
;;          ("C-x M-:" . consult-complex-command)     ;; orig. repeat-complex-command
;;          ("C-x b" . consult-buffer)                ;; orig. switch-to-buffer
;;          ("C-x 4 b" . consult-buffer-other-window) ;; orig. switch-to-buffer-other-window
;;          ("C-x 5 b" . consult-buffer-other-frame)  ;; orig. switch-to-buffer-other-frame
;;          ("C-x r b" . consult-bookmark)            ;; orig. bookmark-jump
;;          ("C-x p b" . consult-project-buffer)      ;; orig. project-switch-to-buffer
;;          ;; Custom M-# bindings for fast register access
;;          ("M-#" . consult-register-load)
;;          ("M-'" . consult-register-store)          ;; orig. abbrev-prefix-mark (unrelated)
;;          ("C-M-#" . consult-register)
;;          ;; Other custom bindings
;;          ("M-y" . consult-yank-pop)                ;; orig. yank-pop
;;          ;; M-g bindings in `goto-map'
;;          ("M-g e" . consult-compile-error)
;;          ("M-g f" . consult-flymake)               ;; Alternative: consult-flycheck
;;          ("M-g g" . consult-goto-line)             ;; orig. goto-line
;;          ("M-g M-g" . consult-goto-line)           ;; orig. goto-line
;;          ("M-g o" . consult-outline)               ;; Alternative: consult-org-heading
;;          ("M-g m" . consult-mark)
;;          ("M-g k" . consult-global-mark)
;;          ("M-g i" . consult-imenu)
;;          ("M-g I" . consult-imenu-multi)
;;          ;; M-s bindings in `search-map'
;;          ("M-s d" . consult-find)                  ;; Alternative: consult-fd
;;          ("M-s D" . consult-locate)
;;          ("M-s g" . consult-grep)
;;          ("M-s G" . consult-git-grep)
;;          ("M-s r" . consult-ripgrep)
;;          ("M-s l" . consult-line)
;;          ("M-s L" . consult-line-multi)
;;          ("M-s k" . consult-keep-lines)
;;          ("M-s u" . consult-focus-lines)
;;          ;; Isearch integration
;;          ("M-s e" . consult-isearch-history)
;;          :map isearch-mode-map
;;          ("M-e" . consult-isearch-history)         ;; orig. isearch-edit-string
;;          ("M-s e" . consult-isearch-history)       ;; orig. isearch-edit-string
;;          ("M-s l" . consult-line)                  ;; needed by consult-line to detect isearch
;;          ("M-s L" . consult-line-multi)            ;; needed by consult-line to detect isearch
;;          ;; Minibuffer history
;;          :map minibuffer-local-map
;;          ("M-s" . consult-history)                 ;; orig. next-matching-history-element
;;          ("M-r" . consult-history)))                ;; orig. previous-matching-history-element


(map! :prefix "M-s i"
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

;; (use-package flyspell-correct
;;   :after flyspell
;;   :bind (:map flyspell-mode-map ("C-;" . flyspell-correct-wrapper)))

;; (define-key! flyspell-mode-map "C-;" #'flyspell-correct-wrapper)
(define-key! [remap flyspell-auto-correct-previous-word] #'flyspell-correct-wrapper)

(setq flyspell-persistent-highlight nil)

(setq flyspell-issue-message-flag nil)

(setq ispell-personal-dictionary "/home/dvsdude/.aspell.en_CA.pws")
(setq ispell-program-name "aspell")
(setq ispell-extra-args '("--repl" "~/aspell.prepl"))

(use-package spray
  ;; :load-path "~/builds/manual-packages/spray"
  :defer t
  :commands (spray-mode)
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

;;;###autoload
(defun =config ()
  "Open your private config.el file."
  (interactive)
  (find-file (expand-file-name "config.org" doom-user-dir)))

(defun dvs/zen-scratch-pad ()
   "Create a new org-mode buffer for random stuff."
   (interactive)
   (let ((buffer (generate-new-buffer "org-scratchy")))
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

;; zone
;; (zone-when-idle 60)

;; beacon highlight cursor
(beacon-mode t)

;; plantuml jar configuration
(setq plantuml-jar-path "/usr/share/java/plantuml/plantuml.jar")
  ;; Enable plantuml-mode for PlantUML files
(add-to-list 'auto-mode-alist '("\\.plantuml\\'" . plantuml-mode))
  ;; Enable exporting
(org-babel-do-load-languages 'org-babel-load-languages '((plantuml . t)))

;; declutter
(use-package! declutter
  :defer t)
(setq declutter-engine-path "/usr/bin/rdrview")
(setq declutter-engine 'rdrview)  ; rdrview will get and render html
;; (setq declutter-engine 'eww)      ; eww will get and render html

;; org-web-tools
(require 'org-web-tools)
;; use to download webpage text content
;; (use-package! org-web-tools)

;; hacker news comments
(use-package! hnreader
  :after elfeed)

;; org-keybindings

(map! :after org
      :leader
      :prefix ("o" . "open")
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
      :n "k" (lambda () (interactive) (find-file "~/org/wiki/")))

;; demarcate or create source-block
(map! :after org
      :leader
      :prefix "d"
      :desc "demarcate/create source-block"
      :n "b" #'org-babel-demarcate-block)
;; cycle agenda files
(map! :after org
      :leader
      :prefix ("o" . "open")
      :desc "cycle agenda files"
      :n "a f" #'org-cycle-agenda-files)
;; open config in named workspace
(map! :after org
      :leader
      :prefix ("o" . "open")
      :desc "open calendar"
      :n "c" #'=calendar)
;; read url's readable content to org buffer
(map! :leader
      :prefix "i"
      :desc "websites-content to org" "w" #'org-web-tools-read-url-as-org)
;; list-processes
(map! :leader
      :prefix "l"
      :desc "list processes" "p" #'list-processes)
;; adds selected text to chosen buffer
(map! :leader
      :prefix "i"
      :desc "append to buffer" "t" #'append-to-buffer)
;; adds entire buffer to chosen buffer
(map! :leader
      :prefix "i"
      :desc "insert buffer at point" "b" #'insert-buffer)
;; use mpv to open video files ;;;;
(map! :leader
      :prefix ("v" . "video")
      :desc "play file with mpv" "f" #'mpv-play)
;; use mpv to open video url ;;;;
(map! :leader
      :prefix ("v" . "video")
      :desc "play link with mpv" "l" #'mpv-play-url)
;; toggle vertico-grid-mode
(map! :leader
      :prefix "t"
      :desc "toggle vertico grid"
      :n "g" 'vertico-grid-mode)
;; toggle default-scratch buffer
(map! :leader
      :prefix ("o" . "open")
      :desc "open defalt scratch-buffer"
      :n "x" #'scratch-buffer)

;; start org-mpv-notes-mode
(map! "<f5> n" #'org-mpv-notes)
;; (defhydra hydra-mpv (global-map "<f5> m")
;; dictioary-lookup-definition better than spc s t
(map! "M-*" #'dictionary-lookup-definition)
(map! "M-s d" #'dictionary-lookup-definition)
(map! "M-s h" #'consult-history)
(map! "<f7>" #'dictionary-lookup-definition)
;; fetches selected text and gives you a list of synonyms to replace it with
(map! "M-&" #'powerthesaurus-lookup-word-dwim)
;; close other window ;;;;
(map! "C-1" #'delete-other-windows)
;; switch other window
(map! "C-2" #'switch-to-buffer-other-window)
;; Minibuffer history
(map! "C-c h" #'consult-history)
;; tranpose function for missed punctuation
(map! "C-c t" #'transpose-chars)
;; ;; start modes
(map! :prefix ("C-c m" . "mode command")
      "o" #'org-mode
      "e" #'emacs-lisp-mode
      "f" #'fundamental-mode)
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

;; (setq which-key-popup-type 'minibuffer)
;; (setq which-key-popup-type 'side-window)
;; (setq which-key-popup-type 'frame)

;; (which-key-setup-minibuffer)
(which-key-setup-side-window-bottom)
;;(which-key-setup-side-window-right)
;;(which-key-setup-side-window-right-bottom)
;; (setq which-key-use-C-h-commands nil)
(setq which-key-idle-delay 1.5)

;; use open window for default target
(setq dired-dwim-target t)

;; (add-hook 'dired-mode-hook
;;           'display-line-numbers-mode)
(add-hook 'dired-mode-hook
          'dired-hide-details-mode)

;;; dired preview set to toggle, can be auto
(after! dired
  (use-package! dired-preview))
;;     :hook
;;     (dired-mode . dired-preview-mode)))
;; (dired-preview-global-mode 1)

(map! :leader
      :prefix "t"
      :desc "dired preview mode" "p" 'dired-preview-mode)

;;; dired subtree
(use-package! dired-subtree
  :after dired
  :config
  (bind-key "<tab>" #'dired-subtree-toggle dired-mode-map)
  (bind-key "<backtab>" #'dired-subtree-cycle dired-mode-map))

;; dired open
(after! dired
  (use-package! dired-open
    :config
    (setq dired-open-extensions '(("mkv" . "mpv")
                                  ("mp4" . "mpv")
                                  ("webm" . "mpv")))))

(after! org
(use-package org-mpv-notes
  :defer t))
    ;; "Org minor mode for Note taking alongside audio and video.
    ;; Uses mpv.el to control mpv process"

;; from https://github.com/kljohann/mpv.el/wiki
;;  To create a mpv: link type that is completely analogous to file: links but opens using mpv-play instead,
(defun org-mpv-notes-complete-link (&optional arg)
   "Provide completion to mpv: link in `org-mode'."
  (replace-regexp-in-string
   "file:" "mpv:"
   (org-link-complete-file arg)
   t t))

(org-link-set-parameters "mpv"
                         :complete #'org-mpv-notes-complete-link
                         :follow #'org-mpv-notes-open
                         :export #'org-mpv-notes-export)

(add-hook 'org-open-at-point-functions #'mpv-seek-to-position-at-point)

;; mpv commands

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

;; mpv-hydra ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defhydra hydra-mpv (global-map "<f5> m")
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
(defun c1/mpv-play-url (&optional url &rest arg)
   "Start mpv for URL."
  (interactive)
  (mpv-start url))

;; https://mbork.pl/2022-10-24_Playing_videos_from_the_last_position_in_mpv
;; (defun dvs/browse-url-with-mpv (url)
;;   "Open URL using mpv."
;;   (mpv-start url))

;;;###autoload
(defun elfeed-open-hnreader-url (url &optional new-window)
  (interactive)
  (hnreader-comment url))

(setq browse-url-handlers
    '(("\\.\\(gifv?\\|avi\\|AVI\\|mp[4g]\\|MP4\\|MP3\\|webm\\)/" . c1/mpv-play-url)
      ("^https?://\\(www\\.youtube\\.com\\|youtu\\.be\\)/" . c1/mpv-play-url)
      ("^https?://\\(odysee\\.com\\|rumble\\.com\\)/" . c1/mpv-play-url)
      ("^https?://\\(off-guardian.org\\|.substack\\.com\\|tomluongo\\.me\\)/" . dvs-eww)
      ;; ("^https?://\\(emacs.stackexchange.com\\|news.ycombinator.com\\)/" . dvs-eww)
      ("^https?://\\(news.ycombinator.com\\)/" . elfeed-open-hnreader-url)
      ("." . browse-url-xdg-open)))

(use-package ytdl
  :defer t
  :init
  (setq ytdl-music-folder (expand-file-name "~/music")
        ytdl-video-folder (expand-file-name "~/videos"))
  :config
  (setq ytdl-always-query-default-filename 'never))

(use-package! deft
  :commands deft
  :init
  (setq deft-default-extension "org"
        deft-directory "~/org/"
        ;; de-couples filename and note title:
        deft-use-filename-as-title t
        deft-use-filter-string-for-filename t
        deft-recursive t
        ;; disable auto-save
        deft-auto-save-interval -1.0
        ;; converts the filter string into a readable file-name using kebab-case:
        deft-file-naming-rules
        '((noslash . "-")
          (nospace . "-")
          (case-fn . downcase))
        deft-strip-summary-regexp
      (concat "\\("
          "[\n\t]" ;; blank
          "\\|^#\\+[[:alpha:]_]+:.*$" ;; org-mode metadata
          "\\|^:PROPERTIES:\n\\(.+\n\\)+:END:\n"
          "\\)"))
  :config
  (add-to-list 'deft-extensions '("md" "txt" "tex" "org"))
  (add-hook 'deft-mode-hook #'doom-mark-buffer-as-real-h)
  ;; start filtering immediately
  (set-evil-initial-state! 'deft-mode 'insert)
  (map! :map deft-mode-map
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
        :n "q"   #'kill-current-buffer))

;; (setq deft-extensions '("md" "txt" "tex" "org"))
;; (setq deft-directory "~/org/")
;; (setq deft-recursive t)
;; (setq deft-use-filename-as-title t)
;; (setq deft-strip-summary-regexp
;;       (concat "\\("
;;           "[\n\t]" ;; blank
;;           "\\|^#\\+[[:alpha:]_]+:.*$" ;; org-mode metadata
;;           "\\|^:PROPERTIES:\n\\(.+\n\\)+:END:\n"
;;           "\\)"))

;; This is an opinionated workflow that turns Emacs into an RSS reader, inspired
;; by apps Reeder and Readkit. It can be invoked via `=rss'. Otherwise, if you
;; don't care for the UI you can invoke elfeed directly with `elfeed'.

(defvar +rss-split-direction 'below
  "What direction to pop up the entry buffer in elfeed.")

(defvar +rss-enable-sliced-images t)

(defvar +rss-workspace-name "*rss*"
  "Name of the workspace that contains the elfeed buffer.")

(use-package! elfeed
  :commands elfeed
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
  (add-hook! 'elfeed-search-mode-hook
    (add-hook 'kill-buffer-hook #'+rss-cleanup-h nil 'local))

  ;; Large images are annoying to scroll through, because scrolling follows the
  ;; cursor, so we force shr to insert images in slices.
  (when +rss-enable-sliced-images
    (setq-hook! 'elfeed-show-mode-hook
      shr-put-image-function #'+rss-put-sliced-image-fn
      shr-external-rendering-functions '((img . +rss-render-image-tag-without-underline-fn))))

  ;; Keybindings
  (after! elfeed-show
    (define-key! elfeed-show-mode-map
      [remap next-buffer]     #'+rss/next
      [remap previous-buffer] #'+rss/previous))
  (when (modulep! :editor evil +everywhere)
    (evil-define-key 'normal elfeed-search-mode-map
      "q" #'elfeed-kill-buffer
      "r" #'elfeed-search-update--force
      (kbd "M-RET") #'elfeed-search-browse-url)
    (map! :map elfeed-show-mode-map
          :n "gc" nil
          :n "gc" #'+rss/copy-link)))


;; "Watch a video from URL in MPV" ;;
(defun elfeed-v-mpv (url)
  (async-shell-command (format "mpv %s" url)))

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
  (interactive)
  (let ((entries (elfeed-search-selected)))
    (cl-loop for entry in entries
             do (elfeed-untag entry 'unread)
             when (elfeed-entry-link entry)
             do (eww-browse-url it))
    (mapc #'elfeed-search-update-entry entries)
    (unless (use-region-p) (forward-line))))

;; Declutter-it ;;;;
(defun declutter-it ()
  (interactive)
  (let ((entries (elfeed-search-selected)))
    (cl-loop for entry in entries
             do (elfeed-untag entry 'unread)
             when (elfeed-entry-link entry)
             do (declutter it))
    (mapc #'elfeed-search-update-entry entries)
    (unless (use-region-p) (forward-line))))

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

;; define tag "star" ;;;;
(defun elfeed-expose (function &rest args)
    "Return an interactive version of FUNCTION, exposing it to the user."
  (lambda () (interactive) (apply function args)))
(defalias 'elfeed-toggle-star
       (elfeed-expose #'elfeed-search-toggle-all 'star))

;; (require 'hnreader)
;; (require 'promise)
;; (defun my/elfeed-hn-show-comments (&optional link)
;;   (interactive)
;;   (let* ((entry (if (eq major-mode 'elfeed-show-mode)
;;                     elfeed-show-entry
;;                   (elfeed-search-selected :ignore-region)))
;;          (link (if link link (elfeed-entry-link entry))))
;;     (setq-local hnreader-view-comments-in-same-window nil)
;;     (hnreader-promise-comment (format "%s" link))))

;; hn-show-comments from search-mode ;;;;

;; hacker news comment reader
(defun dvs/elfeed-hn-show-comments ()
  (interactive)
  (let ((entries (elfeed-search-selected)))
    (cl-loop for entry in entries
             do (elfeed-untag entry 'unread)
             when (cdr (elfeed-entry-id entry))
             do (hnreader-promise-comment it))
    (mapc #'elfeed-search-update-entry entries)
    (unless (use-region-p) (forward-line))))

;; keymap ;;
(map! :leader
      :prefix "o"
      :desc "open elfeed" "e" #'=rss)

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
      :n "R" #'elfeed-summary
      ;; :n "u" #'declutter-it
      :n "T" #'my/elfeed-reddit-show-commments
      :n "v" #'elfeed-view-mpv
      :n "x" #'elfeed-curate-export-entries
      :n "Y" #'yt-sub-ex)
(map! :after elfeed
      :map elfeed-show-mode-map
      :n [remap save-buffer] 'elfeed-tube-save
      :n "a" #'elfeed-curate-edit-entry-annoation
      :n "d" #'yt-dl-it
      :n "e" #'elfeed-eww-open
      :n "m" #'elfeed-curate-toggle-star
      :n "x" #'elfeed-kill-buffer)

;;;; set default filter ;;;;
;; (setq-default elfeed-search-filter "@1-week-ago +unread ")
(add-hook 'elfeed-search-mode-hook #'elfeed-summary)

(use-package! elfeed-goodies
  :after elfeed
  :config
  (elfeed-goodies/setup))

(use-package! elfeed-org
  :after elfeed
  :preface
  ;; (setq rmh-elfeed-org-files (list "elfeed.org"))
  (setq rmh-elfeed-org-files (list "~/.config/doom/elfeed-feeds.org"))
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

;; NOTE use this as an example of default way of keybinding
;; (after! elfeed
;;   ;; Your custom Elfeed configuration.
;;   ;; elfeed-curate key bindings:
;;   (define-key elfeed-search-mode-map "a" #'elfeed-curate-edit-entry-annoation)
;;   (define-key elfeed-search-mode-map "x" #'elfeed-curate-export-entries)
;;   (define-key elfeed-search-mode-map "m" #'elfeed-curate-toggle-star)

;;   (define-key elfeed-show-mode-map   "a" #'elfeed-curate-edit-entry-annoation)
;;   (define-key elfeed-show-mode-map   "m" #'elfeed-curate-toggle-star)
;;   (define-key elfeed-show-mode-map   "q" #'kill-buffer-and-window))

(after! elfeed
(use-package elfeed-tube
  :demand t
  :config
  (elfeed-tube-setup)))

(after! elfeed
(use-package elfeed-tube-mpv))

(use-package elfeed-summary
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
        (group (:title . "stared")
               (:elements
                (search
               (:filter . "+star")
               (:title . "")))
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
                (query . corbett))
               (:hide t))
        (group (:title . "science")
               (:elements
                (query . sci))
               (:hide t))
        (group (:title . "Substack")
               (:elements
                (query . sub))
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
(setq eww-retrieve-command
     '("brave" "--headless" "--dump-dom"))

;; open links in eww
(defun dvs-eww (url &optional arg)
    "Pass URL to appropriate client"
  (interactive
   (list (browse-url-interactive-arg "URL: ")
         current-prefix-arg))
  (let ((url-parsed (url-generic-parse-url url)))
    (pcase (url-type url-parsed)
            (_ (eww url arg)))))

;;
;; Produce buffer with RSS/Atom links from source
(defvar prot-eww--occur-feed-regexp
  (concat "\\(rss\\|atom\\)\\+xml.\\(.\\|\n\\)"
          ".*href=[\"']\\(.*?\\)[\"']")
    "Regular expression to match web feeds in HTML source.")
(defvar prot-common-url-regexp
  (concat
   "~?\\<\\([-a-zA-Z0-9+&@#/%?=~_|!:,.;]*\\)"
   "[.@]"
   "\\([-a-zA-Z0-9+&@#/%?=~_|!:,.;]+\\)\\>/?")
  "Regular expression to match (most?) URLs or email addresses.")
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
  :defer t
  :custom
(vterm-module-cmake-args "-DUSE_SYSTEM_LIBVTERM=yes")
(vterm-always-compile-module t))

;; vterm-toggle ;;;;
(map! "<f2>" #'vterm-toggle
      "C-<f2>" #'vterm-toggle-cd)

(use-package engine-mode
  :defer t
  :config
  (engine-mode t))
(defengine nitter
"https://nitter.net/search?f=tweets&q=%s"
  :keybinding "n")
(defengine githubcs
  "https://github.com/search?type=code&auto_enroll=true&q=%s"
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

(map! :leader
      :prefix "v"
      :desc "YouTube subtitles"
      :n "E" #'youtube-sub-extractor-extract-subs)

(map! :leader
      :prefix "v"
      :desc "YouTube subtitles at point"
      :n "e" #'youtube-sub-extractor-extract-subs-at-point)

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
       :desc "insert file link" "k" 'languagetool-check
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

(require 'yeetube)
(setq yeetube-download-directory "~/Videos")

(map! :map yeetube-mode-map
     [remap evil-ret] #'yeetube-play)

(map! :leader
      :prefix "s"
      :desc "search yeetube" "y" #'yeetube-search)

(use-package monkeytype
  :defer t)
(defun my/monkeytype-mode-hook ()
    "Hooks for monkeytype-mode."
  (evil-escape-mode -1)
  (flyspell-mode -0)
  (corfu-mode -0)
  (evil-insert -1)
  (+zen/toggle)
  (text-scale-set 3))

;; Toggle downcase text
(add-hook 'monkeytype-mode-hook #'my/monkeytype-mode-hook)


(map! :after org
      :leader
      :prefix "o"
      :desc "open monkeytype"
      :n "m" #'monkeytype-load-words-from-file)

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

(use-package! yequake
  :defer t
  :custom
  (yequake-frames
   '(("org-capture"
      (buffer-fns . (yequake-org-capture))
      (width . 0.75)
      (height . 0.5)
      (alpha . 0.95)
      (frame-parameters . ((undecorated . t)
                           (skip-taskbar . t)
                           (sticky . t))))
     ("Yequake & scratch" .
         ((width . 0.75)
          (height . 0.5)
          (alpha . 0.95)
          (buffer-fns . ("~/org/yequake/key-reminder.org"
                         split-window-horizontally
                         "*scratch*"))
          (frame-parameters . ((undecorated . t)))))
     ("evil-easymotion" .
         ((width . 0.75)
          (height . 0.5)
          (alpha . 0.95)
          (buffer-fns . ("~/org/yequake/evil-easymotion.org"))
          (frame-parameters . ((undecorated . t))))))))

;; use this in linux to call it outside of emacs
;; emacsclient -n -e '(yequake-toggle "org-capture")'

;; toggle yequakes-frames
(map! :leader
      :prefix "t"
      :desc "toggle yequakes-frames"
      :n "y" #'yequake-toggle)
;; use this to call from linux
;; emacsclient -n -e '(yequake-toggle "Yequake & scratch")'

(after! org
(use-package! org-media-note
  :hook (org-mode .  org-media-note-mode)
  :bind (("<f5> v" . org-media-note-hydra/body))  ;; Main entrance
  :config
  (setq org-media-note-screenshot-image-dir "~/pictures/")))  ;; Folder to save screenshot

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
