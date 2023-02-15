					; straight-use-package bootstrap; allows us to load a blank Emacs and have all our packages get installed just by seeing this files
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

					; Start server
(load "server")
(unless (server-running-p) (server-start))

;; START Install and configure packages ;;

					; Smart & opinionated indentation
(straight-use-package 'aggressive-indent)
(global-aggressive-indent-mode 1)
(add-to-list 'aggressive-indent-excluded-modes 'html-mode)

(straight-use-package 'chezmoi)  ; Dotfiles management
(require 'chezmoi)

					; Autocompletion
(straight-use-package 'company)
(setq company-idle-delay 0)
(setq company-minimum-prefix-length 1)

; GitHub Copilot (unofficial)
(straight-use-package '(copilot :type git :host github :repo "zerolfx/copilot.el" :files ("dist" "*.el")))
(add-hook 'prog-mode-hook 'copilot-mode)
(defun my/copilot-tab () (interactive) (or (copilot-accept-completion) (indent-for-tab-comment)))
(with-eval-after-load 'copilot (define-key copilot-mode-map (kbd "<tab>") #'my/copilot-tab))

(straight-use-package 'dockerfile-mode) ; Dockerfile syntax highlighting

; Set theme
(straight-use-package 'doom-themes)
(setq doom-themes-enable-bold t doom-themes-enable-italic t)
(load-theme 'doom-monokai-pro t)

(straight-use-package 'exec-path-from-shell) ; Use $PATH from shell, even if booted from e.g. dock. Needed to find e.g. LSP servers
(when (memq window-system '(mac ns x)) (exec-path-from-shell-initialize))

; Go
(straight-use-package 'go-mode)
(defun lsp-go-install-save-hooks () (add-hook 'before-save-hook #'lsp-format-buffer t t) (add-hook 'before-save-hook #'lsp-organize-imports t t))
(add-hook 'go-mode-hook #'lsp-go-install-save-hooks)
(add-hook 'go-mode-hook #'lsp-deferred)

(straight-use-package 'hcl-mode) ; HashiCorp Configuration Language
(straight-use-package 'lsp-mode) ; Language Server Protocol
(straight-use-package 'lsp-ui)   ; LSP UI upgrades

					; Stop macOS Emacs from quitting when last frame exits (disabled until I prove to myself I need it)
; (straight-use-package 'mac-pseudo-daemon)
; (mac-psuedo-daemon-mode)

(straight-use-package 'magit) ; Git in Emacs

; Docstrings in M-x et al.
(straight-use-package 'marginalia)
(marginalia-mode)

					;################################################## org-mode start #
(straight-use-package 'org)
(setq org-directory "~/org")
(setq org-default-notes-file (concat org-directory "/notes.org"))
(setq org-startup-indented t) ; Hide the first n-1 stars on level n headings
(global-set-key (kbd "C-c o") (lambda () (interactive) (find-file "~/org/notes.org"))) ; Access org-mode index with C-c o
(global-set-key (kbd "C-c c") 'org-capture)
(setq org-capture-templates ; Set org-capture
      '(("t" "Log a TODO entry" entry (file+olp+datetree "~/org/notes.org" "Daily log") "* TODO %?")
	("h" "Log a new heading" entry (file+olp+datetree "~/org/notes.org" "Daily log") "* %?")))
(setq org-refile-targets '((nil :maxlevel . 99) (org-agenda-files :maxlevel . 99))) ; Allow refiling to any heading level (up to 99) up from default of 1
(advice-add 'org-todo :after 'org-save-all-org-buffers) ; Save org-mode buffers after changing a TODO state
(defun open-today () ; Open org file to today
  (find-file 'org-default-notes-file)
  (datetree-jump)
  )
(defun datetree-jump () ; Define M-x datetree-jump, which jumps to today in a datetree. See below for C-c t shortcut.
  (interactive)
  (let ((point (point)))
    (catch 'found
      (goto-char (point-max))
      (while (outline-previous-heading)
        (let* ((hl (org-element-at-point))
               (title (org-element-property :raw-value hl)))
          (when (member title (datetree-dates))
            (org-show-context)
            (setq point (point))
            (throw 'found t)))))
    (goto-char point)))
(defun datetree-dates ()
  (let (dates
        (day (string-to-number (format-time-string "%d")))
        (month (string-to-number (format-time-string "%m")))
        (year (string-to-number (format-time-string "%Y"))))
    (dotimes (i 365)
      (push (format-time-string "%F %A" (encode-time 1 1 0 (- day i) month year))
            dates))
    (nreverse dates)))
(global-set-key (kbd "C-c t") 'open-today) ; Jump to today in the current buffer's datetree (using the above function) with C-c t

					; org-todo
(setq org-todo-keywords '(
			  (sequence "TODO(t)" "STRT(s)" "BLKD(b)" "|" "DONE(d)" "CNCL(c)")
			  (sequence "[ ](T)" "[-](S)" "[?](B)" "|" "[X](D)" "[C](C)")
			  ))
					;################################################## org-mode end #

					; Project management
(straight-use-package 'projectile)
(require 'projectile)
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(projectile-mode +1)

					; Colorful parentheses
(straight-use-package 'rainbow-delimiters)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

(straight-use-package 'savehist) ; Save minibuffer histories; pairs with frecency of vertico
(straight-use-package 'try) ; Try out packages without installing them

; Better undo w/ history
(straight-use-package 'undo-fu)
(global-unset-key (kbd "C-z"))
(global-set-key (kbd "C-z")   'undo-fu-only-undo)
(global-set-key (kbd "C-S-z") 'undo-fu-only-redo)
(straight-use-package 'undo-fu-session)
(undo-fu-session-global-mode)

; Better completion than Ido
(straight-use-package 'vertico)
(vertico-mode)

					; Show available key sequence paths forward in minibuffer
(straight-use-package 'which-key)
(which-key-mode)
;; END Install and configure packages ;;

;; START General configuration ;;
(setq user-full-name "Benjamin Carlsson" user-mail-address "ben@twos.dev")
(ido-mode 1) ; Autocomplete M-x among other things
(tool-bar-mode -1) ; Don't show the GUI toolbar
(setq display-line-numbers-type t) ; Show line numbers
(setq ido-enable-flex-matching t) ; Don't require exact matches in ido-mode

					; Modifier keys
(setq mac-option-modifier 'super) ; Make Option key act as Super
(setq ring-bell-function 'ignore) ; Disable the audible bell
;; END General configuration ;;
