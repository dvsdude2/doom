(";;; package --- summary
;;; Commentary:
;; (provide 'flycheck)
;;; flycheck ends here
;;; code:
(map! :leader
      :prefix \"t\"
      :desc \"toggle eshell\"
      :n \"e\" #'+eshell/toggle)

(setq alert-default-style 'libnotify)



org-use-speed-commands’ to a non-‘nil’ value
(setq org-use-speed-commands t)

;; looking at this for eww text to be centered?
;; pet poject Iam working on. 
(setq 
  shr-bullet    \"• \"       ;  Character for an <li> list item
  shr-indentation 14)        ;  Left margin

;; To check whether the minor mode is enabled in the current buffer,
;; evaluate

 
(defcustom which-key-paging-key \"<f5>\"
  \"Key to use for changing pages.
Bound after each of the prefixes in `which-key-paging-prefixes'\"
  :type 'string
  :version \"1.0\")


(cl-pushnew `((,(format \"\\\\`\\\\(C-c\\\\)\\\\ a\\\\'\" prefix-re))
                  nil . \"evilem\")
                which-key-replacement-alist)
 # 
 #  Swap Caps_Lock and Control_L
 # 
 remove Lock = Caps_Lock
 remove Control = Control_L
 #  Don't swap, forget it.
 # keysym Control_L = Caps_Lock
 keysym Caps_Lock = Control_L
 # add Lock = Caps_Lock
 add Control = Control_L


 
(defcustom monkeytype-randomize t
  \"Toggle randomizing of words.\"
  :type 'boolean)



(use-package! ready-player
  :defer t
  :config
  (ready-player-mode +1))


;;;; 'popup rules'

;; these are the rules grabbed from +popup/diagnose. for EWW 
Rule matches: (^\\*eww\\* (+popup-buffer) (actions) (side . bottom) (size . 0.35) (window-width . 40) (window-height . 0.35) (slot) (vslot . -11) (window-parameters (ttl . 5) (quit . t) (select . t) (modeline) (autosave) (transient . t) (no-other-window . t)))

Signature
(set-popup-rule! PREDICATE &key IGNORE ACTIONS SIDE SIZE WIDTH HEIGHT SLOT VSLOT TTL QUIT SELECT MODELINE AUTOSAVE PARAMETERS)

doom/save-and-kill-buffer

;;;###autoload
(defun doom/save-and-kill-buffer ()
  \"Save the current buffer to file, then kill it.\"
  (interactive)
  (save-buffer)
  (kill-current-buffer))


(defun dired-preview--close-previews ()
  \"Kill preview buffers and delete their windows.\"
  (dired-preview--cancel-timer)
  (dired-preview--delete-windows)
  (dired-preview--kill-buffers)
  (dired-preview--kill-large-buffers))

(defun my/readme-update-ediff ()
    \"Update git README\\\\ using ediff.\"
  (interactive)
  (ediff \"~/.config/doom/config.org\" \"~/.config/doom/README.org\"))





;; (provide 'flycheck)
;;; flycheck ends here
" 2202 emacs-lisp-mode)