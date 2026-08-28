;;; 设置结构化配置文件

(add-to-list 'load-path "~/.emacs.d/lisp/")

;; Package Management
;; -----------------------------------------------------------------
(require 'init-packages)

;; Python init
;; -----------------------------------------------------------------
(require 'init-python)

;; haskell init
;; -----------------------------------------------------------------
(require 'init-haskell)

;; latex init
;; -----------------------------------------------------------------
(require 'init-latex)

;; company-mode init
;; -----------------------------------------------------------------
(require 'init-complete)

;; lsp init
;; -----------------------------------------------------------------
(require 'init-lsp)

;; 全局快捷键配置
;; -----------------------------------------------------------------
(require 'init-keys)

;; display init
;; -----------------------------------------------------------------
(require 'init-display)

;; email init
;; -----------------------------------------------------------------
(require 'init-email)

;; AI init
;; -----------------------------------------------------------------
(require 'init-copilot)

;; minuet init
;; -----------------------------------------------------------------
(require 'init-minuet)

;; 定义其他函数
;; -----------------------------------------------------------------
(require 'other-functions)

;;; 设置暂未分配到结构化配置文件的杂项

;; 设置默认主模式
(setq default-major-mode 'text-mode)
;; 启用自动换行
(add-hook 'text-mode-hook 'turn-on-auto-fill)

;; 当另一程序修改了文件时，让 Emacs 及时刷新 Buffer
(global-auto-revert-mode t)

; 选中文本后输入文本会替换文本（更符合我们习惯了的其它编辑器的逻辑）
(delete-selection-mode t)

;; 禁用\e\e和\C-x\C-u
 (global-unset-key "\e\e")
 (global-unset-key "\C-x\C-u")


;; 打开csv文件自动使用csv-mode（注意：csv-mode 未安装，此设置当前无效）
;; (add-hook 'csv-mode-hook
;; 	  (lambda ()
;; 	    (csv-align-fields nil (point-min) (point-max))))

;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(safe-local-variable-values '((TeX-master . "../main") (TeX-master . t))))

;;
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'downcase-region 'disabled nil)
(put 'scroll-left 'disabled nil)

;;让 Emacs 可以直接打开和显示图片。
(auto-image-file-mode 1)
(put 'upcase-region 'disabled nil)

