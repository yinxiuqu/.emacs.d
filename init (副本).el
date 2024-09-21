;; 安装包的源
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://elpa.emacs-china.org/melpa/") t)
(add-to-list 'package-archives '("gnu" . "https://elpa.emacs-china.org/gnu/") t)
(add-to-list 'package-archives '("org" . "https://elpa.emacs-china.org/org/") t)
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won’t work right.
 '(package-selected-packages '(use-package ## lsp-mode youdao-dictionary)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won’t work right.
 )

;; 显示时间
(display-time)

 ;; 配置conda虚拟环境
 (require 'conda)
 ;; if you want interactive shell support, include:
OB (conda-env-initialize-interactive-shells)
 ;; if you want eshell support, include:
 (conda-env-initialize-eshell)
 ;; if you want auto-activation (see below for details), include:
 (conda-env-autoactivate-mode t)
 ;; 指定anaconda的安装目录
 (custom-set-variables
  '(conda-anaconda-home "~/anaconda3/"))
 (setq conda-anaconda-home (expand-file-name "~/anaconda3"))
 ;; 指定anaconda的配置目录
 (setq conda-env-home-directory (expand-file-name "~/anaconda3/"))

 ;; python路径
 (setq python-shell-interpreter "/home/yinxiuqu/anaconda3/envs/quantaxis/bin/python3.8")

 ;; 设置环境变量
 (setenv "PATH" "/home/yinxiuqu/projects/quantming")
 ;; (setenv "HOME" "/home/yinxiuqu/projects/quantming")
 ;; (setq default-directory "/home/yinxiuqu/temp")
 (setq command-line-default-directory "/home/yinxiuqu/temp")

 ;; 设置和系统互相粘贴
 (setq x-select-enable-clipboard t)

 ;; 有道词典Enable Cache
 (setq url-automatic-caching t)
 (global-set-key (kbd "C-q") 'youdao-dictionary-search-at-point+)

 ;; 禁用\e\e和\C-x\C-u
 (global-unset-key "\e\e")
 (global-unset-key "\C-x\C-u")

 ;; eshell自动启用conda虚拟环境
 (defun my-python-shell-dir-setup ()
   (let ((process (get-buffer-process (current-buffer))))
     (python-shell-send-string my-python-shell-dir-setup-code process)
     (message "Setup project path")))
 (add-hook 'inferior-python-mode-hook 'my-python-shell-dir-setup)

