;; 本文件用于配置 minuet 相关的设置

;; 从shell中抓取环境变量
;; 从终端启动 Emacs 时环境变量已完整（key 在 .bashrc/.profile 中），
;; 无需抓取，可省约 2 秒启动时间；从 GUI 启动时缺少 DEEPSEEK_API_KEY
;; 或 anaconda 的 PATH，此时才执行抓取。
(use-package exec-path-from-shell
  :ensure t
  :config
  ;; 指定需要抓取的环境变量
  (add-to-list 'exec-path-from-shell-variables "DEEPSEEK_API_KEY")
  ;; 环境完整（从终端启动）时跳过抓取
  (unless (and (getenv "DEEPSEEK_API_KEY")
               (string-match-p (regexp-quote (expand-file-name "~/anaconda3/bin"))
                               (or (getenv "PATH") "")))
    (exec-path-from-shell-initialize)))

;; 配置 minuet
(use-package minuet
  :ensure t
  :hook (prog-mode . minuet-auto-suggestion-mode)
  :bind (("M-i" . #'minuet-show-suggestion)          ; 手动触发补全
         :map minuet-active-mode-map                 ; 补全建议显示时的快捷键
         ("M-p" . #'minuet-previous-suggestion)      ; 上一个建议
         ("M-n" . #'minuet-next-suggestion)          ; 下一个建议
         ("M-a" . #'minuet-accept-suggestion-line)   ; 接受当前行
         ("M-A" . #'minuet-accept-suggestion)        ; 接受整个建议
         ("M-e" . #'minuet-dismiss-suggestion))      ; 取消建议
  :init
  ;; 如果你希望自动补全，可以在这里添加钩子
  ;; (add-hook 'prog-mode-hook #'minuet-auto-suggestion-mode)
  :config

  ;; 获取环境变量中的api keys:
  (setq minuet-openai-api-key (getenv "DEEPSEEK_API_KEY"))
  
  ;; 1. 设置 provider 为 openai-fim-compatible (这是默认值，但显式设置更安全)
  (setq minuet-provider 'openai-fim-compatible)

  ;; 2. ★★★ 关键修正：使用 minuet-set-optional-options 来设置参数 ★★★
  (minuet-set-optional-options minuet-openai-fim-compatible-options
    :max_tokens 128)  ; 增加最大补全长度

  ;; 3. 其他通用设置
  (setq minuet-request-timeout 5)          ; 请求超时时间（秒）
  (setq minuet-auto-suggestion-debounce-delay 0.3)) ; 自动补全触发延迟

;; 文件结尾
(provide 'init-minuet)
