
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

;; 放常用的一些swift代码模式片段，Emacs来快速批量编辑，就像当初编辑生成小程序一样的,Elisp结合swfit代码来动态生成代码
(defun flex-row-uikit ()
  (interactive)
  (insert "
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        return stackView
    }()

    // stackView.addArrangedSubview(view1)
"))


(provide 'jim-swift)
