;; 现代 Python 配置：lsp-mode（客户端）+ lsp-pyright（适配器）
;;                    + pyright（语言服务器）+ pyvenv（虚拟环境）
;; 使用 Emacs 内置 python.el（Emacs 30 自带，取代老式 python-mode 包）

;; ---------- 虚拟环境管理（pyvenv） ----------
(use-package pyvenv
  :ensure t
  :config
  (setenv "WORKON_HOME" "~/anaconda3/envs")
  (add-hook 'python-mode-hook 'pyvenv-mode))

;; ---------- LSP：pyright 语言服务器 ----------
;; 补全/诊断/跳转/重命名等由 pyright 提供，经 lsp-mode 接入 company 补全
(use-package lsp-pyright
  :ensure t
  :hook (python-mode . lsp-deferred)
  :config
  ;; pyright 装在 anaconda 里；GUI 启动时 PATH 不含 anaconda，用绝对路径确保找到
  (setq lsp-pyright-executable "/home/yinxiuqu/anaconda3/bin/pyright"))

;; ---------- 发送 buffer 到 Python 解释器 ----------
(defun python-shell-send-this-file ()
  "send the file in buffer to python shell"
  (interactive)
  (python-shell-send-file (buffer-file-name)))

(with-eval-after-load 'python
  (define-key python-mode-map (kbd "C-c C-f") 'python-shell-send-this-file))

;; 去除启动时的 Can't guess python-indent-offset 提示
(setq python-indent-guess-indent-offset-verbose nil)

;; 文件末尾
(provide 'init-python)
