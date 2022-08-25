
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

(defun label-uikit ()
  (interactive)
  (insert "
        let titleView = UILabel()
        titleView.font = UIFont.systemFont(ofSize: 18)
        titleView.text = hulu
"))

(defun button-uikit ()
  (interactive)
  (insert "
        let buttonr2 = UIButton()
        buttonr2.setImage(UIImage(named: \"r2d2\"), for: .normal)
        view.addSubview(buttonr2) { make in
            make.width.equalTo(32)
            make.height.equalTo(32)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-40)
            make.top.equalToSuperview().offset(-20)
        }
        buttonr2.addTarget(self, action: #selector(didTapR2D2Se), for: .touchUpInside)
        //
        @objc private func didTapR2D2Se() {
        }
"))

;; === 模板yas TODO
(defun a1 ()
  (interactive)
  (insert ""))

(provide 'jim-swift)
