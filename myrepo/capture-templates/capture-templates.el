;;; ~/.config/doom/myrepo/capture-templates/capture-templates.el -*- lexical-binding:t -*-
;; brings up a buffer for capturing
(defun set-org-capture-templates ()
  (setq! org-capture-templates
         '(("t" "todo Personal" entry
            (file+headline +org-capture-todo-file "Inbox")
            "** TODO %?\n%i\n%a" :prepend t)
           ("n" "notes Personal" entry
            (file+headline +org-capture-notes-file "Inbox")
            "** %?\n%i\n%a" :prepend t)
           ("z" "organizer" entry
            (file+headline "~/org/organizer.org" "refile stuff")
            "** NEW %?\n  %i\n  " :prepend t)
           ("y" "tilt" entry
            (file+headline "~/org/wiki/tilt-doom.org" "TILT")
            "** NEW %?\n  %i\n  " :prepend t)
           ("s" "journal-schedule" plain #'org-journal-date-location
            "** TODO %?\n <%(princ org-journal--date-location-scheduled-time)>\n" :jump-to-captured t)
           ("j" "Journal entry" plain #'org-journal-find-location
            "** %(format-time-string org-journal-time-format)%?" :prepend t)
           ("k" "keybindings" entry
            (file+headline "~/org/wiki/my-keybinding-list.org" "new ones")
            "** NEW %?\n  %i\n  " :prepend t)
           ("x" "webmarks" entry
            (file+headline "~/org/webmarks.org" "bookmarks")
            "** %^{link} %^g\n- %^{note}\n%^{image url}"
            :immediate-finish t :prepend t)
           ("l" "check out later" entry
            (file+headline "todo.org" "Check out later")
            "** IDEA %?\n%i\n%a" :prepend t)
           ("r" "remember")
           ("rd" "drill-template" entry
            (file+headline "~/org/wiki/drill.org" "questions")
            "** %^{category} :drill:\n%^{question}\n*** answer\n%^{answer}\n*** notes\n%^{notes}"
            :immediate-finish t :prepend t)
           ("rt" "remember-this" entry
            (file+headline +org-capture-todo-file "Inbox")
            "** NOTE %?\n%i\n%a" :prepend t)
           ("ru" "Task: Read this URL" entry
            (file+headline "tasks.org" "Articles To Read")
            ,(concat "* TODO Read article: '%:description'\nURL: %c\n\n")
            :empty-lines 1 :immediate-finish t)
           ("rw" "Capture web snippet" entry
            (file+headline "my-facts.org" "Inbox")
            ,(concat "* Fact: '%:description' :" (format "%s" org-drill-question-tag)
                     ":\n:PROPERTIES:\n:DATE_ADDED: %u\n:SOURCE_URL: %c\n:END:\n\n%i\n%?\n")
            :empty-lines 1 :immediate-finish t)
           )))
