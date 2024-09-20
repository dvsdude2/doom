;;; tray.el --- Various transient menus  -*- lexical-binding:t -*-

;; Copyright (C) 2021-2024 Jonas Bernoulli

;; Author: Jonas Bernoulli <emacs.tray@jonas.bernoulli.dev>
;; Homepage: https://github.com/tarsius/tray
;; Keywords: convenience

;; Package-Version: 0.1.4
;; Package-Requires: ((emacs "27.1") (compat "30.0.0.0") (transient "0.7.4"))

;; SPDX-License-Identifier: GPL-3.0-or-later

;; This file is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published
;; by the Free Software Foundation, either version 3 of the License,
;; or (at your option) any later version.
;;
;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this file.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; Transient menus for a wide variety of things.

;; For suggested key bindings see
;; (find-function 'tray-add-suggested-bindings).

;; A few of my transient menus are distributed separately:
;; - [[https://git.sr.ht/~tarsius/notmuch-transient][notmuch-transient]]

;;; Code:

(require 'compat)
(require 'transient)

(eval-when-compile
  (require 'epa)
  (require 'evil)
  )

(defvar tray-add-suggested-bindings t
  "Whether to add all suggested key bindings.
This has to be set before `tray' is loaded.  Afterwards
you have to call the function by the same name instead.")

(defun tray-add-suggested-bindings ()
  "Add all suggested key bindings.
If you would rather cherry-pick some bindings, then
start by looking at the definition of this function."
  (keymap-set global-map            "C-c C-g" #'tray-epa-dispatch)
  (keymap-set epa-key-list-mode-map "C-c C-g" #'tray-epa-key-list-dispatch)
  (keymap-set global-map            "C-c a"   #'tray-evilem-motion)
  )
;; (map! (:after evil-easymotion
;;       :prefix "C-c"
;;       :nivm "a" #'tray-evilem-motion))

 (when tray-add-suggested-bindings
   (tray-add-suggested-bindings))

;;; epa, epa-keys

;;;###autoload (autoload 'tray-epa-dispatch "tray" nil t)
(transient-define-prefix tray-epa-dispatch ()
  "Select and invoke an EasyPG command from a list of available commands."
  [[("l p" "list public keys"   epa-list-keys)
    ("l s" "list secret keys"   epa-list-secret-keys)
    ("i p" "insert public keys" epa-insert-keys)]])


;;;###autoload (autoload 'tray-epa-key-list-dispatch "tray" nil t)
(transient-define-prefix tray-epa-key-list-dispatch ()
  "Select and invoke an EasyPG command from a list of available commands."
  :transient-suffix     #'transient--do-call
  :transient-non-suffix #'transient--do-stay
  [[("m" "mark"      epa-mark-key)
    ("u" "unmark"    epa-unmark-key)]
   [("e" "encrypt"   epa-encrypt-file)
    ("d" "decrypt"   epa-decrypt-file)]
   [("s" "sign"      epa-sign-file)
    ("v" "verify"    epa-verify-file)]
   [("i" "import"    epa-import-keys)
    ("o" "export"    epa-export-keys)
    ("r" "delete"    epa-delete-keys)]
   [("g  " "refresh"          revert-buffer)
    ("l p" "list public keys" epa-list-keys)
    ("l s" "list secret keys" epa-list-secret-keys)]
   [("n" "move up"   next-line)
    ("p" "move down" previous-line)
    ("q" "exit"      epa-exit-buffer :transient nil)]])

;;; evilem

;;;###autoload (autoload 'tray-evilem-notion "tray" nil t)
(transient-define-prefix tray-evilem-motion ()
  "Prefix that is bound to easymoition."
  ["easy motion"
   ["forward" ("/" "avy goto char timer" evil-avy-goto-char-timer)
    ("SPC" "avy goto char timer" evil-avy-goto-char-timer)
    ("s" "avy goto char 2" evil-avy-goto-char-2)
    ("a" "forward argument" evilem--motion-function-evil-forward-arg)
    ("+" "next line first non-blank" evilem-motion-next-line-first-non-blank)
    ("*" "search word forward" evilem-motion-search-word-forward)
    ("n" "search-next" evilem-motion-search-next)
    ("E" "forward-WORD-end" evilem-motion-forward-WORD-end)
    ("e" "forward-word-end" evilem-motion-forward-word-end)
    ("W" "forward-WORD-begin" evilem-motion-forward-WORD-begin)
    ("w" "forward-word-begin" evilem-motion-forward-word-begin)]
    ["backward" ("A" "backward argument" evilem--motion-function-evil-backward-arg)
    ("#" "search word backwards" evilem-motion-search-word-backward)
    ("-" "previous line first non-blank" evilem-motion-previous-line-first-non-blank)
    ("N" "search-previous" evilem-motion-search-previous)
    ("B" "backward-WORD-begin" evilem-motion-backward-WORD-begin)
    ("b" "backward-word-begin" evilem-motion-backward-word-begin)
    ]])

;;; _
(provide 'tray)
;;; tray.el ends here
