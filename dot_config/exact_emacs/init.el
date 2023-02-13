(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'chezmoi)  ; Dotfiles management
(straight-use-package '(copilot :type git :host github :repo "zerolfx/copilot.el"))

; Set theme
(straight-use-package 'doom-themes)
(setq doom-themes-enable-bold t doom-themes-enable-italic t)
(load-theme 'doom-monokai-pro)

(straight-use-package 'go-mode)  ; Go support
(straight-use-package 'hcl-mode) ; HashiCorp Configuration Language
(straight-use-package 'mac-pseudo-daemon) ; Stop macOS Emacs from quitting when last frame exits
(straight-use-package 'magit :ensure t)
(straight-use-package 'org :ensure t)

					; Visual customizations
(tool-bar-mode -1) ; Don't show the GUI toolbar
