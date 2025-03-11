;; 本文件用于配置AI

;; 安装copilot.el
(use-package copilot
  :ensure t)

;; 使用copilot对特定模式进行补全
(add-hook 'prog-mode-hook 'copilot-mode)
(add-hook 'LaTeX-mode-hook 'copilot-mode)
(add-hook 'pyton-mode-hook 'copilot-mode)
(add-hook 'TeX-mode-hook 'copilot-mode)

;; Tab 键接受全部补全
(define-key copilot-mode-map (kbd "<tab>") 'copilot-accept-completion)
  
;; Ctrl+→ 逐词接受
(define-key copilot-mode-map (kbd "C-<right>") 'copilot-accept-completion-by-word)

;; Alt+→ 逐行接受
(define-key copilot-mode-map (kbd "M-<right>") 'copilot-accept-completion-by-line)

(setq copilot-max-char 500000);

;; 设置默认缩进规则（例如 4 空格缩进）
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil) ; 使用空格而非制表符

;; 针对特定编程模式设置缩进
(add-hook 'python-mode-hook (lambda () (setq indent-tabs-mode nil tab-width 4)))
(add-hook 'LaTeX-mode-hook (lambda () (setq indent-tabs-mode nil tab-width 2)))

;; 文件结尾
(provide 'init-ai)
