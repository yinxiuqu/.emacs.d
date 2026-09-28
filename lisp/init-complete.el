;;; 配置所有自动补全的插件

;; 配置company-mode
(use-package company
  :ensure t
  :init (global-company-mode)
  :config
  (setq company-minimum-prefix-length 1) ; 只需敲 1 个字母就开始进行自动补全
  (setq company-tooltip-align-annotations t) ; 对齐注释
  (setq company-idle-delay 0.2) ;延迟0.2妙
  (setq company-show-numbers t) ;; 给选项编号 (按快捷键 M-1、M-2 等等来进行选择).
  (setq company-backends (delete 'company-ispell company-backends));; 禁用 company-ispell（拼写补全）
  (add-to-list 'company-backends 'company-capf) ;; 接入 LSP 补全（pyright/其他语言服务器）
  (setq company-selection-wrap-around t);; 启用循环选择
  (setq company-transformers '(company-sort-by-occurrence)) ; 根据选择的频率进行排序，如果不喜欢可以去掉
;  (setq company-backends (cons 'company-yasnippet company-backends))
;  (define-key company-active-map (kbd "TAB") 'company-yasnippet)
  (define-key company-active-map (kbd "ESC") 'company-abort)) ; ESC键退出补全窗口

;; 设置yasnippet
(require 'yasnippet)
(yas-reload-all)
(yas-global-mode t)
(setq yas-snippet-dirs '("~/.emacs.d/snippets"))

;; ---------- 括号/引号配对：按模式分工 ----------
;; 原则：同一个 buffer 只允许一个"配对主人"。两套系统都挂在 `post-self-insert-hook'
;; 上（smartparens 的处理器是 buffer-local 挂载），同时负责同一个按键会让行为依赖
;; hook 顺序与 strict 状态，难以预测。
;;   * smartparens 负责：python / haskell / org / lisp 家族
;;     （electric-pair 给不了的语言级行为：python 的 '''/""" 与 `(' 后处理补冒号，
;;      haskell 的 {- -}、{-# #-}，org 的 * ~ = 标记配对，lisp 家族对 ' 的显式策略）
;;   * electric-pair-mode 负责：其余所有模式，含 AUCTeX LaTeX-mode
;;     （AUCTeX 自己接管 ( { $ 三个键并用 insert 绕过这两个包，实测 electric-pair
;;      与它配合能得到 $ 配对。若想改用 AUCTeX 原生方案，取消 init-latex.el 中
;;      TeX-electric-math 那几行的注释即可。）

;; 全局默认：交给 electric-pair（更轻，且与 AUCTeX 配合良好）
(electric-pair-mode t)

;; 先加载 Org 模式
(use-package org
  :ensure t
  :demand t;强制立即加载,不延迟
  :config
  (require 'org-element))

;; smartparens：不再使用 smartparens-global-mode，改为只在下列模式里接管
(use-package smartparens
  :ensure t
  :after org
  :config
  (require 'smartparens-config))   ; 内置配对表 + python/haskell/org 等语言模块

(defvar my-smartparens-hooks
  '(python-mode-hook
    python-ts-mode-hook            ; .py 经 major-mode-remap-alist 走它（见 init-python.el）
    haskell-mode-hook
    org-mode-hook
    emacs-lisp-mode-hook
    lisp-mode-hook
    lisp-interaction-mode-hook)
  "由 smartparens 接管配对与高亮的 mode hook 列表。")

(defun my-smartparens-takeover ()
  "在 smartparens 接管的 buffer 里：让 electric-pair 让位，并只保留一套括号高亮。"
  (electric-pair-local-mode -1)     ; 配对插入交给 smartparens，避免两套处理器抢同一个键
  (smartparens-mode 1)
  (show-smartparens-mode 1)         ; 用 smartparens 的高亮（支持它自定义的配对）
  (show-paren-local-mode -1))       ; 关掉本 buffer 的 show-paren，避免重复高亮

(dolist (hook my-smartparens-hooks)
  (add-hook hook #'my-smartparens-takeover))

;; 严格结构化删除（删一个括号连配对一起删）只在 lisp 家族启用。
;; 注意：smartparens-strict-mode 是 buffer-local 的；全局版
;; smartparens-global-strict-mode 会在所有 buffer 里连带打开 smartparens-mode，
;; 破坏上面的分工，因此不使用它。
(dolist (hook '(emacs-lisp-mode-hook lisp-mode-hook lisp-interaction-mode-hook))
  (add-hook hook #'smartparens-strict-mode))

;; strict 模式会把这些键重映射为 sp-* 版本（来自 smartparens-strict-mode-map）：
;;   C-d / <delete> / <backspace> -> sp-delete-char / sp-backward-delete-char
;;   M-d -> sp-kill-word    C-w -> sp-kill-region    C-S-k -> sp-kill-whole-line
;;   C-k -> sp-kill-hybrid-sexp
;; 实测 C-k 的新行为比 kill-line 更安全：在 "(setq x| 1)" 上 kill-line 会把右括号
;; 一起割断（破坏结构），sp-kill-hybrid-sexp 只杀到右括号之前、保持配对平衡
;; （只有 C-u C-u C-k 才是整块杀 sexp），所以保留它。若仍想恢复原生 C-k，取消下行注释：
;; (define-key smartparens-strict-mode-map [remap kill-line] nil)

;; 原 LaTeX 的 (sp-local-pair "$" "$") 已移除：LaTeX 现在归 electric-pair，
;; smartparens 在该 buffer 不启用，那条配对不会生效。原写法留此备查：
;;  (sp-with-modes '(LaTeX-mode)
;;    (sp-local-pair "$" "$" :actions '(insert wrap)))
;;  (sp-local-pair "{" "}" :actions '(insert wrap))) ; :actions：指定触发行为，
                                        ; insert 表示输入左括号时自动插入右括号
                                        ; wrap 表示选中文本后按 { 键会包裹文本。

;; 注意：C-<down> 的绑定由 init-copilot.el 统一管理（copilot 逐行接受）。
;; 原先这里 global-unset-key 再被 init-copilot.el 覆盖，属无效代码，已删除。

;; ---------- ido：只接管文件/缓冲区切换，不接管 completing-read ----------
;; 冲突评估（Emacs 30.1 实测）：
;;   * (ido-mode 1) 只重绑 C-x C-f / C-x b / C-x d 等"切换类"按键，开启后
;;     ido-everywhere 仍为 nil、completing-read-function 仍是 completing-read-default、
;;     read-file-name-function 也不变 —— 所以 M-x、AUCTeX 的约 900 处 completing-read、
;;     lsp-mode 的 39 处、org 的 81 处都不受影响，与 company/yasnippet 更是两条通道
;;     （company 走 completion-at-point，不动 minibuffer）。
;;   * (ido-everywhere 1) 则会把 completing-read-function 全局换成 ido-completing-read，
;;     上述调用点会丢失 :annotation-function/:affixation-function 等候选元信息
;;     （注释/附加信息不再显示），这才是"会冲突"的那一半，故不启用。
;;     确实想全部走 ido 时，自行取消下面这一行的注释：
;; (ido-everywhere 1)
(require 'ido)                    ; 显式加载，保证下面的变量已定义（也避免字节编译告警）
(ido-mode 1)                      ; 文件/缓冲区/dired 切换走 ido；与 use-file-dialog nil 互补
(setq ido-enable-flex-matching t) ; 模糊匹配（默认只做子串匹配）；ido-case-fold 默认已为 t

;; 与既有组件的配合（无需额外配置，仅记录）：
;;   * yasnippet 的默认 prompt 链里含 yas-maybe-ido-prompt，检测到 ido-mode 会自动改用 ido
;;   * haskell-mode 的 haskell-completing-read-function 默认就是 ido-completing-read
;;   * lsp-mode 自带 lsp-ido.el，可用 M-x lsp-ido-workspace-symbol 以 ido 方式搜工作区符号
;; ido 会把目录历史写到 ~/.emacs.d/ido.last（该文件已加入 .gitignore）

;; 文件结尾
(provide 'init-complete)
