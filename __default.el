(";;; package --- summary
;;; Commentary:
(provide 'flycheck)
;;; flycheck ends here
;;; code:
(map! :leader
      :prefix \"t\"
      :desc \"toggle eshell\"
      :n \"e\" #'+eshell/toggle)


(defvar doom-scratch-dir (concat doom-data-dir \"scratch\")


(defvar doom-scratch-default-file \"__default\"
  \"The default file name for a project-less scratch buffer.

Will be saved in `doom-scratch-dir'.\")

;; regex for youtube links

(?:www\\.)?youtu(?:be\\.com\\/watch\\?v=|\\.be\\/)([\\w\\-\\_]*)(&(amp;)?‌​[\\w\\?‌​=]*)?

http://(www\\.)?youtube\\.com/watch\\?.*v=([a-zA-Z0-9]+).*

\"(https?:\\/\\/)?(www\\.|m\\.)?youtube\\.com\\/watch\\?v=([a-zA-Z0-9-]{11})\"


(setq-hook! 'elfeed-summary-mode python-indent-offset 2)

(setq alert-default-style 'libnotify)

(setq calendar-latitude 53.1)
(setq calendar-longitude -110.2)


(setq org-use-speed-commands
      (lambda () (and (looking-at org-outline-regexp) (looking-back \"^\\\\**\"))))

org-use-speed-commands’ to a non-‘nil’ value
(setq org-use-speed-commands t)

;; looking at this for eww text to be centered?
;; pet poject Iam working on. 
(setq 
  shr-bullet    \"• \"       ;  Character for an <li> list item
  shr-indentation 14)        ;  Left margin

(use-package casual-info
  :ensure t
  :bind (:map Info-mode-map (\"C-o\" . 'casual-info-tmenu)))


(add-to-list 'load-path 
             (directory-file-name \"~/.config/doom/myrepo/xml-hide/\"))

(use-package pomidor
  :bind ((\"<f9>\" . pomidor))
  :config (setq pomidor-sound-tick nil
                pomidor-sound-tack nil)
  :hook (pomidor-mode . (lambda ()
                          (display-line-numbers-mode -1) ; Emacs 26.1+
                          (setq left-fringe-width 0 right-fringe-width 0)
                          (setq left-margin-width 2 right-margin-width 0)
                          ;; force fringe update
                          (set-window-buffer nil (current-buffer)))))




(provide 'flycheck)
;;; flycheck ends here
" 1402 emacs-lisp-mode)