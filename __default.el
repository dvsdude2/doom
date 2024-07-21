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

(defvar pomidor-mode-map
  (let ((map (make-keymap)))
    (define-key map (kbd \"M-q\") #'quit-window)
    (define-key map (kbd \"M-Q\") #'pomidor-quit)
    (define-key map (kbd \"M-R\") #'pomidor-reset)
    (define-key map (kbd \"M-h\") #'pomidor-hold)
    (define-key map (kbd \"M-H\") #'pomidor-unhold)
    (define-key map (kbd \"M-RET\") #'pomidor-stop)
    (define-key map (kbd \"M-SPC\") #'pomidor-break)
    (suppress-keymap map)
    map))
(map! :map pomidor-mode-map
      :desc \"quit window\"
      :n \"M-q\" #'quit-window
      :desc \"pomidor quit\"
      :n \"M-Q\" #'pomidor-quit
      :desc \"pomidor reset\"
      :n \"M-R\" #'pomidor-reset
      :desc \"pomidor-hold\"
      :n \"M-h\" #'pomidor-hold
      :desc \"pomidor-unhold\"
      :n \"M-H\" #'pomidor-unhold
      :desc \"pomidor-stop\"
      :n \"M-RET\" #'pomidor-stop
      :desc \"pomidor-break\"
      :n \"M-SPC\" #'pomidor-break)


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



(provide 'flycheck)
;;; flycheck ends here
" 1978 emacs-lisp-mode)