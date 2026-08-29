;;; init-conda.el --- conda 环境管理（conda.el） -*- lexical-binding: t; -*-

;; conda.el：在 Emacs 中激活/切换 conda 虚拟环境
;;
;; 用法：
;;   M-x conda-env-activate   -> 输入环境名（如 qa / DeepSeek）
;;   M-x conda-env-deactivate -> 退出环境
;;   M-x conda-env-list       -> 列出所有 conda 环境
;;
;; 激活后：run-python（C-c C-p）、执行 buffer（C-c C-c）、
;; eshell / shell 里的 python 均使用该环境的解释器。

(use-package conda
  :ensure t
  :init
  (setq conda-anaconda-home (expand-file-name "~/anaconda3"))
  :config
  (conda-env-initialize-interactive-shells)
  (conda-env-initialize-eshell))

(provide 'init-conda)
