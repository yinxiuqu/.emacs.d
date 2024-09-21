;;; 设置显示选项

;; 显示时间
(display-time)

;; 编程模式下，光标在括号上时高亮另一个括号
(add-hook 'prog-mode-hook #'show-paren-mode)

;; 在 Mode line 上显示列号
(column-number-mode t)

;; 高亮当前行
(global-hl-line-mode 1)


; 关闭启动 Emacs 时的欢迎界面
(setq inhibit-startup-message t)

; 编程模式下，可以折叠代码块
(add-hook 'prog-mode-hook #'hs-minor-mode)

; 编程模式下，显示行号
(defun my-display-numbers-hook ()
  (display-line-numbers-mode t))
(add-hook 'prog-mode-hook 'my-display-numbers-hook)

;; 如果用emacs打开文件则只打开文件，如果直接打开emacs则开启上次退出的非空界面
(add-hook 'after-init-hook
          (defun if-desktop-read ()
	    (setq desktop-dirname             "~/.emacs.d/desktop/"
		  desktop-base-file-name      "emacs.desktop"
		  desktop-base-lock-name      "lock"
		  desktop-path                (list desktop-dirname)
		  desktop-save                t
		  desktop-files-not-to-save   "^$" ;reload tramp paths
		  desktop-load-locked-desktop nil
		  desktop-auto-save-timeout   10)
	    (desktop-save-mode 1)
	    (if (< (length command-line-args) 2)
		(desktop-read))))

;; 突出显示每行超过80个字符的部分
(require 'whitespace)
(setq whitespace-style '(face empty tabs lines-tail trailing))
(global-whitespace-mode t)

;; 文件结尾
(provide 'init-display)
