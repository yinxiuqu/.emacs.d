;;;; 配置latex环境
;;; 设置auctex，用于编译tex源码

(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil);;支持主、子多文件架构

;;; 设置xelatex为默认编译命令，evince为pdf文件阅读器
(setq TeX-output-view-style (quote (("^pdf$" "." "evince %o %(outpage)"))))
(add-hook 'LaTeX-mode-hook
	  (lambda()
	    (add-to-list 'TeX-command-list '("XeLaTeX" "%`xelatex%(mode)%' %t" TeX-run-TeX nil t))
	    (setq TeX-command-default "XeLaTeX")
        (setq TeX-source-correlate-mode t) ; ; 启用同步跳转
        (setq TeX-source-correlate-start-server t) ; 启动服务器支持PDF反向搜索
	    (linum-mode);; LaTex模式下显示行数
        (turn-off-auto-fill);; LaTex模式下不打开自动折行
        (local-set-key (kbd "M-SPC") 'TeX-complete-symbol);; 将补全功能绑定到tab
;        (setq-local TeX-electric-math (cons "$" "$"));; LaTex模式下自动补全第二个$
	))

;; 配置拼写检查
(setq ispell-dictionary "british");set the default dictionary
(add-hook 'LaTeX-mode-hook 'flyspell-mode);start flyspell-mode

(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)

;; ;; 将$$自动替换成\(\)
;; (add-hook 'plain-TeX-mode-hook
;;           (lambda () (setq-local TeX-electric-math
;;                                  (cons "$" "$"))))
;; (add-hook 'LaTeX-mode-hook
;;           (lambda () (setq-local TeX-electric-math
;;                                  (cons "\\(" "\\)"))))


;;;; 文件末尾
(provide 'init-latex)
