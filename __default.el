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

;;; repeat-mode
(defvar cc/org-header-navigation-repeat-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd \"p\")    #'org-previous-visible-heading)
    (define-key map (kbd \"n\")  #'org-next-visible-heading)
    map))

(repeatize 'cc/org-header-navigation-repeat-map)



(setq org-use-speed-commands
      (lambda () (and (looking-at org-outline-regexp) (looking-back \"^\\\\**\"))))

org-use-speed-commands’ to a non-‘nil’ value
(setq org-use-speed-commands t)

(display-time-mode t)
(display-time-day-date-mode t)

;; add time only on fullscreen 
(defun bram85-show-time-for-fullscreen (frame)
  \"Show the time in the modeline when the FRAME becomes full screen.\"
  (let ((fullscreen (frame-parameter frame 'fullscreen)))
    (if (memq fullscreen '(fullscreen fullboth))
        (display-time-mode 1)
      (display-time-mode -1))))

(add-hook 'window-size-change-functions #'bram85-show-time-for-fullscreen)

Remove load average from time string displayed in mode-line
🌐
emacs.stackexchange.com
› questions › 20783 › remove-load-average-from-time-string-displayed-in-mode-line
See the variable display-time-default-load-average




(provide 'flycheck)
;;; flycheck ends here
" 1349 emacs-lisp-mode)