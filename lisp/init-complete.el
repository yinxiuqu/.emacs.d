;;; 配置所有自动补全的插件

;; 配置company-mode
(use-package company
  :ensure t
  :init (global-company-mode)
  :config
  (setq company-minimum-prefix-length 1) ; 只需敲 1 个字母就开始进行自动补全
  (setq company-tooltip-align-annotations t) ; 对齐注释
  (setq company-idle-delay 0.2) ;延迟0.2妙
  (setq company-show-numbers t) ;; 给选项编号 (按快捷键 M-1、M-2 等等来进行选择).
  (setq company-backends (delete 'company-ispell company-backends));; 禁用 company-ispell（拼写补全）
  (add-to-list 'company-backends 'company-capf) ;; 接入 LSP 补全（pyright/其他语言服务器）
  (setq company-selection-wrap-around t);; 启用循环选择
  (setq company-transformers '(company-sort-by-occurrence)) ; 根据选择的频率进行排序，如果不喜欢可以去掉
;  (setq company-backends (cons 'company-yasnippet company-backends))
;  (define-key company-active-map (kbd "TAB") 'company-yasnippet)
  (define-key company-active-map (kbd "ESC") 'company-abort)) ; ESC键退出补全窗口

;; 设置yasnippet
(require 'yasnippet)
(yas-reload-all)
(yas-global-mode t)
(setq yas-snippet-dirs '("~/.emacs.d/snippets"))

;; 自动补全括号
(electric-pair-mode t)

;; 先加载 Org 模式
(use-package org
  :ensure t
  :demand t;强制立即加载,不延迟
  :config
  (require 'org-element))

;; 再设置smartparens,自动补全括号
(use-package smartparens
  :ensure t
  :after org
  :config
  (require 'smartparens-config)    ; 加载默认配置
  (smartparens-global-mode)        ; 全局启用
  (smartparens-strict-mode 1)      ; 启用严格模式
  (show-smartparens-global-mode t) ; 高亮匹配括号
  (sp-with-modes '(LaTeX-mode)
  
  (sp-local-pair "$" "$"  :actions '(insert wrap)))) ; 在LaTeX模式下，$符号自动补全)
;;  (sp-local-pair "{" "}" :actions '(insert wrap))) ; :actions：指定触发行为，
                                        ; insert 表示输入左括号时自动插入右括号
                                        ; wrap 表示选中文本后按 { 键会包裹文本。

;; 注意：C-<down> 的绑定由 init-copilot.el 统一管理（copilot 逐行接受）。
;; 原先这里 global-unset-key 再被 init-copilot.el 覆盖，属无效代码，已删除。

;; 文件结尾
(provide 'init-complete)
