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


 
(defcustom monkeytype-randomize t
  \"Toggle randomizing of words.\"
  :type 'boolean)



(use-package! ready-player
  :defer t
  :config
  (ready-player-mode +1))


;; command to generate an org-mode rendering of an eww page
(defun jao-eww-to-org (&optional dest)
  \"Render the current eww buffer using org markup.
If DEST, a buffer, is provided, insert the markup there.\"
  (interactive)
  (unless (org-region-active-p)
    (let ((shr-width 80)) (eww-readable)))
  (let* ((start (if (org-region-active-p) (region-beginning) (point-min)))
         (end (if (org-region-active-p) (region-end) (point-max)))
         (buff (or dest (generate-new-buffer \"*eww-to-org*\")))
         (link (eww-current-url))
         (title (or (plist-get eww-data :title) \"\")))
    (with-current-buffer buff
      (insert \"#+title: \" title \"\\n#+link: \" link \"\\n\\n\")
      (org-mode))
    (save-excursion
      (goto-char start)
      (while (< (point) end)
        (let* ((p (point))
               (props (text-properties-at p))
               (k (seq-find (lambda (x) (plist-get props x))
                            '(shr-url image-url outline-level face)))
               (prop (and k (list k (plist-get props k))))
               (next (if prop
                         (next-single-property-change p (car prop) nil end)
                       (next-property-change p nil end)))
               (txt (buffer-substring (point) next))
               (txt (replace-regexp-in-string \"\\\\*\" \"·\" txt)))
          (with-current-buffer buff
            (insert
             (pcase prop
               ((and (or `(shr-url ,url) `(image-url ,url))
                     (guard (string-match-p \"^http\" url)))
                (let ((tt (replace-regexp-in-string \"\\n\\\\([^$]\\\\)\" \" \\\\1\" txt)))
                  (org-link-make-string url tt)))
               (`(outline-level ,n)
                (concat (make-string (- (* 2 n) 1) ?*) \" \" txt \"\\n\"))
               ('(face italic) (format \"/%s/ \" (string-trim txt)))
               ('(face bold) (format \"*%s* \" (string-trim txt)))
               (_ txt))))
          (goto-char next))))
    (pop-to-buffer buff)
    (goto-char (point-min))))








(provide 'flycheck)
;;; flycheck ends here
" 2378 emacs-lisp-mode)