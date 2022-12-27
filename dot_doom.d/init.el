;;; init.el --- Description -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2022 Benjamin Carlsson
;;
;; Author: Benjamin Carlsson <glacials@dualla.lan>
;; Maintainer: Benjamin Carlsson <glacials@dualla.lan>
;; Created: December 27, 2022
;; Modified: December 27, 2022
;; Version: 0.0.1
;; Keywords: abbrev bib c calendar comm convenience data docs emulations extensions faces files frames games hardware help hypermedia i18n internal languages lisp local maint mail matching mouse multimedia news outlines processes terminals tex tools unix vc wp
;; Homepage: https://github.com/glacials/init
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  Description
;;
;;; Code:



(provide 'init)

(setq gofmt-command "goimports")
(add-hook 'before-save-hook 'gofmt-before-save)

;;; init.el ends here
