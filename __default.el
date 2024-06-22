(";;; package --- summary
;;; Commentary:
(provide 'flycheck)
;;; flycheck ends here
;;; code:
(map! :leader
      :prefix \"t\"
      :desc \"toggle eshell\"
      :n \"e\" #'+eshell/toggle)



(?:www\\.)?youtu(?:be\\.com\\/watch\\?v=|\\.be\\/)([\\w\\-\\_]*)(&(amp;)?‌​[\\w\\?‌​=]*)?

http://(www\\.)?youtube\\.com/watch\\?.*v=([a-zA-Z0-9]+).*

\"(https?:\\/\\/)?(www\\.|m\\.)?youtube\\.com\\/watch\\?v=([a-zA-Z0-9-]{11})\"



(setq alert-default-style 'libnotify)



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







(provide 'flycheck)
;;; flycheck ends here
" 808 emacs-lisp-mode)