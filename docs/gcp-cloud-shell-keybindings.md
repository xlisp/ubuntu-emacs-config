# GCP Cloud Shell 按键冲突修改记录

## 背景

GCP Cloud Shell 是浏览器内的终端 (基于 Hterm)。Chrome 浏览器会拦截一些 `Ctrl` 组合键,导致 Emacs 收不到原始按键:

| 拦截级别 | 按键 | 浏览器行为 |
|---------|------|----------|
| **强制拦截** (无法关闭) | `C-w` | 关闭标签页 |
|  | `C-t` | 新建标签页 |
|  | `C-n` | 新建窗口 |
|  | `C-1` ~ `C-9` | 切换到第 N 个标签 |
|  | `C-0` | 重置缩放 |
| **常被拦截** | `C-f` | 页内查找 |
|  | `C-s` | 保存网页 |
|  | `C-p` | 打印 |
|  | `C-r` | 刷新 |
|  | `C-l` | 焦点地址栏 |
|  | `C-d` | 收藏 |
|  | `C-h` | 历史 |
|  | `C-j` | 下载 |
|  | `C-u` | 查看源代码 |
|  | `C-o` | 打开文件 |

用户报告 `C-x C-f` (Emacs 的 find-file) 触发 GCP 查询页面:第一键 `C-x` 被终端捕获,但第二键 `C-f` 被浏览器拦截。

## 解决策略 (方案 B: 全面改造)

1. **第二键去 Ctrl**: 所有 `C-x C-<letter>` 和 `C-c C-<letter>` 序列,如果第二键的 letter 是被浏览器拦截的字母/数字,改成无 Ctrl 的 `C-x <letter>` / `C-c <letter>` 形式。
2. **单 Ctrl-letter 改 F-key 或 Meta**: 浏览器拦截的单键 (如 `C-w`, `C-p`) 改用 F1-F12 (浏览器从不拦截) 或 `M-Shift-<letter>` 替代。
3. **内置功能加别名**: Emacs 内置的 `C-x C-f`, `C-x C-s` 等可能仍能在 Hterm 中工作 (取决于 Hterm 设置),但也加上无 Ctrl 别名作为后备。

## 修改清单

### `init.el` 改动

| 原按键 | 新按键 | 功能 |
|--------|--------|------|
| `C-x C-o` | `C-x o` | `counsel-projectile-switch-project` |
| `C-x C-a` | `C-x a` | `counsel-projectile-ag` |
| `C-c C-a` | `C-c a` | `counsel-projectile-ag` (备份) |
| `C-c C-q` | `C-c q` | `projectile-kill-buffers` |
| `C-x C-h` | `C-x h` | `hs-toggle-hiding` |
| `C-c C-o` | `C-c o` | `cider-pprint-eval-last-sexp-to-comment` |
| `C-p` | `<f7>` | `counsel-projectile-find-file` (C-p 是浏览器打印) |

### `elisp/jim-lispy.el` 改动

第二键全部去掉 Ctrl,因为 Chrome 拦截 `C-1`-`C-9`、`C-0`、`C-p`:

| 原按键 | 新按键 | 功能 |
|--------|--------|------|
| `C-c C-0` | `C-c 0` | 反向搜索 `)` |
| `C-c C-1` | `C-c 1` | 正向搜索 `"` |
| `C-c C-2` | `C-c 2` | 正向搜索 `;` |
| `C-c C-3` | `C-c 3` | 正向搜索 `:` |
| `C-c C-4` | `C-c 4` | `insert-mark-id` |
| `C-c C-5` | `C-c 5` | 反向搜索 `]` |
| `C-c C-6` | `C-c 6` | 正向搜索 `[` |
| `C-c C-7` | `C-c 7` | 设置 forword-key |
| `C-c C-8` | `C-c 8` | 正向搜索 `{` |
| `C-c C-9` | `C-c 9` | 反向搜索 `(` / 正向搜索 `}` |
| `C-c C--` | `C-c -` | 按 forword-key 搜索 |
| `C-c C-p` | `C-c p` | 正向搜索 `>` |

### `elisp/kungfu.el` 改动

| 原按键 | 新按键 | 功能 |
|--------|--------|------|
| `C-c C-j` | `C-c j` | `rb-eval-expression-at-lambda` (C-j 是浏览器下载) |

### `elisp/jim-r-lisp.el` 改动

保留 `C-x C-e` (C-e 通常不被拦截),并额外加 `C-x e` 别名作后备。

### 新增 `elisp/jim-gcp-keybindings.el`

集中放置浏览器拦截的替代按键,在 `init.el` 末尾通过 `(require 'jim-gcp-keybindings)` 加载,确保覆盖之前的绑定。

**内置 `C-x C-<letter>` 大写别名:**

| 别名 | 等价于 | 功能 |
|------|--------|------|
| `C-x F` | `C-x C-f` | `find-file` |
| `C-x S` | `C-x C-s` | `save-buffer` |
| `C-x W` | `C-x C-w` | `write-file` |
| `C-x B` | `C-x b` | `switch-to-buffer` |
| `C-x C` | `C-x C-c` | `save-buffers-kill-emacs` |

**F-key 快捷键** (浏览器从不拦截):

| 按键 | 功能 |
|------|------|
| `<f2>` | `find-file` |
| `<f3>` | `save-buffer` |
| `<f4>` | `kill-this-buffer` |
| `<f7>` | `counsel-projectile-find-file` (在 init.el 中) |
| `<f8>` | `neotree-toggle` (在 init.el 中) |
| `<f9>` | `kill-region` (替代 `C-w`) |
| `<f10>` | `yank` (备份) |
| `<f11>` | `isearch-forward` (替代 `C-s`) |
| `<f12>` | `isearch-backward` (替代 `C-r`) |

**Meta-Shift 备份键:**

| 按键 | 功能 |
|------|------|
| `M-K` | `kill-region` (替代 `C-w`) |
| `M-T` | `transpose-chars` (替代 `C-t`) |

## 验证

```bash
cd ~/ubuntu-emacs-config
emacs --batch --eval "(byte-compile-file \"elisp/jim-gcp-keybindings.el\")"
```

字节编译成功 (除已有 free-variable / undefined-function 警告外无错误)。

实际使用:在 Cloud Shell 中启动 Emacs,试以下场景:
- `C-x o` 切项目 (原 `C-x C-o`)
- `C-x a` 在项目里 ag (原 `C-x C-a`)
- `<f7>` 项目内找文件 (原 `C-p`)
- `<f9>` 剪切区域 (替代 `C-w`)
- `<f11>` 增量搜索 (替代 `C-s`)
- `C-c 9` 跳到 `(` (原 `C-c C-9`)

## 没改动的按键

以下保留原绑定,因为第二键 (或单键) 通常不被浏览器拦截:

- `C-c C-c`, `C-c C-k` (Swift / Cider 风格的执行键)
- `C-c C-g` (`get-selected-text` / 反向搜索 `.`)
- `C-c C-m` (cljr 前缀)
- `C-c v`, `C-c k`, `C-c m`, `C-c w` 等单字母后缀
- `C-x m`, `C-x s`, `C-x f`, `C-x C-q` (单字母或非冲突字母)
- `M-w`, `M-g`, `M-p`, `M-2`, `M->`, `M-<` (Meta 系列基本透传)
- `[f8]` (neotree-toggle)

如果实际使用中发现某个保留的按键也被拦截,加到 `elisp/jim-gcp-keybindings.el` 中即可。
