;; -*- no-byte-compile: t; -*-
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

(package! ac-ispell)
(package! ac-capf)
(package! auto-complete)
(package! all-the-icons)
(package! auto-package-update)
(package! avy)
(package! beacon)
(package! consult)
(package! corfu)
(package! dashboard)
(package! deft)
(package! doom-themes)
(package! elfeed)
(package! elfeed-goodies)
(package! elfeed-org)
(package! embark)
(package! embark-consult)
(package! key-chord)
(package! marginalia)
(package! markdown-mode)
(package! mixed-pitch)
(package! mpv)
(package! orca)
(package! orderless)
(package! org :built-in 'prefer)
;; (package! org)
(package! org-appear)
(package! org-superstar)
(package! pandoc)
(package! pandoc-mode)
(package! peep-dired)
(package! pdf-tools)
(package! rainbow-mode)
(package! saveplace-pdf-view)
(package! spray)
(package! treemacs-icons-dired)
(package! use-package)
(package! vertico)
(package! which-key)
(package! hydra)
(package! evil-snipe)
(package! evil-surround)
;; (package! avy)
;; (package! avy)
(package! org-pandoc-import
  :recipe (:host github
           :repo "tecosaur/org-pandoc-import"
           :files ("*.el" "filters" "preprocessors")))
(package! ytdl)
