;;  __        __             __   ___
;; |__)  /\  /  ` |__/  /\  / _` |__
;; |    /~~\ \__, |  \ /~~\ \__> |___
;;                      __   ___        ___      ___
;; |\/|  /\  |\ |  /\  / _` |__   |\/| |__  |\ |  |
;; |  | /~~\ | \| /~~\ \__> |___  |  | |___ | \|  |

(when (>= emacs-major-version 24)
    (require 'package)
    ;; (setq package-archives '(("gnu"   . "https://elpa.gnu.org/packages/")
    ;; 			     ("melpa" . "https://melpa.org/packages/")
    ;; 			     ("nongnu" . "https://elpa.nongnu.org/nongnu/"))))

    (setq package-archives '(("gnu"   . "https://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
			     ("melpa" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/nongnu/")
			     ("nongnu" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/"))))


(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

;;(package-install 'use-package)

(use-package restart-emacs :ensure t)

;; 文件末尾
(provide 'init-packages)
