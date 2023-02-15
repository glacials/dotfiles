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

;; START Install and configure packages ;;
(straight-use-package 'chezmoi)  ; Dotfiles management

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

(straight-use-package 'magit)

; org-mode
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
(global-set-key (kbd "C-c t") 'datetree-jump) ; Jump to today in the current buffer's datetree (using the above function) with C-c t

; Add "frecency" to M-x completion
(straight-use-package 'smex)
(global-set-key (kbd "M-x") 'smex)

(straight-use-package 'which-key) ; Show available key sequence paths forward in minibuffer
;; END Install and configure packages ;;

;; START General configuration ;;
(setq user-full-name "Benjamin Carlsson" user-mail-address "ben@twos.dev")
(ido-mode 1) ; Autocomplete M-x among other things
(tool-bar-mode -1) ; Don't show the GUI toolbar
(setq display-line-numbers-type t) ; Show line numbers
(setq ido-enable-flex-matching t) ; Don't require exact matches in ido-mode

					; Modifier keys
(setq mac-option-modifier 'super) ; Make Option key act as Super
;; END General configuration ;;
