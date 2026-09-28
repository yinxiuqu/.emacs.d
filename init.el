;;; 设置结构化配置文件

;; 禁用 GUI 文件选择对话框（改用 minibuffer 文本输入，避免退出/保存时弹系统文件选择器）
(setq use-file-dialog nil)

(add-to-list 'load-path "~/.emacs.d/lisp/")

;; Package Management
;; -----------------------------------------------------------------
(require 'init-packages)

;; Python init
;; -----------------------------------------------------------------
(require 'init-python)

;; conda 环境管理（conda.el，M-x conda-env-activate 切换环境）
;; -----------------------------------------------------------------
(require 'init-conda)

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
;; package-selected-packages 只登记"配置里实际使用、且需要从 ELPA 安装"的包，
;; 它是 package-autoremove 判断显式安装集合的依据，登记不准会误删依赖（此前 lsp-mode 的
;; f/ht/markdown-mode/lv 就是这样丢的）或漏保自身的包。
;; 本次校正：补上实际在用的 conda、lsp-mode；移除零引用的 flycheck、jedi、py-autopep8、
;; yasnippet-snippets。（which-key 在 Emacs 30 是内置包，无需登记；dash/s/f/ht/lv/
;; markdown-mode/spinner/bind-key/plz/pythonic 等是依赖，由 package.el 自动维护。）
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(apheleia auctex company conda copilot exec-path-from-shell
              haskell-mode lsp-mode lsp-pyright lsp-ui minuet org
              pyvenv restart-emacs smartparens use-package yasnippet))
 '(safe-local-variable-directories '("/home/yinxiuqu/quantming/"))
 '(safe-local-variable-values
   '((python-shell-interpreter-args . "-i")
     (python-shell-interpreter
      . "/home/yinxiuqu/anaconda3/envs/qa/bin/python")
     (TeX-master . "../main") (TeX-master . t))))

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

