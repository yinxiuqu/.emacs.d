;;;配置收发邮件设置

(setq user-full-name "XiuquYin")
(setq user-mail-address "yinxiuqu@outlook.com")

;; 配置发送邮件
(setq send-mail-function 'smtpmail-send-it)
(setq smtpmail-smtp-server "smtp.office365.com")
(setq smtpmail-smtp-user "yinxiuqu")
(setq smtpmail-smtp-service 587)
(setq smtpmail-stream-type 'starttls)


;; 遇到错误时开启smtpmail的调试功能：
(setq smtpmail-debug-info t)
(setq smtpmail-debug-verb t)


(provide 'init-email)
