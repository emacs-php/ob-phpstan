;;; ob-phpstan.el --- run phpstan with org-babel -*- lexical-binding: t -*-

;; Author: Takeo Obara <bararararatty@gmail.com>
;; Maintainer: Takeo Obara
;; Version: v1.0.0
;; Package-Requires: ((emacs "29.0"))
;; Homepage: https://github.com/takeokunn/ob-phpstan
;; Keywords: phpstan, org, babel

;; This file is not part of GNU Emacs

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; For a full copy of the GNU General Public License
;; see <http://www.gnu.org/licenses/>.


;;; Commentary:

;; run phpstan with org-babel

;;; Code:
(require 'org)
(require 'ob)

(defgroup ob-phpstan nil
  "org-mode blocks for fish script"
  :group 'org)

(defcustom org-babel-phpstan-command "phpstan"
  "The command to execute babel body code."
  :group 'ob-phpstan
  :type 'string)

(defcustom org-babel-phpstan-level 5
  "The fish command options to use when execute code."
  :group 'ob-phpstan
  :type 'number)

;;;###autoload
(defun org-babel-execute:phpstan (body params)
  "Org mode fish evaluate function"
  (let ((tmp-file (org-babel-temp-file "phpstan-" ".php"))
        (body (concat "<?php\n" body))
        (level (or (cdr (assoc :level params)) org-babel-phpstan-level)))
    (with-temp-file tmp-file (insert (org-babel-expand-body:generic body params)))
    (org-babel-eval (format "%s analyze %s --level %s"
                            org-babel-phpstan-command
                            (org-babel-process-file-name tmp-file)
                            level)
                    "")))

;;;###autoload
(eval-after-load "org"
  '(add-to-list 'org-src-lang-modes '("phpstan" . phpstan)))

(provide 'ob-phpstan)

;;; ob-phpstan.el ends here
