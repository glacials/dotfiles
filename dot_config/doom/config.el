;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!
;;
(add-to-list 'exec-path "~/go/bin")

(setq evil-respect-visual-line-mode t) ; make jk move by visual lines, not logical lines

(advice-add 'org-todo :after 'org-save-all-org-buffers)
(after! go-mode (add-hook 'go-mode-hook 'lsp-deferred))
(after! org (setq org-todo-keywords '((sequence
           "?(?)"
           "TODO(t!)"
           "BLKD(b@)"
           "STRT(s!)"
           "|"
           "CNCL(c@)"
           "DONE(d!)"
           )
         (sequence
          "[ ](T!)"
          "[-](S!)"
          "[?](W!)"
          "|"
          "[X](D!)"
          )
         (sequence
          "|"
          "OK(o!)"
          "YES (y!)"
          "NO (n!)"
          ))))

(after! org (setq org-todo-keyword-faces
      '(("?" . +org-todo-onhold)
        ("TODO" . org-todo)
        ("BLKD" . +org-todo-onhold)
        ("STRT" . +org-todo-active)
        ("CNCL" . org-done)
        ("DONE" . org-done)
        ("[ ]" . org-todo)
        ("[-]" . +org-todo-active)
        ("[?]" . +org-todo-onhold)
        ("[X]" . org-done)
        ("NO" . +org-todo-cancel)))
)

; Allow refiling to any heading level (up to 99), up from Doom's default of 9.
(setq org-refile-targets '
        ((nil :maxlevel . 99)
        (org-agenda-files :maxlevel . 99)))

;; accept completion from copilot and fallback to company
(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :bind (("C-TAB" . 'copilot-accept-completion-by-word)
         ("C-<tab>" . 'copilot-accept-completion-by-word)
         :map copilot-completion-map
         ("<tab>" . 'copilot-accept-completion)
         ("TAB" . 'copilot-accept-completion)))

; (setq org-log-into-drawer "LOGBOOK") ; When toggling TODOs, log the change in a drawer

(after! org (setq org-capture-templates
      '(("t" "Log TODO" entry (file+olp+datetree "~/org/notes.org" "Daily log") "* TODO %?")
        ("h" "Log heading" entry (file+olp+datetree "~/org/notes.org" "Daily log") "* %?")
        ("n" "Log note" item (file+olp+datetree "~/org/notes.org" "Daily log") "%?")
       )))

; Open index org file with C-c o
(global-set-key (kbd "C-c o") (lambda () (interactive) (find-file "~/org/notes.org")))

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Ben Carlsson"
      user-mail-address "ben@twos.dev")

; When quitting the last window/frame on macOS, keep the app open
(mac-pseudo-daemon-mode)

; Ido mode (fuzzy search for everything)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

;; Make pressing enter in org-mode headings, list items, etc. create another
;; one, instead of a blank line. (TODO: Also allow for pressing evil-mode's o or O.)
;;
;; From https://kitchingroup.cheme.cmu.edu/blog/2017/04/09/A-better-return-in-org-mode/
(require 'org-inlinetask)
(defun scimax/org-return (&optional ignore)
  "Add new list item, heading or table row with RET.
A double return on an empty element deletes it.
Use a prefix arg to get regular RET. "
  (interactive "P")
  (if ignore
      (org-return)
    (cond

     ((eq 'line-break (car (org-element-context)))
      (org-return-indent))

     ;; Open links like usual, unless point is at the end of a line.
     ;; and if at beginning of line, just press enter.
     ((or (and (eq 'link (car (org-element-context))) (not (eolp)))
          (bolp))
      (org-return))

     ;; It doesn't make sense to add headings in inline tasks. Thanks Anders
     ;; Johansson!
     ((org-inlinetask-in-task-p)
      (org-return))

     ;; checkboxes too
     ((org-at-item-checkbox-p)
      (org-insert-todo-heading nil))

     ;; lists end with two blank lines, so we need to make sure we are also not
     ;; at the beginning of a line to avoid a loop where a new entry gets
     ;; created with only one blank line.
     ((org-in-item-p)
      (if (save-excursion (beginning-of-line) (org-element-property :contents-begin (org-element-context)))
          (org-insert-heading)
        (beginning-of-line)
        (delete-region (line-beginning-position) (line-end-position))
        (org-return)))

     ;; org-heading
     ((org-at-heading-p)
      (if (not (string= "" (org-element-property :title (org-element-context))))
          (progn (org-end-of-meta-data)
                 (org-insert-heading-respect-content)
                 (outline-show-entry))
        (beginning-of-line)
        (setf (buffer-substring
               (line-beginning-position) (line-end-position)) "")))

     ;; tables
     ((org-at-table-p)
      (if (-any?
           (lambda (x) (not (string= "" x)))
           (nth
            (- (org-table-current-dline) 1)
            (org-table-to-lisp)))
          (org-return)
        ;; empty row
        (beginning-of-line)
        (setf (buffer-substring
               (line-beginning-position) (line-end-position)) "")
        (org-return)))

     ;; fall-through case
     (t
      (org-return)))))
(define-key org-mode-map (kbd "RET")
  'scimax/org-return)

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

(setq org-directory "~/org/") ; Must be set before org loads


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
