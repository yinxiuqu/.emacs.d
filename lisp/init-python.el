;; 现代 Python 配置：lsp-mode（客户端）+ lsp-pyright（适配器）
;;                    + pyright（语言服务器）+ pyvenv（虚拟环境）
;; 内置 python.el + tree-sitter 语法树 + ruff 格式化/风格检查

;; 注意：下面所有 hook 都挂在 `python-base-mode-hook' 而不是 python-mode-hook。
;; 因为第 18 行把 python-mode 重映射到了 python-ts-mode，打开 .py 时实际运行的是
;; python-ts-mode（实测：python-mode-hook 不运行，python-ts-mode-hook 与
;; python-base-mode-hook 运行），挂在 python-mode-hook 上的设置一律不会生效。

;; ---------- 虚拟环境管理（pyvenv） ----------
(use-package pyvenv
  :ensure t
  :config
  (setenv "WORKON_HOME" "~/anaconda3/envs")
  (add-hook 'python-base-mode-hook 'pyvenv-mode))

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
  :hook (python-base-mode . lsp-deferred)
  :config
  ;; pyright 装在 anaconda 里；GUI 启动时 PATH 不含 anaconda，用绝对路径确保找到
  (setq lsp-pyright-executable "/home/yinxiuqu/anaconda3/bin/pyright"))

;; ---------- LSP：ruff 风格检查（附加客户端，与 pyright 共存） ----------
;; 分工：pyright 管类型，ruff 管风格（未使用 import、PEP 8 等）。
;;
;; 这里不再自己 (lsp-register-client)：lsp-mode 自带 lsp-ruff 客户端就是 `ruff server'
;; （:server-id 'ruff、:priority -2、:add-on? t、activation 为 python），并且
;; `lsp--require-packages' 在首次调用 lsp 时必然加载它（它在 lsp-client-packages 里）。
;; 原先另注册一个 'ruff-server 的 id，会让同一个 Python buffer 起两个 ruff 服务
;; （重复诊断/代码动作、双份内存），故删除自定义注册，只保留内置客户端。
;;
;; 唯一需要设的是命令的绝对路径（GUI 启动时 PATH 不含 anaconda）。
;; 用 with-eval-after-load 'lsp-ruff：该文件在首次 lsp 调用时才被 require，
;; 此刻设置生效，早于客户端真正建立连接（连接时才读取 lsp-ruff-server-command）。
(with-eval-after-load 'lsp-ruff
  (setq lsp-ruff-server-command (list (expand-file-name "~/anaconda3/bin/ruff") "server")))

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

;; python-mode-map 与 python-ts-mode-map 是两张互无父子关系的独立键图（实测
;; python-ts-mode 里 C-c C-f 仍是内置的 python-eldoc-at-point），所以这里改用
;; python-base-mode-hook + local-set-key，python-mode / python-ts-mode 都覆盖。
(defun my-python-bind-keys ()
  "Python 缓冲区内的自定义按键绑定。"
  (local-set-key (kbd "C-c C-f") #'python-shell-send-this-file))
(add-hook 'python-base-mode-hook #'my-python-bind-keys)

;; anaconda 加入 exec-path，保证 GUI 启动时也能找到 conda 工具（ruff/pyright/python）
(add-to-list 'exec-path "/home/yinxiuqu/anaconda3/bin")

;; 去除启动时的 Can't guess python-indent-offset 提示
(setq python-indent-guess-indent-offset-verbose nil)

;; 文件末尾
(provide 'init-python)
