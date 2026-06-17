;;; jim-gcp-keybindings.el --- GCP Cloud Shell 按键冲突解决方案 -*- lexical-binding: t; -*-
;;
;; 在 GCP Cloud Shell (浏览器终端) 中,Chrome 会拦截一些 Ctrl 组合键:
;;   强制拦截: C-w (关标签), C-t (新标签), C-n (新窗口), C-1..9 (切标签), C-0 (重置缩放)
;;   常被拦截: C-f, C-s, C-p, C-r, C-l, C-d, C-h, C-j, C-u, C-o
;;
;; 这个文件提供:
;;   1) Emacs 内置 `C-x C-<letter>' 序列的无第二 Ctrl 别名
;;   2) 浏览器强拦截的单 Ctrl-letter 的 F-key 替代
;;
;; 必须在 init.el 末尾加载,以覆盖之前的绑定.

;; --- 内置 C-x C-<letter> 的无 Ctrl 别名 ---
;; 注意: C-x f 和 C-x s 在 init.el 中已被用户重新绑定 (用 scratch 缓冲区切项目),
;; 所以这里用大写字母作为内置功能的别名.
(global-set-key (kbd "C-x F") 'find-file)            ;; 替代 C-x C-f
(global-set-key (kbd "C-x S") 'save-buffer)          ;; 替代 C-x C-s
(global-set-key (kbd "C-x W") 'write-file)           ;; 替代 C-x C-w
(global-set-key (kbd "C-x B") 'switch-to-buffer)     ;; C-x b 已是这个,加大写别名以保对称
(global-set-key (kbd "C-x C") 'save-buffers-kill-emacs) ;; 替代 C-x C-c

;; --- F-key 快捷键 (浏览器从不拦截 F-key) ---
;; <f7> = counsel-projectile-find-file (init.el)
;; <f8> = neotree-toggle (init.el)
(global-set-key (kbd "<f2>")  'find-file)            ;; 快速打开文件
(global-set-key (kbd "<f3>")  'save-buffer)          ;; 快速保存
(global-set-key (kbd "<f4>")  'kill-this-buffer)     ;; 关闭当前 buffer
(global-set-key (kbd "<f9>")  'kill-region)          ;; 替代 C-w (Chrome 关标签)
(global-set-key (kbd "<f10>") 'yank)                 ;; 替代 C-y (备份)
(global-set-key (kbd "<f11>") 'isearch-forward)      ;; 替代 C-s (浏览器保存网页)
(global-set-key (kbd "<f12>") 'isearch-backward)     ;; 替代 C-r (浏览器刷新)

;; --- 浏览器强拦截单 C-letter 的 Meta-Shift 替代 ---
;; Chrome 拦截 C-w / C-t / C-n 不可避免, 这些 Meta 键终端总能传过去.
(global-set-key (kbd "M-K") 'kill-region)            ;; 替代 C-w (M-W 容易被 easy-kill 干扰)
(global-set-key (kbd "M-T") 'transpose-chars)        ;; 替代 C-t

;; --- 备注 ---
;; C-n / C-p 用方向键 (下/上) 替代, 已是 Emacs 默认.
;; C-f / C-b 用方向键 (右/左) 替代.
;; C-x C-f 仍可工作如果终端透传 C-f; 不工作就用 C-x F 或 <f2>.

(provide 'jim-gcp-keybindings)
;;; jim-gcp-keybindings.el ends here
