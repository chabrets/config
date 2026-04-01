;; --- Customization file management ---
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file 'noerror)

;; --- UI and Aesthetics ---
(setq inhibit-startup-screen t)
(load-theme 'tango-dark t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(global-display-line-numbers-mode 1)

;; --- Indentation and Tabs (Python friendly) ---
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)

;; --- Whitespace visualization (Dots for spaces) ---
(setq whitespace-style '(face spaces tabs space-mark tab-mark trailing))
(setq whitespace-display-mappings
      '((space-mark   32 [183] [46])  ; Space (32) displayed as mid-dot (·)
        (tab-mark     9  [187 9] [92 9]))) ; Tab (9) displayed as »
(global-whitespace-mode 1)

;; --- Quality of Life ---
(save-place-mode 1)     ; Remember cursor position in files
(electric-pair-mode 1)  ; Auto-close brackets () [] {}
