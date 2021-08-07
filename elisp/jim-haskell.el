
(electric-indent-mode 0)

;; termux 上面会报错
(condition-case nil
    (intero-global-mode 1)
  (error nil))

(provide 'jim-haskell)
