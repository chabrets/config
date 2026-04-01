(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file 'noerror)

(setq inhibit-startup-screen t)

(load-theme 'tango-dark t)

(menu-bar-mode 0)
(tool-bar-mode 0)
(global-display-line-numbers-mode)
