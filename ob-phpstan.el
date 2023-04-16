;;; ob-phpstan.el --- Babel Functions for PHPStan    -*- lexical-binding: t; -*-

;; Copyright (C) 2023  Takeo Obara

;; Author: Takeo Obara <bararararatty@gmail.com>
;; Version: 0.0.1
;; Package-Requires: ((emacs "28") (org "9"))
;; Homepage: https://github.com/emacs-php/ob-phpstan
;; Keywords: tools, org, literate programming, reproducible research, php
;; License: GPL-3.0-or-later

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; Static analyze a block of PHP code with org-babel using PHPStan.

;;; Code:
(require 'org)
(require 'ob)

(defgroup ob-phpstan nil
  "org-mode blocks for PHPStan."
  :group 'org)

(defcustom org-babel-phpstan-command "phpstan"
  "The command to execute babel body code."
  :group 'ob-phpstan
  :type 'string)

(defcustom org-babel-phpstan-level 5
  "Set phpstan level."
  :group 'ob-phpstan
  :type 'number)

;;;###autoload
(defun org-babel-execute:phpstan (body params)
  "Static analyze a block of PHP code with org-babel using PHPStan.
This function is called by `org-babel-execute-src-block'."
  (let ((tmp-file (org-babel-temp-file "phpstan-" ".php"))
        (body (concat "<?php\n" body))
        (level (or (cdr (assoc :level params)) org-babel-phpstan-level)))
    (with-temp-file tmp-file (insert (org-babel-expand-body:generic body params)))
    (org-babel-eval (format "%s analyze %s --level %s --no-progress"
                            org-babel-phpstan-command
                            (org-babel-process-file-name tmp-file)
                            level)
                    "")))

;;;###autoload
(eval-after-load "org"
  '(add-to-list 'org-src-lang-modes '("phpstan" . phpstan)))

(provide 'ob-phpstan)
;;; ob-phpstan.el ends here
