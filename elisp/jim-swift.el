
;;https://github.com/swift-emacs/swift-mode#swift-mode => 用M-x package-install-file安装
;;;; 1. `M-x run-swift`
;; M-x swift-mode:send-region
;; 2. `M-x swift-mode:send-buffer` => 绑定C-c C-k # Lisp化,习惯一样

(add-hook
 'swift-mode-hook
 (lambda ()
   (global-set-key
    (kbd "C-c C-k")
    (lambda ()
      (interactive)
      (push-it-real-good
       "M-x" "swift-mode:send-buffer"
       "<return>") ))))

(add-hook
 'swift-mode-hook
 (lambda ()
   (global-set-key
    (kbd "C-c C-c")
    (lambda ()
      (interactive)
      (push-it-real-good
       "M-x" "swift-mode:send-region"
       "<return>") ))))

(provide 'jim-swift)
