;;; myrepo/xml-hide/autoload.el -*- lexical-binding: t; -*-

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
