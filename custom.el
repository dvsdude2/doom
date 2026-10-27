(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(calendar-holidays
   '((holiday-fixed 1 1 "New Year's Day")
     (holiday-float 1 1 3 "Martin Luther King Day")
     (holiday-fixed 2 2 "Groundhog Day") (holiday-fixed 2 14 "Valentine's Day")
     (holiday-float 2 1 3 "President's Day")
     (holiday-fixed 3 17 "St. Patrick's Day")
     (holiday-fixed 4 1 "April Fools' Day") (holiday-float 5 0 2 "Mother's Day")
     (holiday-float 5 1 -1 "Memorial Day") (holiday-fixed 6 14 "Flag Day")
     (holiday-float 6 0 3 "Father's Day") (holiday-fixed 7 4 "Independence Day")
     (holiday-float 9 1 1 "Labor Day") (holiday-float 10 1 2 "Columbus Day")
     (holiday-fixed 10 31 "Halloween") (holiday-fixed 11 11 "Veteran's Day")
     (holiday-float 11 4 4 "Thanksgiving") (holiday-easter-etc)
     (holiday-fixed 12 25 "Christmas")
     (if calendar-christian-all-holidays-flag
         (append (holiday-fixed 1 6 "Epiphany")
                 (holiday-julian 12 25 "Christmas (Julian calendar)")
                 (holiday-greek-orthodox-easter)
                 (holiday-fixed 8 15 "Assumption") (holiday-advent 0 "Advent")))
     (holiday-hebrew-passover) (holiday-hebrew-rosh-hashanah)
     (holiday-hebrew-hanukkah) (holiday-chinese-new-year)
     (solar-equinoxes-solstices)
     (holiday-sexp calendar-daylight-savings-starts
      (format "Daylight Saving Time Begins %s"
              (solar-time-string
               (/ calendar-daylight-savings-starts-time (float 60))
               calendar-standard-time-zone-name)))
     (holiday-sexp calendar-daylight-savings-ends
      (format "Daylight Saving Time Ends %s"
              (solar-time-string
               (/ calendar-daylight-savings-ends-time (float 60))
               calendar-daylight-time-zone-name)))))
 '(org-agenda-files
   '("/home/dvsdude/org/notable-dates.org" "/home/dvsdude/org/notes.org"
     "/home/dvsdude/org/organizer.org" "/home/dvsdude/org/projects.org"
     "/home/dvsdude/org/tasks.org" "/home/dvsdude/org/todo.org"
     "/home/dvsdude/org/webmarks.org"))
 '(warning-suppress-types
   '((emacs) (straight package) (defvaralias) (lexical-binding))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ediff-current-diff-A ((t (:background "#663333"))))
 '(ediff-current-diff-B ((t (:background "#336633"))))
 '(ediff-fine-diff-A ((t (:background "indian red"))))
 '(ediff-fine-diff-B ((t (:background "#558855"))))
 '(org-document-title ((t (:height 1.8 :underline t))))
 '(org-level-1 ((t (:inherit outline-1 :height 1.5))))
 '(org-level-2 ((t (:inherit outline-2 :height 1.2))))
 '(org-level-3 ((t (:inherit outline-3 :height 1.1))))
 '(org-level-4 ((t (:inherit outline-4 :height 1.0))))
 '(org-level-5 ((t (:inherit outline-5 :height 1.0)))))
(put 'narrow-to-region 'disabled nil)
