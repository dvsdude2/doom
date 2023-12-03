;;; doom/myrepo/+config.el -*- lexical-binding: t; -*-

(defvar +config--wconf nil)
(defvar +config-workspace-name "*config*"
  "Name of the workspace created by `=config', dedicated to config.org.")

(defun +config--init ()
  (if-let (win (cl-find-if (lambda (b) (string-match-p "^\\*config:" (buffer-name b)))
                           (doom-visible-windows)
                           :key #'window-buffer))
      (select-window win)
    (call-interactively (lambda () (interactive) (find-file "~/.config/doom/config.org")))))

;;;###autoload
(defun =config ()
  "Activate (or switch to) `config.org' in its workspace."
  (interactive)
  (if (modulep! :ui workspaces)
      (progn
        (+workspace-switch +config-workspace-name t)
        (unless (memq (buffer-local-value 'major-mode
                                          (window-buffer (selected-window)))
                      '(org-mode))
          (doom/switch-to-scratch-buffer)
          (+config--init))
        (+workspace/display))
    (setq +config--wconf (current-window-configuration))
    (delete-other-windows)
    (switch-to-buffer (doom-fallback-buffer))
    (+config--init)))

;;;###autoload
(defun +config/quit ()
  (interactive)
  (if (modulep! :ui workspaces)
      (when (+workspace-exists-p +config-workspace-name)
        (+workspace/delete +config-workspace-name))
    (when (window-configuration-p +config--wconf)
      (set-window-configuration +config--wconf))
    (setq +config--wconf nil))
  (doom-kill-matching-buffers "^\\*config[:-]"))



(provide '+config)
;;; +config.el ends here
