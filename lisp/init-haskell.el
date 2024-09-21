;; 配置haskell环境
(use-package haskell-mode
  :ensure t
  :hook
  (haskell-mode . interactive-haskell-mode)
  (haskell-mode . turn-on-haskell-indentation))


;; 文件末尾
(provide 'init-haskell)
