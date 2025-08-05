;; straight-use-package bootstrap; allows us to load a blank Emacs and have all our packages get installed just by seeing this file
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

;; This file's job is only to bootstrap straight.el to install Org,
;; install Org, then tangle & run init.org. That is where the real
;; configuration happens using literate programming.
(straight-use-package 'org)
(org-babel-load-file (expand-file-name "config.org" user-emacs-directory))


