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
  (require 'eshell)
  (require 'smartparens)
  (require 'vertico)
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
  (keymap-set global-map            "C-c a" #'tray-evilem-motion)
  (keymap-set global-map            "C-c v v" #'tray-vertico-menu)
  (keymap-set evil-normal-state-map "SPC v v" #'tray-vertico-menu)
  (keymap-set global-map            "C-M-]" #'tray-smart-parens)
  (keymap-set evil-normal-state-map "SPC l u" #'tray-lookup)
  (keymap-set global-map            "<f7>" #'tray-lookup)
  (keymap-set global-map            "C-c t l" #'tray-lookup)
  (keymap-set global-map            "C-c t g" #'tray-epa-dispatch)
  (keymap-set global-map            "C-c t y" #'tray-epa-key-list-dispatch)
  (keymap-set global-map            "C-c t a" #'tray-evilem-motion)
  (keymap-set global-map            "C-c t v" #'tray-vertico-menu)
  (keymap-set global-map            "C-c t ]" #'tray-smart-parens)
  (keymap-set global-map            "C-c t t" #'tray-term)
  )

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

;;;###autoload (autoload 'tray-evilem-motion "tray" nil t)
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

;;; vertico-menu

;;;###autoload (autoload 'tray-vertico-menu "tray" nil t)
(transient-define-prefix tray-vertico-menu ()
  "Prefix that is bound to easymoition."
  ["vertico menu"
   ["commands"
    ("h" "Repeat selected Vertico session." vertico-repeat-select)
    ("'" "Repeat last Vertico session." vertico-repeat-previous)
    ("x" "Exit minibuffer with input." vertico-exit-input)
    ("s" "Save current candidate to kill ring." vertico-save)]
   ["embark actions"
    ("E" "Embark export to buffer" embark-export)
    (";" "Export to writable buffer if possible." +vertico/embark-export-write)
    ("l" "Embark collect verbatim" embark-collect)
    ("f" "Runs consult-fd" +vertico/consult-fd-or-find)]
   ["toggle vertico-modes"
    ("g" "toggle grid-mode" vertico-multiform-grid)
    ("b" "toggle buffer-mode" vertico-multiform-buffer)
    ("v" "toggle vertico+vertical-mode" vertico-multiform-vertical)]
   ["set vertico-mode"
    ("G" "grid-mode" vertico-grid-mode)
    ("B" "buffer-mode" vertico-buffer-mode)
    ("i" "indexed: Prefix candidates with hints." vertico-indexed-mode)
    ("m" "multiform: makes it possible to use other modes" vertico-multiform-mode)
    ("V" "mode-vertico" vertico-mode)]])

;;; smartparens

;;;###autoload (autoload 'tray-smart-parens "tray" nil t)
(transient-define-prefix tray-smart-parens ()
  "prefix that is bound to smart parens."
  ["smart-parens"
   ["forward"
    ("e" "end-of-sexp" sp-end-of-sexp)
    ("f" "forward-sexp" sp-forward-sexp)
    ("d" "down-sexp" sp-down-sexp)
    ("n" "next-sexp" sp-next-sexp)]
   ["backward"
    ("a" "beginning-of-sexp" sp-beginning-of-sexp)
    ("b" "backward-sexp" sp-backward-sexp)
    ("p" "previous-sexp" sp-previous-sexp)
    ("u" "up-sexp" sp-up-sexp)]
   ["edit"
    ("k" "kill-sexp" sp-kill-sexp)
    ("t" "transpose-sexp" sp-transpose-sexp)
    ("]" "forward-slurp-sexp" sp-forward-slurp-sexp)
    ("<backspace>" "splice-sexp" sp-splice-sexp)]])

;;; term
;;;

;;;###autoload (autoload 'tray-term "tray" nil t)
(transient-define-prefix tray-term ()
  "Prefix that is bound to terms."
  ["terminals"
   ["eshell"
    ("e" "eshell toggle" +eshell/toggle)
    ("E" "eshell here" +eshell/here)]
   ["v-term"
    ("v" "v-term toggle" +vterm/toggle)
    ("V" "v-term here" +vterm/here)
    ("o" "v-term other window" vterm-other-window)]])

;;; lookup
;;;

;;;###autoload (autoload 'tray-lookup "tray" nil t)
(transient-define-prefix tray-lookup ()
  "Prefix that is bound to a lookup transient."
  ["lookup"
   ["word lookup"
    ("d" "dict 1913" dictionary-lookup-definition)
    ("w" "wiki summary" wiki-summary)
    ("s t" "wordnut" +lookup/dictionary-definition)
    ("s T" "word replacement syn" +lookup/synonyms)
    ("t l" "word PT" powerthesaurus-lookup-dwim)
    ("t d" "word PT" powerthesaurus-lookup-definitions-dwim)
    ("t r" "word PT" powerthesaurus-lookup-related-dwim)
    ("t ." "word PT" powerthesaurus-lookup-sentences-dwim)
    ("t s" "syn PT" powerthesaurus-lookup-synonyms-dwim)
    ("t a" "ant PT" powerthesaurus-lookup-antonyms-dwim)]
   ["online engine (C-x /)"
    ("b" "search brave" engine/search-brave)
    ("m" "search melpa" engine/search-melpa)
    ("u" "search aur" engine/search-aur)
    ("a" "search archwiki" engine/search-archwiki)
    ("p" "presearch" engine/search-presearch)
    ("h" "github general" engine/search-github)
    ("g" "github code aware" engine/search-githubcs)]
   ["online +lookup (spc s)"
    ("O" "select source online" +lookup/online-select)
    ("o" "last-selected online" +lookup/online)]
   ["code lookups (spc)"
    ("f" "code file paths opened" +lookup/file)
    ("c d" "code definition" +lookup/definition)
    ("c D" "code reference" +lookup/references)
    ("c k" "code documentation(K)" +lookup/documentation)
    ("s k" "local docs" +lookup/in-docsets)
    ("F" "describe function" describe-function)
    ("v" "describe variable" describe-variable)]])
;;; _
(provide 'tray)
;;; tray.el ends here
