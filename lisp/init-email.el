;;;配置收发邮件设置（QQ 邮箱版）
;; ============================================================
;; 使用前必做（一次性）：
;;   1. 登录 QQ 邮箱网页版 -> 设置 -> 账户
;;      -> 开启 "IMAP/SMTP服务" 和 "POP3/SMTP服务"
;;      -> 按提示生成【授权码】（16位，不是QQ密码）
;;   2. 把下面的 smtpmail-smtp-user 改成你的 QQ 邮箱地址（如 123456@qq.com）
;;   3. 在 ~/.authinfo 里填授权码（见文件末尾说明），权限设为 600
;; ============================================================

(setq user-full-name "XiuquYin")
(setq user-mail-address "yinxiuqu@qq.com")   ; 发件人显示地址

;; ---------- 发送邮件：smtpmail + smtp.qq.com ----------
(setq send-mail-function 'smtpmail-send-it)
(setq smtpmail-smtp-server "smtp.qq.com")
(setq smtpmail-smtp-user "yinxiuqu@qq.com")        ; 改成QQ 邮箱
(setq smtpmail-smtp-service 465)                   ; QQ 邮箱 SMTP 用 465(SSL)
(setq smtpmail-stream-type 'ssl)

;; ---------- 接收邮件：内置 Gnus + nnimap ----------
;; 无需安装任何包；M-x gnus 即可收发
(setq gnus-select-method
      '(nnimap "QQ"
               (nnimap-address "imap.qq.com")
               (nnimap-server-port 993)
               (nnimap-stream ssl)))

;; 遇到错误时开启smtpmail的调试功能：
(setq smtpmail-debug-info t)
(setq smtpmail-debug-verb t)


;; ============================================================
;; ~/.authinfo 授权码配置（用 chmod 600 保护）：
;; ------------------------------------------------------------
;; machine smtp.qq.com login 你的QQ号@qq.com password 16位授权码 port 465
;; machine imap.qq.com login 你的QQ号@qq.com password 16位授权码 port 993
;; ============================================================

(provide 'init-email)
