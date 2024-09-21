;;  __        __             __   ___
;; |__)  /\  /  ` |__/  /\  / _` |__
;; |    /~~\ \__, |  \ /~~\ \__> |___
;;                      __   ___        ___      ___
;; |\/|  /\  |\ |  /\  / _` |__   |\/| |__  |\ |  |
;; |  | /~~\ | \| /~~\ \__> |___  |  | |___ | \|  |
(when (>= emacs-major-version 24)
    (require 'package)
    (setq package-archives '(("gnu"   . "http://1.15.88.122/gnu/")
			     ("melpa" . "http://1.15.88.122/melpa/")
			     ("org" . "http://1.15.88.122/org/"))))

(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

;; 文件末尾
(provide 'init-packages)
