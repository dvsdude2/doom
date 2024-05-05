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





(provide 'flycheck)
;;; flycheck ends here
" 662 emacs-lisp-mode)