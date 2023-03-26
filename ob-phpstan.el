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

(defcustom org-babel-phpstan-command "~/.asdf/installs/php/8.2.3/.composer/vendor/bin/phpstan"
  "The command to execute babel body code."
  :group 'ob-phpstan
  :type 'string)

(defcustom org-babel-phpstan-command-options nil
  "The fish command options to use when execute code."
  :group 'ob-phpstan
  :type 'list)

;;;###autoload
(defun org-babel-execute:phpstan (body _)
  "Org mode fish evaluate function"
  (let ((cmd (concat org-babel-phpstan-command " " (mapconcat 'string org-babel-phpstan-command-options " "))))
    (org-babel-eval cmd body)))

(provide 'ob-phpstan)

;;; ob-phpstan.el ends here
