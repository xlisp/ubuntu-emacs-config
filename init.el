;; need proxy: https://github.com/radian-software/straight.el
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))
(setq package-enable-at-startup nil)

(setq  package-selected-packages
      '(ivy
        cider
        clojure-mode
        smartparens
        projectile
        ;;company
        ag
        counsel-projectile
        monokai-theme
        lispy
        multiple-cursors
        easy-kill
        yasnippet
        ;;company-posframe
        clj-refactor
        magit
        neotree
        multi-term
        exec-path-from-shell
        vterm
        doom-themes
        use-package
        dash
        wgrep
        wgrep-ag
        request
        ripgrep
        ;;esup => “Symbolic link to Git-controlled source file; follow link? (yes or no) ” #60
        ;;company-tabnine
        emmet-mode
        ;; markdown-mode
        prescient
        ivy-prescient
        clomacs
        s
        web-mode
        intero
        haskell-mode
        swift-mode
        racket-mode
        ;;term-keys
        ein ;; M-x ein:run launches a jupyter process from emacs, or,
        xonsh-mode ;; https://xon.sh/editors.html
        async ;; 不能用老的同步思维来写了，sleep 3 然后再做，到底做完没有？ => https://github.com/jwiegley/emacs-async
        reformatter ;;ruff-format
        flycheck-mypy
        gptel
        ))

;; FOR install: https://github.com/radian-software/straight.el
(defun install-libs ()
  (dolist (package package-selected-packages)
    (straight-use-package package)))

;; (straight-use-package "term-keys")

(install-libs)

;;

(add-to-list 'load-path "~/.emacs.d/go-mode.el")
(autoload 'go-mode "go-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.go\\'" . go-mode))

;; my setting
(load-theme 'doom-molokai t)


(windmove-default-keybindings)

;; (global-company-mode -1) ;;在mutil-term下面不用company补全
;;(add-hook 'prog-mode-hook 'company-mode)

;;(helm-mode 1)
(ivy-mode 1) ;; 现在的M-x的列表是ivy的列表: 不能按照历史来排序
(ivy-prescient-mode 1)

(counsel-projectile-mode 1)

;;(require 'helm-config)
;;(helm-projectile-on)

;; global:
;; Better Defaults
(setq-default
 inhibit-x-resources t
 ;; inhibit-splash-screen t
 ;; inhibit-startup-screen t
 initial-scratch-message ""
 ;; Don't highlight line when buffer is inactive
 hl-line-sticky-flag nil
 ;; Prefer horizental split
 split-height-threshold nil
 split-width-threshold 120
 ;; Don't create lockfiles
 create-lockfiles nil
 ;; UTF-8
 buffer-file-coding-system 'utf-8-unix
 default-file-name-coding-system 'utf-8-unix
 default-keyboard-coding-system 'utf-8-unix
 default-process-coding-system '(utf-8-unix . utf-8-unix)
 default-sendmail-coding-system 'utf-8-unix
 default-terminal-coding-system 'utf-8-unix
 ;; Add final newline
 require-final-newline t
 ;; Larger GC threshold
 gc-cons-threshold (* 100 1024 1024)
 ;; Backup setups
 backup-directory-alist `((".*" . ,temporary-file-directory))
 auto-save-file-name-transforms `((".*" ,temporary-file-directory t))
 backup-by-copying t
 delete-old-versions t
 kept-new-versions 6
 kept-old-versions 2
 version-control t
 ;; Xref no prompt
 xref-prompt-for-identifier nil
 ;; Mouse yank at point instead of click position.
 mouse-yank-at-point t
 ;; This fix the cursor movement lag
 auto-window-vscroll nil
 ;; Don't wait for keystrokes display
 echo-keystrokes 0
 show-paren-style 'parenthese
 ;; Overline no margin
 overline-margin 0
 tab-width 4
 ;; Don't show cursor in non selected window.
 cursor-in-non-selected-windows nil
 comment-empty-lines t)

(setq-default indent-tabs-mode nil)

(prefer-coding-system 'utf-8)

;; Show matched parens
(setq show-paren-delay 0.01)
(show-paren-mode 1)

;; Always use dir-locals.
(defun safe-local-variable-p (sym val) t)

;; Auto revert when file change.
(global-auto-revert-mode 1)

;; Delete trailing whitespace on save.
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Custom file path
;; Actually we don't need custom file, this file can be generated
;; accidentally, so we add this file to .gitignore and never load it.
(setq custom-file
      (if (null (getenv "PWD"))
          "~/.emacs.d/custom.el"
        "~/emacs_spark/custom.el"))

(menu-bar-mode -1)
(tool-bar-mode -1)
(condition-case nil
    (scroll-bar-mode -1)
  (error nil))

(projectile-global-mode 1)

;; steve
(defmacro comment (&rest body)
  "Comment out one or more s-expressions."
  nil)

(define-key global-map (kbd "C-x C-o") 'counsel-projectile-switch-project)
;; 需要在*scratch*的buffer下才能执行成功 # 搜索中文需要加一个空格在中文词后面
;; (define-key global-map (kbd "C-x C-a") 'counsel-projectile-ag)
(global-set-key
 (kbd "C-c C-a")
 (lambda ()
   (interactive)
   (call-interactively #'counsel-projectile-ag)))

;; C-c C-a 在java模式下面会被覆盖掉, C-x C-a在Elisp模式下会被覆盖掉
(global-set-key
 (kbd "C-x C-a")
 (lambda ()
   (interactive)
   (call-interactively #'counsel-projectile-ag)))

;; (define-key global-map (kbd "C-p") 'counsel-projectile-find-file) ;; 新版本的Emacs28会导致卡死
(global-set-key
 (kbd "C-p")
 (lambda ()
   (interactive)
   (if (string= "~/" default-directory)
       (progn
         (setq default-directory "/")
         (counsel-projectile-find-file))
     (counsel-projectile-find-file))))

;; 关闭所有buffer: 针对project来的 # 需要在vterm的buffer下面执行才有效=>会问你要不要关掉repl,你选择no,其他文件都会被关掉,关于这个项目的
(define-key global-map (kbd "C-c C-q") 'projectile-kill-buffers)

;; M-> & M-< 跳到最后;;*
(global-set-key (kbd "C-c m") 'end-of-buffer) ;; C-M-SPC
(global-set-key (kbd "M-g") 'goto-line)
;; "M-@"的当前选择光标开始选择
(global-set-key (kbd "M-2") 'set-mark-command)

;; 运行上一条执行的命令
(global-set-key (kbd "M-p") 'ivy-resume)

;; C-x C-v
(global-set-key (kbd "C-c k") 'find-alternate-file) ;; C-x k 是kill-buffer

;; (global-set-key (kbd "C-s") 'swiper)


;; M-w w 复制一个单词 和表达式
(global-set-key (kbd "M-w") 'easy-kill)

;; 多光标编辑: C-@选中 => C-> 下一个 ... => 回车退出 => C->在ssh上用不了
;; 直接M->会进行列选择矩形编辑: `C-w` 删除矩形选择,不能用delete键
(global-set-key (kbd "M->") 'mc/mark-next-like-this)
(global-set-key (kbd "M-<") 'mc/skip-to-next-like-this)

;; d 是 %, j下一个表达式 k上一个表达式, e是执行
;; s和w可以交换表达式, 大于号吞表达式,小于号吐出来表达式 ;; c克隆
;; 注释掉就可以避免lispy的编辑模式了, M-@ 一直按下去会向下选中
;; m 是选中一个s表达式: https://github.com/abo-abo/lispy ;; M-w 复制单行
;; M格式化多行, i是缩进 ==>> 不用写一个格式化数组的工具了: 用这个命令就能格式化树形的数组
;; 删除单个括号的办法: M-@选中单个括号就能删除它了
;; -和a_标记 可以vim模拟跳转点
;; M-shift-@ 是选中一个单词,连续按两下@@就是向前移动一个词会跳过-_
;; 不用选择任何字符 M-> 就是 矩形编辑
(add-hook 'emacs-lisp-mode-hook 'lispy-mode)
(add-hook 'clojure-mode-hook 'lispy-mode)
;;  a => 选择vim式的位置 ## 选得越快,用鼠标越少,编码越快
;; 选中一个symbol字符串, sexp ## sexp => list就是mark向外展开列表,m键无法往外展开
(defun mark-symbol ()
  (interactive)
  (let ((bounds (bounds-of-thing-at-point 'sexp)))
    (goto-char (cdr bounds))
    (push-mark (car bounds) t t)))
(define-key global-map (kbd "C-x m") 'mark-symbol)

;; 用 `emacs --daemon` => `emacsclient -c`
(require 'server)
(unless (server-running-p)
  (server-start))

(setq-default cider-default-cljs-repl 'shadow)
(setq cider-offer-to-open-cljs-app-in-browser nil)

(setq cider-prompt-for-symbol nil)

(require 'yasnippet)

(yas-reload-all)

;;(defun yas-or-company ()
;;  (interactive)
;;  (let ((yas/fallback-behavior 'return-nil))
;;    (or (yas/expand)
;;        ;; (company-complete-common) ;; 在空格处也会出来补全列表
;;        (call-interactively #'company-indent-or-complete-common))))

;;(use-package company :bind
;;  (("<tab>" . 'yas-or-company)
;;   ("TAB" . 'yas-or-company)))

(setq clojure-toplevel-inside-comment-form t)
;; 去掉强化的js补全,会导致很卡 => t是打开
(setq cider-enhanced-cljs-completion-p t)

(require 'hideshow)

;; 显示隐藏的comment: 多行的表达式的开关
(define-key global-map (kbd "C-x C-h") 'hs-toggle-hiding)

;; C-2出来用法注释
(defun user/clojure-hide-comment (&rest args)
  (save-mark-and-excursion
    (while (search-forward
            (concat  "(" "comment") nil t)
      (hs-hide-block))))
(add-hook 'clojure-mode-hook 'user/clojure-hide-comment)

;; Emacs也用了comment宏
(add-hook 'emacs-lisp-mode-hook 'user/clojure-hide-comment)

(add-hook 'prog-mode-hook #'hs-minor-mode)

;;(add-hook 'prog-mode-hook 'display-line-numbers-mode)

(defun my-clojure-mode-hook ()
  (clj-refactor-mode 1)
  (yas-minor-mode 1)        ; for adding require/use/import statements
  ;; This choice of keybinding leaves cider-macroexpand-1 unbound
  (cljr-add-keybindings-with-prefix "C-c C-m")
  (define-key global-map (kbd "C-c C-o") 'cider-pprint-eval-last-sexp-to-comment))
(add-hook 'clojure-mode-hook #'my-clojure-mode-hook)

(setq clojure-indent-style 'always-indent)
;; M-. cider定义跳转, M-, cider定义返回

(global-set-key [f8] 'neotree-toggle)

;; 解决Mac上面直接启动Emacs,而不是终端启动Emacs的PATH问题
(exec-path-from-shell-initialize)

;; 切换到scratch才能切换到其他项目来搜索文件
(global-set-key
 (kbd "C-x s")
 (lambda ()
   (interactive)
   (switch-to-buffer "*scratch*")
   (setq default-directory "/")
   (counsel-projectile-find-file)))

;; 可以ag查其他项目: 多项目切换方便一些,不用先打开一个文件在ag一下
;; TODO加一个选项,选择编程语言进行ag # 用一个语言的companing-read选择
(global-set-key
 (kbd "C-x f")
 (lambda ()
   (interactive)
   (switch-to-buffer "*scratch*")
   (setq  default-directory "/")
   (call-interactively #'counsel-projectile-ag)))

;; M-x describe-variable => `C-h v` 除了函数名字补全`C-h f`,键位名`C-h k`, 就是相关变量查询学习一个库的使用(源码式的学习)

;;;; multi-term中文的配置 => ~/.zshenv
(setq multi-term-program "/bin/zsh")
;; Use Emacs terminfo, not system terminfo, mac系统出现了4m
(setq system-uses-terminfo nil)
;; 解决中文显示不了的问题
;; export LANG='en_US.UTF-8'
;; export LC_ALL="en_US.UTF-8"
(add-hook
 'term-mode-hook
 (lambda () (yas-minor-mode -1)))

;; (global-set-key (kbd "C-x b") 'helm-buffers-list)

(defun push-it-real-good (&rest keys)
  (execute-kbd-macro
   (apply
    'vconcat
    (mapcar
     (lambda (k)
       (cond ((listp k) (apply 'append k))
             (t (read-kbd-macro k))))
     keys))))

;; 全局都用shadow ;;没用
(setq-default cider-default-cljs-repl 'shadow)

(require 'wgrep)
(require 'wgrep-ag) ;;装了这个之后就能用projectile-ag了

;; 很多函数式的方法: https://github.com/magnars/dash.el
(require 'dash)

;; === 分出去文件的配置: 不同的文件放不同的功能,整理好,为道益损 ===
(add-to-list 'load-path
             "~/.emacs.d/elisp/"
             ;; (if (null (getenv "PWD"))
             ;;     "~/.emacs.d/elisp/" ;; in Mac Emacs UI
             ;;   "~/emacs_spark/elisp/")
             )
(require 'zshrc-alias)  ;; zshrc alias的思想
(require 'kungfu)
;;(require 'code-search)
(require 'jim-elisp-regexp)
(require 'jim-proxy)
(require 'jim-config)
(require 'jim-lispy)
(require 'jim-eval-buffer)
(require 'jim-clj-alias)
(require 'jim-r-lisp)
(require 'jim-scaffold)
;; (require 'jim-tabnine)
(require 'jim-yasnipet)
(require 'jim-emmet)
(require 'jim-ivy)
(require 'jim-process)
;;(require 'jim-markdown)
(require 'jim-postwalk-editer)
(require 'jim-miniprogram)
(require 'jim-scheme)
(require 'jim-racket)
(require 'jim-haskell)
(require 'jim-dired)
(require 'jim-datalog)
(require 'jim-swift)
(require 'jim-hulu)
(require 'jim-go)

(defun tabnine-require ()
  (interactive)
  (require 'jim-tabnine))

;; 代理的repl会引起的编辑错误: 需要关掉disable-company
(defun disable-company ()
  (interactive)
  (global-company-mode -1))

;;------ 连接clojure和elisp的clomacs(包装了cider)
(add-to-list 'load-path "~/.emacs.d/postwalk-editer/src/elisp/")
(require 'postwalk-editer)
;; 需要M-x postwalk-editer-mdarkdown-to-html才会打开nrepl
;; === 配置结束 ===

(global-set-key (kbd "C-c v") 'jw-eval-or-clear-buffer)

;; dired 模式:
;; = M-x find-name-dired 输入* => C-x C-q => 修改文件名 可以用mutil-c => C-x C-s 或者 C-c C-c

;; TODO: 写很多Clojure的宏出来,写Elisp就像写clojure一样
;; https://github.com/plexus/a.el ;;
;; (a-get (a-list :foo 5 :bar 6) :foo) ;;=> 5

;; C-c SPC ## mvn的对齐
;; M-x toggle-debug-on-error # 出现错误就会捕捉到*Backtrace*里面

;; muti cursor来头部选一列,然后删除: 就能代替replace-string 替换掉空行问题
;; C-q C-j 加空行
(put 'downcase-region 'disabled nil)

(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)
;;
(put 'upcase-region 'disabled nil)
;;(setq mac-option-modifier 'none)
;;(setq mac-command-modifier 'meta)

(put 'dired-find-alternate-file 'disabled nil)

