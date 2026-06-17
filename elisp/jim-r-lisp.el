(defun ess-eval-sexp (vis)
  (interactive "P")
  (save-excursion
    (backward-sexp)
    (let ((end (point)))
      (forward-sexp)
      (ess-eval-region (point) end vis "Eval sexp"))))

;; 保留 C-x C-e (C-e 通常不被 Chrome 拦截), 并额外加 C-x e 别名以防万一
(add-hook 'ess-mode-hook
          (lambda ()
            (define-key global-map (kbd "C-x C-e") 'ess-eval-sexp)
            (define-key global-map (kbd "C-x e") 'ess-eval-sexp)))

(provide 'jim-r-lisp)
