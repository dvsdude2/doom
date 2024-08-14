(";;; package --- summary
;;; Commentary:
;;; code:



;; org-use-speed-commands’ to a non-‘nil’ value
(setq org-use-speed-commands t)

;; looking at this for eww text to be centered?
;; pet poject Iam working on. 
(setq 
  shr-bullet    \"• \"       ;  Character for an <li> list item
  shr-indentation 14)        ;  Left margin

 
(defcustom which-key-paging-key \"<f5>\"
  \"Key to use for changing pages.
Bound after each of the prefixes in `which-key-paging-prefixes'\"
  :type 'string
  :version \"1.0\")


(cl-pushnew `((,(format \"\\\\`\\\\(C-c\\\\)\\\\ a\\\\'\" prefix-re))
                  nil . \"evilem\")
                which-key-replacement-alist)


;; doom/save-and-kill-buffer
;; a doom function copied here for reference
;;;;###autoload
(defun doom/save-and-kill-buffer ()
  \"Save the current buffer to file, then kill it.\"
  (interactive)
  (save-buffer)
  (kill-current-buffer))


(defun dired-preview--close-previews ()
  \"Kill preview buffers and delete their windows.\"
  (dired-preview--cancel-timer)
  (dired-preview--delete-windows)
  (dired-preview--kill-buffers)
  (dired-preview--kill-large-buffers))

;;;; my update readme file with ediff ;;;;
(defun my/readme-update-ediff ()
    \"Update git README\\\\ using ediff.\"
  (interactive)
  (ediff \"~/.config/doom/config.org\" \"~/.config/doom/README.org\"))



;;;; 'check-for' commands, eq: packages,modes,features,... ;;;;;;;;;;;;;;;;;;;;;
;;;; -----------------------------------------------------------------------;;;;

;;;; this will check for modes

(if (bound-and-true-p flymake-mode)
    (message \"flymake-mode is on\")
  (message \"flymake-mode is off\"))

;;;; this will check for modes
(featurep FEATURE &optional SUBFEATURE)

(if (featurep 'corfu 'corfu-history-mode)
    (message \"features are there!\")
  (message \"no features\"))

;; For people wondering how to check if a package.el package is installed,
;; use package-installed-p.

(if (package-installed-p corfu-history-mode)
    (message \"package is installed\")
  (message \"package is not intalled\"))

;; tell me when it happens
(when(feature-loaded-p 'foo
  (message \"foo is loaded!\"))

;; 
;; Try and figure out if FILE has already been loaded.
(help--loaded-p \"~/.config/emacs/.local/straight/repos/corfu/extensions\")


;;;; set 'browse-url-handlers' ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; -----------------------------------------------------------------------;;;;

/[a-zA-Z0-9_\\-]+  ;; a regex to match char after t.co... URL 

\"^https?://\\\\(t.co/[a-zA-Z0-9_]+\\\\)/\"
\"ttps://t.co/[a-z]*[A-Z][0-9]*\"
\"\\<(http[s]?|www\\.twitter\\.com/[a-zA-Z0-9_\\-]+/status/[0-9]+)\\\\>\"
\"pic.twitter.com/[a-zA-Z0-9]*\" ;; regex-build tested
\"\\\\(https?\\\\)://\\\\(www\\\\.)?twitter\\\\.com\\\\([^[:space:]\\t\\n\\r<]\\\\|$\\\\)\"  ;;this is what llm gave me
\"(?:https?:\\/\\/)?(?:www\\.)?youtu\\.?be(?:\\.com)?\\/?.*(?:watch|embed)?(?:.*v=|v\\/|\\/)([\\w\\-_]+)\\&\"  ;; llm ex. for youtube
(setq browse-url-handlers
      '((\"\\\\.\\\\(gifv?\\\\|avi\\\\|AVI\\\\|mp[4g]\\\\|MP4\\\\|MP3\\\\|webm\\\\)$\" . my/mpv-play-url)
        (\"^https?://\\\\(www\\\\.youtube\\\\.com\\\\|youtu\\\\.be\\\\)/\" . my/mpv-play-url)
        (\"^https?://\\\\(odysee\\\\.com\\\\|rumble\\\\.com\\\\)/\" . my/mpv-play-url)
        ;; (\"^https?:\\/\\/((www\\.)?twitter\\.com\\/.+|t\\.co/[a-zA-Z0-9]+|x\\.com\\/.+)/\" . my/mpv-play-url)
        (\"^https?://\\\\(www\\\\.t.co/[a-zA-Z0-9]\\\\|x\\.com\\\\.com\\\\)/\" . my/mpv-play-url)
        (\"^https?://\\\\(off-guardian.org\\\\|.substack\\\\.com\\\\|tomluongo\\\\.me\\\\)/\" . dvs-eww)
        (\"^https?://\\\\(news.ycombinator.com\\\\)/\" . elfeed-open-hnreader-url)
        (\".\" . browse-url-default-browser)))

;;;; here's a 'regular-expression' that matches Twitter URLs: ;;;;;;;;;;;;;;;;
;;;; -----------------------------------------------------------------------;;;; 

```regex
https?:\\/\\/(www\\.)?twitter\\.com\\/.+
```

This regular expression will match URLs that begin with \"http://\" or \"https://\",
followed by \"www.twitter.com\" or \"twitter.com\",
and then any character sequence (`.+`).

Here's a breakdown of the regular expression:

- `https?:\\/\\/` - matches either \"http://\" or \"https://\"
- `(www\\.)?` - matches \"www.\" (optional)
- `twitter\\.com` - matches \"twitter.com\"
- `\\/.*` - matches any character sequence following \"twitter.com\"


;;;; possible replacement
;;;;  for one of the many \"new-buffer\" functions
(defun my/scratch-buffer-setup ()
    \"Add contents to `scratch' buffer and name it accordingly.
If region is active, add its contents to the new buffer.\"
    (let* ((mode major-mode))
      (rename-buffer (format \"*Scratch for %s*\" mode) t)))
  (setf (alist-get \"\\\\*Scratch for\" display-buffer-alist nil nil #'equal)
        '((display-buffer-pop-up-window)))
  :hook (scratch-create-buffer . my/scratch-buffer-setup)
  :bind (\"C-c s\" . scratch))

;;;; 'whichkey-replacment' ;;;;

(which-key-replacement-alist (push '((nil . \"evilem-motion\") . (nil . \"em\"))))

matches any binding with the descriptions \"Prefix Command\" and
replaces the description with \"prefix\", ignoring the
corresponding key.
;; karthinks use of whichkey-replacment
(push '((\"\\\\`C-c a\\\\'\")
        nil . \"evilem-motion\"))
      (which-key-replacement-alist)

((\"\\\\`M-SPC m g\\\\'\")
   nil . \"goto\")

(((nil . \"which-key-show-next-page-no-cycle\")
  nil . \"wk next pg\")
 ((\"<left>\")
  \"←\")
 ((\"<right>\")
  \"→\")
 ((\"<\\\\([[:alnum:]-]+\\\\)>\")
  \"\\\\1\"))

 (dired-preview--kill-buffers)

(setq! dired-preview--buffers-threshold 1024)
(setq! dired-preview--buffers-threshold 1024000)
;;   \"Maximum cumulative buffer size of previews.
;; When the accumulated preview buffers exceed this number and
;; `dired-preview--kill-buffers' is called, it will kill buffers
;; until it drops below this number.\")

(map! \"<f5> w\" :desc \"which-key-next-page-cycle\" #'which-key-show-next-page-cycle)




;; (provide 'flycheck)
;;; flycheck ends here
" 4493 emacs-lisp-mode)