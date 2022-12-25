(when (>= emacs-major-version 24)
  (progn
    ;; load emacs 24's package system. Add MELPA repository.
    (require 'package)
    (add-to-list
     'package-archives
     '("melpa" . "https://melpa.org/packages/")
     t))

  (when (< emacs-major-version 27) (package-initialize)))
