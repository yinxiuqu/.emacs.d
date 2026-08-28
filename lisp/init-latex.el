;;;; 配置latex环境
;;; 设置auctex，用于编译tex源码

(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil);;支持主、子多文件架构

;;; 设置xelatex引擎 + latexmk 编译（方案A），evince为pdf文件阅读器
(setq TeX-output-view-style (quote (("^pdf$" "." "evince %o %(outpage)"))))
(add-hook 'LaTeX-mode-hook
	  (lambda()
	    (setq TeX-engine 'xetex) ;; 引擎设为xelatex：内置LaTeXMk命令自动使用 latexmk -pdfxe
	    (add-to-list 'TeX-command-list '("XeLaTeX" "%`xelatex%(mode)%' %t" TeX-run-TeX nil t))
	    (setq TeX-command-default "LaTeXMk") ;; 默认用latexmk：自动多遍编译+bibtex/索引循环
;        (setq TeX-source-correlate-mode t) ; ; 启用同步跳转
;        (setq TeX-source-correlate-start-server t) ; 启动服务器支持PDF反向搜索
;        (setq TeX-view-program-selection '((output-pdf "Evince")))
;        (setq TeX-view-program-list '(("Evince" "evince %o")))
;        (local-set-key (kbd "C-c v") 'TeX-view-forward-search);; 绑定正向搜索快捷键
	    (display-line-numbers-mode 1);; LaTex模式下显示行数（Emacs 30 已移除 linum-mode）
        (turn-off-auto-fill);; LaTex模式下不打开自动折行
        (local-set-key (kbd "M-SPC") 'TeX-complete-symbol);; 将补全功能绑定到tab
;        (setq-local TeX-electric-math (cons "$" "$"));; LaTex模式下自动补全第二个$
	    ))

;(with-eval-after-load 'tex
;  (define-key TeX-source-correlate-map [C-down-mouse-1]
;              #'TeX-view-mouse))

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
