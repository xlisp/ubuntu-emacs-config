(defun biancheng-api-jack ()
  (interactive)
  (setq project-name "BCPro/biancheng-api")
  (setq start-cljs-file "/Users/clojure/BCPro/biancheng-api/src/main/cljs/biancheng_breakfast/app.cljs")
  (setq start-clj-file "/Users/clojure/BCPro/biancheng-api/src/main/clojure/biancheng_api/core.clj")
  (call-interactively #'jackj))

(defun datalog-code-semantic-search-jack ()
  (interactive)
  (setq project-name "DatalogPro/datalog-code-semantic-search")
  (setq start-cljs-file "/Users/clojure/DatalogPro/datalog-code-semantic-search/src/cljs/hulunote/core.cljs")
  (setq start-clj-file "/Users/clojure/DatalogPro/datalog-code-semantic-search/src/clj/functor_api/core.clj")
  (call-interactively #'jackj))

(defun functor-api-jack ()
  (interactive)
  (setq project-name "FaceMashPro/functor-api")
  (setq start-cljs-file "/Users/clojure/FaceMashPro/functor-api/src/cljs/hulunote/core.cljs")
  (setq start-clj-file "/Users/clojure/FaceMashPro/functor-api/src/clj/functor_api/core.clj")
  (call-interactively #'jackj))

(defun functor-api-bak-jack ()
  (interactive)
  (setq project-name "FaceMashPro/functor-api-bak")
  (setq start-cljs-file "/Users/clojure/FaceMashPro/functor-api-bak/src/cljs/hulunote/core.cljs")
  (setq start-clj-file "/Users/clojure/FaceMashPro/functor-api-bak/src/clj/functor_api/core.clj")
  (call-interactively #'jackj))

(defun fp-visualgo-jack ()
  (interactive)
  (setq project-name "CljPro/functional-programming-visualgo")
  (setq start-cljs-file "/Users/clojure/CljPro/functional-programming-visualgo/src/main/cljs/functional_programming_visualgo_fp/app.cljs")
  (setq start-clj-file "/Users/clojure/CljPro/functional-programming-visualgo/src/main/clojure/functional_programming_visualgo/core.clj")
  (call-interactively #'jackj))

;; =========================

(defun biancheng-rider-mini-jack ()
  (interactive)
  (setq miniprogram-project-path "/Users/clojure/WeChatProjects/biancheng-rider")
  (setq miniprogram-file "/Users/clojure/WeChatProjects/biancheng-rider/src/mini_program_cljs_example/core.cljs")
  (call-interactively #'miniprogram-jack))

(defun hulunote-mini-jack ()
  (interactive)
  (setq miniprogram-project-path "/Users/clojure/HuluPro/hulunote-miniprogram")
  (setq miniprogram-file "/Users/clojure/HuluPro/hulunote-miniprogram/src/hulunote/core.cljs")
  (call-interactively #'miniprogram-jack))


(defun datoms-url ()
  (interactive)
  (insert
   "
(def athens-url \"http://127.0.0.1:6688/data/athens.datoms\")
(def help-url   \"http://127.0.0.1:6688/data/help.datoms\")
(def ego-url    \"http://127.0.0.1:6688/data/ego.datoms\")
"))

;; ds-dom的万能钥匙 ;; `ls -R`的功能
;; (pull ?node [:db/id :dom/tag :class {:_child ...}]) ## 反向
;; ;; 递归查询所有的子节点来看看结构对不对,发现h2的子节点没有div:zhihu
(defun ds-dom ()
  (interactive)
  (insert
   "
(pull ?content-node [:db/id :dom/tag :class {:child ...}])
"))

;; 万能的missing
(defun ds-miss ()
  (interactive)
  (insert
   "
[?node _ _]
"))

(defun to-ds ()
  (interactive)
  (insert
   "
(clojure.walk/postwalk
    (fn [x]
      (if (map? x)
        ;; {:nav (:content x)}
        (cond
          (not-empty (:parid x))
          , (do
              {:nav (:content x) :child (:parid x)})
          :else
          , (do
              {:nav (:content x)}))
        x))
    [@(re-frame/subscribe [:get-nav-sub-tree [:id id]])])
"))

(setq my-hulu-api "https://www.hulunote.com/myapi/quick-text-put/7fcbdbafe18e4ff68c02f83254644b82")

(provide 'jim-env)
