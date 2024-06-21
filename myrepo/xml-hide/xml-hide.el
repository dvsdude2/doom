;;; xml-hide.el --- Hide XML tags in Emacs -*- lexical-binding: t; -*-

;; Author: Bruno Conte
;; Version: 1.0
;; Package-Requires: ((emacs "24.3"))

;;; Commentary:
;; A package to hide XML tags in Emacs.
;; Heavily inspired by sgml-mode.

(or (get 'xml-tag 'invisible)
    (setplist 'xml-tag
	            (append '(invisible t
			                            rear-nonsticky t
			                            read-only t)
		                  (symbol-plist 'xml-tag))))

(defgroup xml-hide nil
  "Hide XML tags in Emacs."
  :group 'text)

(defcustom xml-hide-replacement-string ""
  "String used to replace hidden XML tags."
  :type 'string
  :group 'xml-hide)

(defun hide-xml-tags ()
  "Hide all XML tags in the current buffer, displaying only the text contents."
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward "<[^<>]*>" nil t)
      (let ((mb (match-beginning 0))
            (me (match-end 0))
            (inhibit-read-only t))
        (put-text-property mb me 'category 'xml-tag)
        (let ((ov (make-overlay mb me)))
          (overlay-put ov 'xml-tag t)
          (overlay-put ov 'before-string xml-hide-replacement-string))))))

(defun xml-show-all ()
  "Show all hidden XML tags in the current buffer."
  (interactive)
  (let ((pos (point-min))
        (inhibit-read-only t))
    (while (< (setq pos (next-overlay-change pos)) (point-max))
      (dolist (ol (overlays-at pos))
        (if (overlay-get ol 'xml-tag)
            (progn
              (remove-text-properties pos (next-overlay-change pos) '(category . nil))
              (delete-overlay ol)))))))

;;;###autoload
(define-minor-mode xml-hide-mode
  "Toggle XML hide mode.
With no argument, this command toggles the mode.
Non-null prefix argument turns on the mode.
Null prefix argument turns off the mode."
  :lighter "XMLHide"
  :keymap (let ((map (make-sparse-keymap)))
            (define-key map (kbd "C-c h h") 'hide-xml-tags)
            (define-key map (kbd "C-c h s") 'xml-show-all)
            map)
  (if xml-hide-mode
      (hide-xml-tags)
    (xml-show-all)))

(provide 'xml-hide)
