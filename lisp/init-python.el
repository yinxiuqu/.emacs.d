;; 配置pyvenv
(require 'pyvenv)
(setenv "WORKON_HOME" "~/anaconda3/envs")
(add-hook 'python-mode-hook 'pyvenv-mode)

;; 配置autopep8
(require 'py-autopep8)
(add-hook 'python-mode-hook 'py-autopep8-enable-on-save)

;; 配置flycheck
(require 'flycheck)
(add-hook 'python-mode-hook 'flycheck-mode)

;; 配置pylint
(autoload 'pylint "pylint")
(add-hook 'python-mode-hook 'pylint-add-menu-items)
(add-hook 'python-mode-hook 'pylint-add-key-bindings)

;; 配置发送buffer中的python文件到python解释器
(defun python-shell-send-this-file()
  "send the file in buffer to python shell"
  (interactive)
  (python-shell-send-file (buffer-file-name))
  (define-key python-mode-map (kbd "C-c C-f") 'python-shell-send-this-file))

;; 去除启动时的Can't guess python-indent-offset, using defaults: 4错误
(setq python-indent-guess-indent-offset-verbose nil)

;;; 配置lsp-pyright
;(use-package lsp-pyright
;  :ensure t
;  :hook (python-mode . (lambda ()
;                          (require 'lsp-pyright)
;                          (lsp))))

;; 文件末尾
(provide 'init-python)
