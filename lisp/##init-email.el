;; -*- 设置邮箱: t -*-
(setup userinfo
  (:option user-full-name "Xiuqu Yin"
	       user-mail-address "yinxiuqu@outlook.com"))

(setup smtpmail
  (:option smtpmail-default-smtp-server "smtp-mail.outlook.com"
	       smtpmail-smtp-server "smtp-mail.outlook.com"
	       smtpmail-smtp-service 587
	       smtpmail-stream-type 'starttls))

(setup sendmail
  (:option send-mail-function 'smtpmail-send-it
	       message-send-mail-function 'smtpmail-send-it))

(setup gnus
  (:option gnus-select-method '(nnimap "yinxiuqu@outlook.com"
				                       (nnimap-address "outlook.office365.com")
				                       (nnimap-stream ssl)
				                       (nnimap-expunge t)
				                       (nnimap-expiry-wait 30)))
  (:with-mode gnus-group-mode
    (:hook gnus-topic-mode)))
(provide 'init-mail)
