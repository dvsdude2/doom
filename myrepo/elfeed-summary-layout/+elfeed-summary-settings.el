;;; myrepo/elfeed-summary-layout/+elfeed-summary-settings.el --- elfeed summary settings -*- lexical-binding: t -*-
;;
;;; Commentary:
;; separate file for layout config. makes more sense for editing.
;;
;;; Code:
(setq elfeed-summary-settings
      '((group (:title . "today")
               (:elements
                (search
                 (:filter . "@1-day-ago")
                 (:title . ""))))
        (group (:title . "Daily")
               (:elements
                (query . day))
               (:hide t))
        (group (:title . "searches Days")
               (:elements
                (group (:title . "2 days")
                       (:elements
                        (search (:filter . "@2-day-ago")
                                (:title . "")))
                       (:hide t))
                (group (:title . "3 days")
                       (:elements
                        (search (:filter . "@3-day-ago")
                                (:title . "")))
                       (:hide t))
                (group (:title . "4 days")
                       (:elements
                        (search (:filter . "@4-day-ago")
                                (:title . "")))
                       (:hide t))
                (group (:title . "1 week")
                       (:elements
                        (search (:filter . "@7-day-ago")
                                (:title . "")))
                       (:hide t))
                (group (:title . "2 weeks")
                       (:elements
                        (search (:filter . "@2-weeks-ago")
                                (:title . "")))
                       (:hide t))
                (group (:title . "3 weeks")
                       (:elements
                        (search (:filter . "@3-weeks-ago")
                                (:title . "")))
                       (:hide t))
                (group (:title . "1 month")
                       (:elements
                        (search (:filter . "@1-month-ago")
                                (:title . "")))
                       (:hide t))
                (group (:title . "2 months")
                       (:elements
                        (search (:filter . "@2-month-ago")
                                (:title . "")))
                       (:hide t))
                (group (:title . "3 months")
                       (:elements
                        (search (:filter . "@3-month-ago")
                                (:title . "")))
                       (:hide t))
                (group (:title . "4 months")
                       (:elements
                        (search (:filter . "@4-month-ago")
                                (:title . "")))
                       (:hide t))
                (group (:title . "6 months")
                       (:elements
                        (search (:filter . "@6-months-ago +unread")
                                (:title . "+unread"))
                        (search (:filter . "@6-months-ago")
                                (:title . "+all")))))
               (:hide t))
        (group (:title . "stared")
               (:elements
                (search (:filter . "+star")
                        (:title . "")))
               (:hide t))
        (group (:title . "Videos")
               (:elements
                (group (:title . "truth")
                       (:elements
                        (query . (and vid truth)))
                       (:hide t))
                (group (:title . "humor")
                       (:elements
                        (query . (and vid fun)))
                       (:hide t))
                (group (:title . "real")
                       (:elements
                        (query . (and vid real)))
                       (:hide t))
                (group (:title . "history")
                       (:elements
                        (query . (and vid hist)))
                       (:hide t))
                (group (:title . "emacs")
                       (:elements
                        (query . (and vid emacs)))
                       (:hide t))
                (group (:title . "websites")
                       (:elements
                        (query . (and vid web)))
                       (:hide t))
                (group (:title . "youtube")
                       (:elements
                        (query . (and vid yt)))
                       (:hide t))
                (group (:title . "odysee")
                       (:elements
                        (query . (and vid odys)))
                       (:hide t))
                (group (:title . "bitchute")
                       (:elements
                        (query . (and vid bit)))))
               (:hide t))
        (group (:title . "forums")
               (:elements
                (query . forum))
               (:hide t))
        (group (:title . "Humor")
               (:elements
                (query . fun))
               (:hide t))
        (group (:title . "Repos")
               (:elements
                (query . github))
               (:hide t))
        (group (:title . "Doom")
               (:elements
                (query . doom))
               (:hide t))
        (group (:title . "Emacs")
               (:elements
                (query . emacs))
               (:hide t))
        (group (:title . "Linux")
               (:elements
                (query . linux))
               (:hide t))
        (group (:title . "Corbett")
               (:elements
                (query . corbett))
               (:hide t))
        (group (:title . "science")
               (:elements
                (query . sci))
               (:hide t))
        (group (:title . "Substack")
               (:elements
                (query . sub))
               (:hide t))
        (group (:title . "searches all")
               (:elements
                (group (:title . "ungrouped")
                       (:elements :misc))))))
(provide 'elfeed-summary-settings)
;;; +elfeed-summary-settings.el ends here
