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

;; 会话恢复：退出时自动保存打开的buffer/窗口布局到 desktop 文件，下次启动恢复
;; 迁移说明（2026-08-31）：原配置包在 after-init-hook 里，部分启动路径下
;; desktop-dirname 未生效导致退出时弹出 "Directory for desktop file" 询问；
;; 改为顶层直接配置，保证 desktop-dirname 始终有值。
(setq desktop-dirname             "~/.emacs.d/desktop/"
      desktop-base-file-name      "emacs.desktop"
      desktop-base-lock-name      "lock"
      desktop-path                (list desktop-dirname)
      desktop-save                (quote ask) ; 退出时询问 "Save desktop?" (y/n)，选 y 才更新
      desktop-files-not-to-save   "^$" ;reload tramp paths
      desktop-load-locked-desktop nil
      desktop-auto-save-timeout   10)
(desktop-save-mode 1)
;; 先于 desktop-read 注册受信任目录，否则恢复会话时 dir-locals
;; (quantming/.dir-locals.el) 会因 custom-set-variables 尚未执行而反复弹安全确认
(setq safe-local-variable-directories '("/home/yinxiuqu/quantming/"))
;; 直接用 emacs 打开文件时不恢复上次会话；直接开 emacs 时恢复
(if (< (length command-line-args) 2)
    (desktop-read))
;; 保险丝：desktop.el 在"桌面文件被占用/加载中断"等分支会把 desktop-dirname
;; 置为 nil，导致退出时 desktop-kill 弹出 "Directory for desktop file" 询问。
;; 在 kill-emacs-hook 最前面恢复目录，保证退出永不弹询问（add-hook 默认插最前）。
(add-hook 'kill-emacs-hook
          (lambda ()
            (unless desktop-dirname
              (setq desktop-dirname "~/.emacs.d/desktop/"))))

;; 文件结尾
(provide 'init-display)
