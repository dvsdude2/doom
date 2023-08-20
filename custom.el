(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(calendar-holidays
   '((holiday-fixed 1 1 "New Year's Day")
     (holiday-float 1 1 3 "Martin Luther King Day")
     (holiday-fixed 2 2 "Groundhog Day")
     (holiday-fixed 2 14 "Valentine's Day")
     (holiday-float 2 1 3 "President's Day")
     (holiday-fixed 3 17 "St. Patrick's Day")
     (holiday-fixed 4 1 "April Fools' Day")
     (holiday-float 5 0 2 "Mother's Day")
     (holiday-float 5 1 -1 "Memorial Day")
     (holiday-fixed 6 14 "Flag Day")
     (holiday-float 6 0 3 "Father's Day")
     (holiday-fixed 7 4 "Independence Day")
     (holiday-float 9 1 1 "Labor Day")
     (holiday-float 10 1 2 "Columbus Day")
     (holiday-fixed 10 31 "Halloween")
     (holiday-fixed 11 11 "Veteran's Day")
     (holiday-float 11 4 4 "Thanksgiving")
     (holiday-easter-etc)
     (holiday-fixed 12 25 "Christmas")
     (holiday-chinese-new-year)
     (if calendar-chinese-all-holidays-flag
         (append
          (holiday-chinese 1 15 "Lantern Festival")
          (holiday-chinese-qingming)
          (holiday-chinese 5 5 "Dragon Boat Festival")
          (holiday-chinese 7 7 "Double Seventh Festival")
          (holiday-chinese 8 15 "Mid-Autumn Festival")
          (holiday-chinese 9 9 "Double Ninth Festival")
          (holiday-chinese-winter-solstice)))
     (solar-equinoxes-solstices)
     (holiday-sexp calendar-daylight-savings-starts
      (format "Daylight Saving Time Begins %s"
              (solar-time-string
               (/ calendar-daylight-savings-starts-time
                  (float 60))
               calendar-standard-time-zone-name)))
     (holiday-sexp calendar-daylight-savings-ends
      (format "Daylight Saving Time Ends %s"
              (solar-time-string
               (/ calendar-daylight-savings-ends-time
                  (float 60))
               calendar-daylight-time-zone-name)))))
 '(elfeed-feeds
   '("http://emacstidbits.blogspot.com/atom.xml"
     ("https://discourse.doomemacs.org/posts.rss" doom)
     ("https://unherd.com/feed/" subs)
     ("https://theupheaval.substack.com/feed" subs)
     ("https://shrewviews.substack.com/feed" subs)
     ("https://meaninginhistory.substack.com/feed" subs)
     ("https://rudy.substack.com/feed" subs)
     ("https://github.com/doomemacs/doomemacs/commits/master.atom" github)
     ("https://github.com/dvsdude2/doom/commits/main.atom" github)
     ("https://planet.emacslife.com/atom.xml" emacs)
     ("https://xenodium.com/rss.xml" emacs)
     ("https://protesilaos.com/codelog.xml" emacs)
     ("https://pragmaticemacs.wordpress.com/feed/" emacs)
     ("https://ag91.github.io/rss.xml" emacs)
     ("https://emacstil.com/feed.xml" emacs)
     ("https://updates.orgmode.org/feed/updates" emacs)
     ("http://emacs.stackexchange.com/feeds" emacs)
     ("https://elpa.brause.cc/melpa.xml" emacs)
     ("https://off-guardian.org/feed/" news)
     ("https://www.corbettreport.com/articlerss.xml" corbet)
     ("https://www.corbettreport.com/solutionswatchrss.xml" corbet)
     ("https://www.corbettreport.com/qfcrss.xml" corbet)
     ("https://www.corbettreport.com/newrss.xml" corbet)
     ("https://www.reddit.com/r/orgmode/.rss" reddit emacs)
     ("https://www.reddit.com/r/DistroTube/.rss" reddit doom)
     ("https://www.reddit.com/r/DoomEmacs/.rss" reddit doom)
     ("https://www.reddit.com/r/emacs/.rss" reddit emacs)
     ("https://www.bitchute.com/feeds/rss/channel/sanity-for-sweden" bit video fun)
     ("https://www.bitchute.com/feeds/rss/channel/markdice" bit video fun)
     ("https://www.bitchute.com/feeds/rss/channel/amazingpolly" bit video truth)
     ("https://www.bitchute.com/feeds/rss/channel/Gor_Reacts" bit video fun)
     ("https://odysee.com/$/rss/@PaulJosephWatson:5" odys video news)
     ("https://odysee.com/$/rss/@BestEvidence:b" odys video real)
     ("https://odysee.com/$/rss/@GorTheMovieGod:7" odys video fun)
     ("https://odysee.com/$/rss/@SaltyCracker:a" odys video news)
     ("https://odysee.com/$/rss/@ComputingForever:9" odys video truth)
     ("https://odysee.com/$/rss/@AnythingGoes:2" odys video news)
     ("https://odysee.com/$/rss/@DistroTube:2" odys video doom)
     ("https://odysee.com/$/rss/@corbettreport:0" odys video truth)
     ("https://odysee.com/$/rss/@BrodieRobertson:5" odys video linux)
     ("https://odysee.com/$/rss/@academyofideas:3" odys video truth)
     ("https://odysee.com/$/rss/@AfterSkool:7" odys video truth)
     ("https://odysee.com/$/rss/@stevesteacher:0" odys video linux)
     ("https://odysee.com/$/rss/@truthstreammedia:4" odys video truth)
     ("https://odysee.com/$/rss/@DuckHK:b" odys video news)
     ("https://odysee.com/$/rss/@TheLostHistoryChannelTKTC:0" odys video hist truth)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCAiiOTio8Yu69c3XnR7nQBQ" video yt emacs)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UC7_gcs09iThXybpVgjHZ_7g" video yt sci)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UC2RCcnTltR3HMQOYVqwmweA" video yt emacs)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UC-qh8HCLNKlGhn-jOuEd3rg" video yt fun)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCYiI-drPAVQU74dSKVZ2Yjg" video yt fun)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UC91V6D3nkhP89wUb9f_h17g" video yt fun)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCNnKprAG-MWLsk-GsbsC2BA" video yt fun)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCOjc2LTXq55J0HNUMvNhvYw" video yt fun)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCJdmdUp5BrsWsYVQUylCMLg" video yt linux)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UC5L_M7BF5iait4FzEbwKCAg" video yt real)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCTiL1q9YbrVam5nP2xzFTWQ" video yt sci)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UC2eYFnH61tmytImy1mTYvhA" video yt)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UC4sEmXUuWIFlxRIFBRV6VXQ" video yt hist)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCYwVxWpjeKFWwu8TML-Te9A" video yt real)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCIMXKin1fXXCeq2UJePJEog" video yt real)
     ("https://youtube.com/feeds/videos.xml?channel_id=UCR1D15p_vdP3HkrH8wgjQRw" video yt fun)
     ("https://youtube.com/feeds/videos.xml?channel_id=UC8CsGpP6kVNrWeBVmlJ2UyA" video yt fun)
     ("https://youtube.com/feeds/videos.xml?channel_id=UC2Stn8atEra7SMdPWyQoSLA" video yt hist)
     ("https://youtube.com/feeds/videos.xml?channel_id=UC8Q7XEy86Q7T-3kNpNjYgwA" video yt fun)
     ("https://youtube.com/feeds/videos.xml?channel_id=UCsn6cjffsvyOZCZxvGoJxGg" video yt fun)
     ("https://youtube.com/feeds/videos.xml?channel_id=UCEq_Dr1GHvnNPQNfgOzhZ8Q" video yt fun)
     ("https://youtube.com/feeds/videos.xml?channel_id=UCBngnLwNNuEXwB6BvwZ0Ykw" video yt fun)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UC0uTPqBCFIpZxlz_Lv1tk_g" video yt emacs)
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCwP7WmjZpPLrCSaCFYf3KZQ" video yt fun)
     ("https://anchor.fm/s/a5967a8/podcast/rss" linux)
     ("https://www.debugpoint.com/feed" linux)
     ("https://goinglinux.com/oggpodcast.xml" linux)
     ("https://tomluongo.me/feed/" news)
     ("https://xkcd.com/rss.xml" fun)
     ("https://itsfoss.com/feed/" linux)
     ("https://opensourcemusings.com/feed/" linux)))
 '(global-hl-line-mode t)
 '(image-use-external-converter t)
 '(magit-todos-insert-after '(bottom) nil nil "Changed by setter of obsolete option `magit-todos-insert-at'")
 '(org-agenda-files
   '("/home/dvsdude/org/wiki/tilt-doom.org" "/home/dvsdude/org/wiki/my-keybinding-list.org" "/home/dvsdude/org/notes.org" "/home/dvsdude/org/organizer.org" "/home/dvsdude/org/projects.org" "/home/dvsdude/org/todo.org" "/home/dvsdude/org/journal/2023"))
 '(org-agenda-inhibit-startup nil)
 '(org-capture-templates
   '(("y" "TILT" entry
      (file+headline "~/org/wiki/tilt-doom.org " "TILT")
      "** NEW %?
           %i  " :prepend t)
     ("s" "notable dates" plain #'org-journal-date-location "** TODO %?
 <%(princ org-journal--date-location-scheduled-time)>
" :jump-to-captured t)
     ("j" "Journal entry" plain #'org-journal-find-location "** %(format-time-string org-journal-time-format)%?" :prepend t)
     ("k" "keybindings" entry
      (file+headline "~/org/wiki/my-keybinding-list.org" "new ones")
      "** NEW %?
  %i
  " :prepend t)
     ("z" "organizer" entry
      (file+headline "~/org/organizer.org" "refile stuff")
      "** NEW %?
  %i
  " :prepend t)
     ("x" "Cliplink capture task" entry
      (file+headline "~/org/webmarks.org" "bookmarks")
      "* TODO %(org-cliplink-capture)
SCHEDULED: %t
" :empty-lines 1)
     ("t" "Personal todo" entry
      (file+headline +org-capture-todo-file "Inbox")
      "** TODO %?
%i
%a" :prepend t)
     ("l" "check out later" entry
      (file+headline "todo.org" "Check out later")
      "** IDEA %?
%i
%a" :prepend t)
     ("n" "Personal notes" entry
      (file+headline +org-capture-notes-file "Inbox")
      "*  %?
%i
%a" :prepend t)
     ("p" "Templates for projects")
     ("pt" "Project-local todo" entry
      (file+headline +org-capture-project-todo-file "Inbox")
      "* TODO %?
%i
%a" :prepend t)
     ("pn" "Project-local notes" entry
      (file+headline +org-capture-project-notes-file "Inbox")
      "* %U %?
%i
%a" :prepend t)
     ("pc" "Project-local changelog" entry
      (file+headline +org-capture-project-changelog-file "Unreleased")
      "* %U %?
%i
%a" :prepend t)
     ("o" "Centralized templates for projects")
     ("ot" "Project todo" entry #'+org-capture-central-project-todo-file "* TODO %?
 %i
 %a" :heading "Tasks" :prepend nil)
     ("on" "Project notes" entry #'+org-capture-central-project-notes-file "* %U %?
 %i
 %a" :prepend t :heading "Notes")
     ("oc" "Project changelog" entry #'+org-capture-central-project-changelog-file "* %U %?
 %i
 %a" :prepend t :heading "Changelog")))
 '(org-journal-carryover-items "")
 '(org-journal-dir "/home/dvsdude/org/journal/")
 '(org-journal-enable-agenda-integration t)
 '(org-journal-file-format "%Y")
 '(org-journal-file-type 'yearly)
 '(org-journal-find-file 'find-file)
 '(org-journal-mode-hook
   '(auto-fill-mode doom-disable-line-numbers-h turn-on-visual-line-mode flyspell-mode))
 '(org-reverse-note-order t)
 '(org-startup-folded 'show2levels)
 '(org-use-property-inheritance t)
 '(org-web-tools-pandoc-sleep-time 0.5)
 '(package-selected-packages '(dwim-shell-command stem-reading-mode))
 '(sunshine-show-icons nil)
 '(sunshine-units 'metric)
 '(warning-suppress-types '((org) (defvaralias)))
 '(writeroom-local-effects '(flyspell-mode))
 '(writeroom-maximize-window nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(hl-line ((t (:extend t :background "#000000"))))
 '(org-document-title ((t (:height 1.7 :underline t))))
 '(org-level-1 ((t (:inherit outline-1 :height 1.4))))
 '(org-level-2 ((t (:inherit outline-2 :height 1.1))))
 '(org-level-3 ((t (:inherit outline-3 :height 1.0))))
 '(org-level-4 ((t (:inherit outline-4 :height 1.0))))
 '(org-level-5 ((t (:inherit outline-5 :height 1.0)))))
(put 'narrow-to-region 'disabled nil)
