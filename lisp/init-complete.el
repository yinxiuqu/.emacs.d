;;; 配置所有自动补全的插件

;; 配置company-mode
(use-package company
  :ensure t
  :init (global-company-mode)
  :config
  (setq company-minimum-prefix-length 1) ; 只需敲 1 个字母就开始进行自动补全
  (setq company-tooltip-align-annotations t)
  (setq company-idle-delay 0.0)
  (setq company-show-numbers t) ;; 给选项编号 (按快捷键 M-1、M-2 等等来进行选择).
  (setq company-selection-wrap-around t)
  (setq company-transformers '(company-sort-by-occurrence))) ; 根据选择的频率进行排序，如果不喜欢可以去掉

;; 设置yasnippet
(require 'yasnippet)
(yas-global-mode 1)
(setq yas-snippet-dirs '("~/emacs.d/snippets"))


;; 设置auto-complete
(ac-config-default)
(setq ac-auto-show-menu 0.05)
(setq auto-complete-mode t)

 (setq ac-quick-help-prefer-pos-tip t)
 (setq ac-use-quick-help t)
 (setq ac-quick-help-delay 0.5)

;; 自动补全括号
(electric-pair-mode t)

;; 文件结尾
(provide 'init-complete)
