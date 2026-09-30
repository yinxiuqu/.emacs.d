;; 安装 which-key：为 lsp 等提供按键提示，lsp 的 :hook 集成依赖它
(use-package which-key
  :ensure t
  :config
  (which-key-mode 1))            ; 启用全局按键提示

;; 配置lsp-mode
(use-package lsp-mode
  :ensure t
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l"
	lsp-file-watch-threshold 500)
  :hook 
  (lsp-mode . lsp-enable-which-key-integration) ; which-key integration
  :commands (lsp lsp-deferred)
  :config
    (setq lsp-completion-provider :none) ;; 阻止 lsp 重新设置 company-backend 而覆盖我们 yasnippet 的设置
    (setq lsp-headerline-breadcrumb-enable t)
    (setq lsp-completion-default-behaviour :insert))

;; 文件监视白名单化：pyright 会注册 `**' 这种全工作区 glob（ruff 只注册
;; pyproject.toml / ruff.toml / .ruff.toml 三个配置文件），于是 lsp-mode 要为项目里
;; 每个目录各建一个 inotify watch。quantming 下有 3900+ 个目录，其中绝大部分是
;; .npm-cache / .pnpm-store / .local_libs / .cache / outputs / data 这类缓存与产出，
;; 监视它们只会把无意义的 didChangeWatchedFiles 同时推给 pyright 和 ruff。
;; 加入忽略规则后实测：可监视目录 3980 -> 47（低于 lsp-file-watch-threshold 500，
;; 因此不再弹 "Do you want to watch all files ...?"），且剩下的全是
;; strategies / tools / indicators / sources / trade / tests / script / pytdx 等
;; 源码与配置目录，源码改动仍会通知服务器。
;; 注意必须用 add-to-list 在 lsp-mode 加载之后再追加，否则会丢掉它内置的默认忽略项
;; （.git、node_modules、dist 等）；也不要改成 setq。
(with-eval-after-load 'lsp-mode
  (dolist (re '("[/\\\\]\\.npm-cache\\'"
                "[/\\\\]\\.pnpm-store\\'"
                "[/\\\\]\\.local\\'"
                "[/\\\\]\\.local_libs\\'"
                "[/\\\\]\\.cache\\'"
                "[/\\\\]\\.config\\'"
                "[/\\\\]\\.ruff_cache\\'"
                "[/\\\\]\\.bak[^/]*\\'"
                "[/\\\\]data\\'"
                "[/\\\\]outputs\\'"
                "[/\\\\]log\\'"
                "[/\\\\]tmp\\'"
                "[/\\\\]__pycache__\\'"))
    (add-to-list 'lsp-file-watch-ignored-directories re)))

;; 安装一个 lsp-ui 插件
(use-package lsp-ui
  :ensure t
  :config
  (define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
  (define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references)
  (setq lsp-ui-doc-position 'top))

;; 文件末尾
(provide 'init-lsp)
