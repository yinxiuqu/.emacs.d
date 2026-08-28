;; 本文件用于配置其他函数

(defun delete-all-solutions ()
  "删除所有solution环境。"
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward "\\\\begin{solution}" nil t)
      (let ((start (match-beginning 0)))
        (if (re-search-forward "\\\\end{solution}" nil t)
            (delete-region start (point))
          (error "未匹配的 \\begin{solution}"))))))

;; 文件结尾
(provide 'other-functions)
