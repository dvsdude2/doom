;;; my-reformat-paragraph.el --- cycle through org-fill-paragraph, fill-sentences-in-paragraph, unfill-paragraph   -*- lexical-binding: t -*-

;; Copyright (C) 2025 Dvsdude

;; Author: Dvsdude
;; Package-Version: 0
;; Keywords: convenience

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;; This file is NOT part of GNU Emacs.

;;; Commentary:

;; Cycles the paragraph between three states: filled/unfilled/fill-sentences.
;; Provides commands for explicitly unfilling (ie. unwrapping)
;; paragraphs and regions, and also a command that will toggle between
;; filling and unfilling the current paragraph or region.

;; Based initially on Shauch Chau examples, and later rewritten based on an article by Artur Malabarba.
;;   https://sachachua.com/blog/2025/09/emacs-cycle-through-different-paragraph-formats-all-on-one-line-wrapped-max-one-sentence-per-line-one-sentence-per-line/
;;   https://schauderbasis.de/posts/reformat_paragraph/
;;   http://xahlee.org/emacs/emacs_unfill-paragraph.html
;;   http://xahlee.org/emacs/modernization_fill-paragraph.html

;;; Code:
;;;###autoload
(defun unfill-paragraph ()
  "Replace newline chars in current paragraph by single spaces.
This command does the inverse of `fill-paragraph'."
  (interactive)
  (let ((fill-column most-positive-fixnum))
    (call-interactively 'fill-paragraph)))

;;;###autoload
(defun unfill-region (start end)
  "Replace newline chars in region from START to END by single spaces.
This command does the inverse of `fill-region'."
  (interactive "r")
  (let ((fill-column most-positive-fixnum))
    (fill-region start end)))

;;;###autoload
(defun unfill-toggle ()
  "Toggle filling/unfilling of the current region.
Operates on the current paragraph if no region is active."
  (interactive)
  (let (deactivate-mark
        (fill-column
         (if (eq last-command this-command)
             (progn (setq this-command nil)
                    most-positive-fixnum)
           fill-column)))
    (call-interactively 'fill-paragraph)))

;;;###autoload
(define-obsolete-function-alias 'toggle-fill-unfill 'unfill-toggle "0.2")

(defun fill-sentences-in-paragraph ()
  "Put a newline at the end of each sentence in the current paragraph."
  (interactive)
  (save-excursion
    (mark-paragraph)
    (call-interactively  'fill-sentences-in-region)))

(defun fill-sentences-in-region (start end)
  "Put a newline at the end of each sentence in the region maked by (START END)."
  (interactive  "*r")
  (call-interactively  'unfill-region)
  (save-excursion
    (goto-char start)
    (while ( < ( point) end)
      (forward-sentence)
      (if (looking-at-p  " ")
          (newline-and-indent)))))

(defvar repetition-counter  0
  "How often 'cycle-on-repetition' was called in a row using the same command.")

(defun cycle-on-repetition (list-of-expressions)
  "Return the first element from the list on the first call.
      the second expression on the second consecutive call. etc"
  (interactive)
  (if (equal this-command last-command)
      (setq repetition-counter (+ repetition-counter  1))  ;; then
    (setq repetition-counter  0))  ;; else
  (nth
   (mod repetition-counter (length list-of-expressions))
   list-of-expressions))  ;; implicit return of the last evaluated value

(defun my-reformat-paragraph ()
  "Cycles the paragraph between three states: filled/unfilled/fill-sentences."
  (interactive)
  (funcall (cycle-on-repetition '(org-fill-paragraph fill-sentences-in-paragraph unfill-paragraph))))

(map! :after org
      :map org-mode-map
      [remap fill-paragraph] #'my-reformat-paragraph)

(provide 'my-reformat-paragraph)
;;; my-reformat-paragraph.el ends here
