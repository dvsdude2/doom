;;; $DOOMDIR/packages.el
;; To install a package with Doom you must declare them here and run 'doom sync'
;; on the command line, then restart Emacs for the changes to take effect -- or
;; use 'M-x doom/reload'.


;; To install SOME-PACKAGE from MELPA, ELPA or emacsmirror:
;(package! some-package)

;; To install a package directly from a remote git repo, you must specify a
;; `:recipe'. You'll find documentation on what `:recipe' accepts here:
;; https://github.com/raxod502/straight.el#the-recipe-format
;(package! another-package
;  :recipe (:host github :repo "username/repo"))

;; If the package you are trying to install does not contain a PACKAGENAME.el
;; file, or is located in a subdirectory of the repo, you'll need to specify
;; `:files' in the `:recipe':
;(package! this-package
;  :recipe (:host github :repo "username/repo"
;           :files ("some-file.el" "src/lisp/*.el")))

;; If you'd like to disable a package included with Doom, you can do so here
;; with the `:disable' property:
;(package! builtin-package :disable t)

;; You can override the recipe of a built in package without having to specify
;; all the properties for `:recipe'. These will inherit the rest of its recipe
;; from Doom or MELPA/ELPA/Emacsmirror:
;(package! builtin-package :recipe (:nonrecursive t))
;(package! builtin-package-2 :recipe (:repo "myfork/package"))

;; Specify a `:branch' to install a package from a particular branch or tag.
;; This is required for some packages whose default branch isn't 'master' (which
;; our package manager can't deal with; see raxod502/straight.el#279)
;(package! builtin-package :recipe (:branch "develop"))

;; Use `:pin' to specify a particular commit to install.
;(package! builtin-package :pin "1a2b3c4d5e")


;; Doom's packages are pinned to a specific commit and updated from release to
;; release. The `unpin!' macro allows you to unpin single packages...
;(unpin! pinned-package)
;; ...or multiple packages
;(unpin! pinned-package another-pinned-package)
;; ...Or *all* packages (NOT RECOMMENDED; will likely break things)
;(unpin! t)

(package! ag)
(package! beacon)
(package! cape)
(package! corfu
  :recipe (:host github
           :repo "minad/corfu"
           :files ("*.el" "extensions")))
(package! dashboard :pin "e9867036ebc100768023eabc21dd5bf4619029c2")
(package! define-word)
(package! dired-preview
  :recipe (:host github
           :repo "protesilaos/dired-preview"
           :files ("dired-preview.el")))
(package! dired-open)
(package! dired-subtree)
(package! dwim-shell-command)
(package! denote
  :recipe (:host github
           :repo "protesilaos/denote"
           :files ("*.el")))
(package! elfeed-curate)
(package! elfeed-summary)
(package! elfeed-tube)
(package! elfeed-tube-mpv)
(package! engine-mode)
(package! focus)
(package! hnreader)
(package! languagetool)
(package! journalctl-mode)
(package! key-chord)
(package! markdown-mode)
(package! monkeytype)
(package! mpv)
(package! orderless)
(package! org-appear)
(package! org-modern)
(package! org-ros)
(package! org-web-tools)
(package! org-xournalpp
  :recipe (:host gitlab
           :repo "vherrmann/org-xournalpp"
           :files ("resources" "*.el")))
(package! osm)
(package! pandoc)
(package! pomidor)
(package! pandoc-mode)
(package! plantuml-mode)
(package! rainbow-mode)
(package! reddigg)
(package! saveplace-pdf-view)
(package! browser-hist
  :recipe (:host github
           :repo "agzam/browser-hist.el"
           :files ("*.el")))
(package! which-key)
(package! hydra)
(package! pretty-hydra)  ;; dependency
(package! org-media-note
  :recipe (:host github
           :repo "yuchen-lea/org-media-note"
           :files ("*.el")))
(package! yeetube
  :recipe (:host nil
           :type git
           :repo "https://git.thanosapollo.org/yeetube"
           :files ("*.el")))
(package! yequake)
(package! youtube-sub-extractor)
(package! spray
 :recipe (:host nil
          :type git
          :repo "https://git.sr.ht/~iank/spray"
          :files ("*.el")))
