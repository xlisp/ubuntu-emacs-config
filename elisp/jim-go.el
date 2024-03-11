;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; => https://zhuanlan.zhihu.com/p/605618990
;; go-mode
;; go install golang.org/x/tools/cmd/goimports@latest
;; go install golang.org/x/tools/gopls@latest
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; install go-mode:
;;(package-install 'go-mode) ;;=> 变成手动安装了：https://github.com/dominikh/go-mode.el
;; auto import before save
(setq gofmt-command "goimports")
(add-hook 'before-save-hook 'gofmt-before-save)
;; set tab-width
(add-hook 'go-mode-hook
          (lambda ()
            (setq indent-tabs-mode 1)
            (setq tab-width 4)))

(comment 

;; install Emacs LSP client package.
(package-install 'lsp-mode)
(use-package lsp-mode
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l")
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
         (go-mode . lsp)
         ;; if you want which-key integration
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)

;; lsp-ui
(package-install 'lsp-ui)
;; optionally
(use-package lsp-ui :commands lsp-ui-mode)
;; if you are helm user
(use-package helm-lsp :commands helm-lsp-workspace-symbol)
;; if you are ivy user
(use-package lsp-ivy :commands lsp-ivy-workspace-symbol)
(use-package lsp-treemacs :commands lsp-treemacs-errors-list)

;; dap-mode. optionally if you want to use debugger
(package-install 'dap-mode)
(use-package dap-mode)
;; (use-package dap-LANGUAGE) to load the dap adapter for your language
(use-package dap-go)

;; optional if you want which-key integration
(package-install 'which-key)
(use-package which-key
    :config
    (which-key-mode))


;; flycheck
(package-install 'flycheck)
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

)
;; auto-complete
(package-install 'company)
(global-company-mode)

(provide 'jim-go)
;;
