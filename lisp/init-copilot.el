;; 本文件用于配置copilot

;; 安装copilot.el
(use-package copilot
  :ensure t)

;; 使用copilot对特定模式进行补全
(add-hook 'prog-mode-hook 'copilot-mode)
(add-hook 'LaTeX-mode-hook 'copilot-mode)
(add-hook 'python-mode-hook 'copilot-mode)
(add-hook 'TeX-mode-hook 'copilot-mode)

;; copilot 缩进推断：默认表只覆盖内置 latex-mode（小写），
;; 补上 AUCTeX 的 LaTeX-mode/TeX-mode，消除 "no mode-specific indentation offset" 警告
(add-to-list 'copilot-indentation-alist '(LaTeX-mode LaTeX-indent-level 2) t)
(add-to-list 'copilot-indentation-alist '(TeX-mode LaTeX-indent-level 2) t)

;; Tab 键接受全部补全
(define-key copilot-mode-map (kbd "<tab>") 'copilot-accept-completion)
  
;; C-<right> 逐词接受
(define-key copilot-mode-map (kbd "C-<right>") 'copilot-accept-completion-by-word)

;; C-<down> 逐行接受（全局绑定，任何模式都可用）
(global-set-key (kbd "C-<down>") 'copilot-accept-completion-by-line)

(setq copilot-max-char 500000)

;; 设置默认缩进规则（例如 4 空格缩进）
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil) ; 使用空格而非制表符

;; 针对特定编程模式设置缩进
(add-hook 'python-mode-hook (lambda () (setq indent-tabs-mode nil tab-width 4)))
(add-hook 'LaTeX-mode-hook (lambda () (setq indent-tabs-mode nil tab-width 2)))

;; 文件结尾
(provide 'init-copilot)
