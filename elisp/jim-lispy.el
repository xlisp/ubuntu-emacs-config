(defun get-point (symbol &optional arg)
  "get the point"
  (funcall symbol arg)
  (point))

(defun copy-thing (begin-of-thing end-of-thing &optional arg)
  "Copy thing between beg & end into kill ring."
  (save-excursion
    (let ((beg (get-point begin-of-thing 1))
          (end (get-point end-of-thing arg)))
      (copy-region-as-kill beg end))))

(defun copy-word (&optional arg)
  "Copy words at point into kill-ring"
  (interactive "P")
  (copy-thing 'backward-word 'forward-word arg)
  ;;(paste-to-mark arg)
  )
(global-set-key (kbd "C-c w") (quote copy-word))

;; 适用于非lispy的情况的括号跳转: %
(defun match-paren (arg)
  "Go to the matching paren if on a paren; otherwise insert %."
  (interactive "p")
  (cond
   ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
   ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
   (t (self-insert-command (or arg 1)))))

(defun reverse-forward-dot ()
  (interactive "P")
  (re-search-backward "\\." nil t))

(global-set-key "%" 'match-paren)
(global-set-key (kbd "C-c C-g")
                (lambda ()
                  (interactive)
                  (re-search-backward "\\." nil t)
                  ;; (interactive)
                  ;; (call-interactively #'reverse-forward-dot)
                  ))
;; 测试多选也能后退一个点.
;; dasdas.dsadsad
;; 321dasdas.dsadsad
;; das321321das.dsadsad

;; 批量操作时跳转到左右括号
(global-set-key
 (kbd "C-c C-9")
 (lambda ()
   (interactive)
   (re-search-backward "(" nil t)))

(global-set-key
 (kbd "C-c C-0")
 (lambda ()
   (interactive)
   (re-search-backward ")" nil t)))

;; 跳转到"后面: 用于多行编辑的时候,同时跳转
(global-set-key
 (kbd "C-c C-1")
 (lambda ()
   (interactive)
   (re-search-forward "\"" nil t)))

(global-set-key
 (kbd "C-c C-9")
 (lambda ()
   (interactive)
   (re-search-backward "\"" nil t)))

;; CSS样式格式转换的时候,宏编辑器批量修改`:`和`;`和` `
(global-set-key
 (kbd "C-c C-2")
 (lambda ()
   (interactive)
   (re-search-forward ";" nil t)))
(global-set-key
 (kbd "C-c C-3")
 (lambda ()
   (interactive)
   (re-search-forward ":" nil t)))
(global-set-key
 (kbd "C-c C-4")
 (lambda ()
   (interactive)
   (re-search-forward " " nil t)))

(global-set-key
 (kbd "C-c C-5")
 (lambda ()
   (interactive)
   (re-search-backward "]" nil t)))

(global-set-key
 (kbd "C-c C-6")
 (lambda ()
   (interactive)
   (re-search-forward "\\[" nil t)))

(global-set-key
 (kbd "C-c C-7")
 (lambda ()
   (interactive)
   (re-search-forward "tip2" nil t)))

(global-set-key
 (kbd "C-c C-8")
 (lambda ()
   (interactive)
   (re-search-forward "{" nil t)))

(global-set-key
 (kbd "C-c C--")
 (lambda ()
   (interactive)
   (re-search-forward "(" nil t)))

(defun get-class-name ()
  (format "classId-%d" (random 999999999999)))

;; 选中`:style {...}` 执行替换为`:class "id" `
(defun get-selected-text (start end)
  (interactive "r")
  (if (use-region-p)
      (let* ((regionp (buffer-substring start end))
             (cname (get-class-name)))
        (cond ((string-match "\\(.*\\)\(\\(.*\\)" regionp) (message ""))
              ((string-match "\\(.*\\)\)\\(.*\\)" regionp) (message ""))
              ((string-match "\\(.*\\)@\\(.*\\)" regionp) (message ""))
              (t
               (progn ;; 变成clojure数据来处理成css
                 (message (concat ":" cname "" (replace-regexp-in-string ":style" "" regionp)))
                 (kill-region start end)
                 (insert (concat ":class \"" cname "\""))))))))

(defun get-selected-text-base (start end)
  (interactive "r")
    (if (use-region-p)
        (let ((regionp (buffer-substring start end)))
            (message regionp))))

;; 
(global-set-key (kbd "C-c C-g") 'get-selected-text)

(defun message-clear ()
  (interactive "r")
  (message (format "=======================%d\n\n\n\n\n\n" (random 999999999999))))

(global-set-key
 (kbd "C-c C-9")
 (lambda ()
   (interactive)
   (re-search-forward "}" nil t)))

;; (re-search-forward "tip2" nil t)

(provide 'jim-lispy)
