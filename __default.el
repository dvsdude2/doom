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






(provide 'flycheck)
;;; flycheck ends here
" 393 emacs-lisp-mode)