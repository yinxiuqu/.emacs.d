;; 现代 Python 配置：lsp-mode（客户端）+ lsp-pyright（适配器）
;;                    + pyright（语言服务器）+ pyvenv（虚拟环境）
;; 内置 python.el + tree-sitter 语法树 + ruff 格式化/风格检查

;; ---------- 虚拟环境管理（pyvenv） ----------
(use-package pyvenv
  :ensure t
  :config
  (setenv "WORKON_HOME" "~/anaconda3/envs")
  (add-hook 'python-mode-hook 'pyvenv-mode))

;; ---------- tree-sitter 语法树模式 ----------
;; 让 .py 文件使用 python-ts-mode（Emacs 30 内置，语法树驱动的高亮/缩进/跳转）
;; grammar 已装到 ~/.emacs.d/tree-sitter/；固定 v0.21.0（master 的 ABI 15 与本机 Emacs 30 的 ABI 14 不兼容）
(setq treesit-language-source-alist
      '((python "https://github.com/tree-sitter/tree-sitter-python" "v0.21.0" "src")))
(add-to-list 'treesit-extra-load-path "~/.emacs.d/tree-sitter/")
(add-to-list 'major-mode-remap-alist '(python-mode . python-ts-mode))

;; ---------- LSP：pyright 语言服务器（类型检查/补全/跳转/重命名） ----------
(use-package lsp-pyright
  :ensure t
  :hook (python-mode . lsp-deferred)
  :config
  ;; pyright 装在 anaconda 里；GUI 启动时 PATH 不含 anaconda，用绝对路径确保找到
  (setq lsp-pyright-executable "/home/yinxiuqu/anaconda3/bin/pyright"))

;; ---------- LSP：ruff 风格检查（附加客户端，与 pyright 共存） ----------
;; ruff 0.4+ 自带 LSP 服务器（lsp-ruff 包已从 MELPA 下架，直接注册客户端）
;; 分工：pyright 管类型，ruff 管风格（未使用 import、PEP 8 等）
(with-eval-after-load 'lsp-mode
  (lsp-register-client
   (make-lsp-client
    :new-connection (lsp-stdio-connection
                     (lambda () (list (expand-file-name "~/anaconda3/bin/ruff") "server")))
    :major-modes '(python-mode python-ts-mode)
    :server-id 'ruff-server
    :add-on? t
    :priority -1)))

;; ---------- 保存时自动格式化（apheleia + ruff） ----------
(use-package apheleia
  :ensure t
  :config
  (apheleia-global-mode 1)
  ;; Python 用 ruff 格式化（apheleia 默认是 black）
  (setf (alist-get 'python-mode apheleia-mode-alist) 'ruff)
  (setf (alist-get 'python-ts-mode apheleia-mode-alist) 'ruff))

;; ---------- 发送 buffer 到 Python 解释器 ----------
(defun python-shell-send-this-file ()
  "send the file in buffer to python shell"
  (interactive)
  (python-shell-send-file (buffer-file-name)))

(with-eval-after-load 'python
  (define-key python-mode-map (kbd "C-c C-f") 'python-shell-send-this-file))

;; anaconda 加入 exec-path，保证 GUI 启动时也能找到 conda 工具（ruff/pyright/python）
(add-to-list 'exec-path "/home/yinxiuqu/anaconda3/bin")

;; 去除启动时的 Can't guess python-indent-offset 提示
(setq python-indent-guess-indent-offset-verbose nil)

;; 文件末尾
(provide 'init-python)
