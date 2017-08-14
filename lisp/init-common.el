
;; ------ Common Set -----
(global-hl-line-mode 1)
(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(window-divider-mode -1)

;; ------font ------
;(set-default-font "DejaVu Sans Mono 11")
(set-fontset-font (frame-parameter nil 'font)
		  'han '("宋体"."unicode-bmp"))
;;(setq inhibit-splash-screen t)
;;(setq-default cursor-type 'bar)

;; code
;; -- 编码 --
(setq default-buffer-file-coding-system 'utf-8)  
(prefer-coding-system 'utf-8)  



;;自动插入匹配的括号
(setq skeleton-pair t)
(global-set-key (kbd "(") 'skeleton-pair-insert-maybe)    
(global-set-key (kbd "{") 'skeleton-pair-insert-maybe)    
(global-set-key (kbd "\'") 'skeleton-pair-insert-maybe)    
(global-set-key (kbd "\"") 'skeleton-pair-insert-maybe)    
(global-set-key (kbd "[") 'skeleton-pair-insert-maybe)    


;; 四分屏
(defun split-window-to-four()
  "split current frame to four"
  (interactive)
  (progn
    (split-window-horizontally)
    (set-window-buffer (next-window) (current-buffer))
    (split-window-vertically)
    (set-window-buffer (next-window) (current-buffer))
    (other-window 2)
    (split-window-vertically)
    (set-window-buffer (next-window) (current-buffer))
    (other-window -2)))


(defun my-c-mode-set ()
  (c-set-style "k&r")
  (hs-minor-mode t)
;;在状态条上显示当前光标在哪个函数体内部
  (which-function-mode)
;; 设置C/C++语言缩进字符数
  (setq c-basic-offset 4))

(add-hook 'c-mode-hook 'my-c-mode-set)
(add-hook 'c++-mode-hook 'my-c-mode-set)



(setq  initial-frame-alist (quote ((fullscreen . maximized))))
;; 关闭启动帮助画面
(setq inhibit-splash-screen 1)
;;(global-hl-line-mode t)
(setq make-backup-files nil)
(global-linum-mode 1)
 
;; recent open files
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-item 10)
 
(delete-selection-mode 1)
 
;;下面的代码可以是 Emacs 自动加载外部修改过的文件。
(global-auto-revert-mode 1)
 
;;使用下面的代码可以关闭自己生产的保存文件（之前我们已经关闭过了 Emacs 自动生产的 备份文件了，现在是关闭自动保存文件）。
(setq auto-save-default nil)
 
 
;; ----------- Dired Mode -----------------
;;+ 创建目录
;;g 刷新目录
;;C 拷贝
;;D 删除
;;R 重命名
;;d 标记删除
;;u 取消标记
;;x 执行所有的标记
;;这里有几点可以优化的地方。第一是删除目录的时候 Emacs 会询问是否递归删除或拷贝， 这也有些麻烦我们可以用下面的配置将其设定为默认递归删除目录（出于安全原因的考虑， 也许你需要保持此行为。所有文中的配置请务必按需配置）。
 
(setq dired-recursive-deletes 'always)
(setq dired-recursive-copies 'always)
 
;;第二是，每一次你进入一个回车进入一个新的目录中是，一个新的缓冲区就会被建立。这使 得我们的缓冲区列表中充满了大量没有实际意义的记录。我们可以使用下面的代码，让 Emacs 重用唯一的一个缓冲区作为 Dired Mode 显示专用缓冲区。
 
(put 'dired-find-alternate-file 'disabled nil)
 
;; 主动加载 Dired Mode
;; (require 'dired)
;; (defined-key dired-mode-map (kbd "RET") 'dired-find-alternate-file)
 
;; 延迟加载
(with-eval-after-load 'dired
    (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file))
 
;;启用 dired-x 可以让每一次进入 Dired 模式时，使用新的快捷键 C-x C-j 就可以进 入当前文件夹的所在的路径。
(require 'dired-x)
 

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ecb-options-version "2.50")
 '(ecb-source-path (quote (("f:" "f:") ("e:" "e:"))))
 '(grep-command "grep -nH -r ")
 '(grep-find-command (quote ("find . -type f -exec -nH -r {} NUL \";\"" . 28)))
 '(grep-find-template
   "find <D> <X> -type f <F> -exec grep <C> -n -e <R> {} NUL \";\"")
 '(grep-highlight-matches nil)
 '(grep-template "grep <X> <C> -n -e <R> <F>")
 '(grep-use-null-device t)
 '(package-selected-packages
   (quote
    (flycheck go-autocomplete go-mode graphviz-dot-mode ecb xcscope auto-complete evil evil-leader smooth-scrolling hungry-delete swiper counsel smartparens elpy web-mode js2-mode monokai-theme ace-link window-numbering))))


(setq doc-view-ghostscript-program "gswin64c")


;; -- git bash ---
(defun git-bash ()
  "Run git bash in shell mode."
  (interactive)
  (let ((explicit-shell-file-name "C:/Git/git-bash"))
    (call-interactively 'shell)))

;; When running in Windows, we want to use an alternate shell so we
;; can be more unixy.
;;(setq shell-file-name "C:/cygwin64/bin/bash")
;;(setq explicit-shell-file-name shell-file-name)
;;(setenv "PATH"
;;    (concat ".:/usr/local/bin:/mingw/bin:/bin:/cygdrive/c/Git/bin:/cygdrive/c/OpenSSH/bin:"
;;        (replace-regexp-in-string " " "\\\\ "
;;            (replace-regexp-in-string "\\\\" "/"
;;                (replace-regexp-in-string "\\([A-Za-z]\\):" "/\\1"
;;                    (getenv "PATH"))))))


;; key -map


;; --- Leader Key ----
(require 'evil-leader)
(global-evil-leader-mode)
(evil-leader/set-leader "<SPC>")
 
(evil-leader/set-key
  ;; --- M-x ---
  "x"  'counsel-M-x
  "sh" 'shell
  "sc" 'shell-command
  ;; --- File ---
  "ff" 'find-file
  "fow" 'find-file-other-window
  "rf" 'recentf-open-files
  ;; -- dired
  "dir" 'dired
  ;; ---Buffer----
  "sb" 'save-buffer
  "stb" 'switch-to-buffer
  "eb" 'eval-buffer
  "mwb" 'mark-whole-buffer
  "lb" 'list-buffers
  "lp" 'list-packages
  "rb" 'rename-buffer
  "kb" 'kill-buffer

  ;; --- checker ---
  "fm" 'flycheck-mode
  "lfe" 'list-flycheck-errors

  ;; ---Scroll ---
  "p" 'scroll-down
  "n" 'scroll-up
  ;; ---Window ---
  "1"  'select-window-1
  "2"  'select-window-2
  "3"  'select-window-3
  "4"  'select-window-4
  "5"  'select-window-5
  "6"  'select-window-6
  "7"  'select-window-7
  "8"  'select-window-8
  "9"  'select-window-9
  "swr" 'split-window-right
  "swb" 'split-window-below
  "swf" 'split-window-to-four
  "dow" 'delete-other-windows
  "dw" 'delete-window
  "al" 'ace-link
  ;;--- kill emacs
  "ke" 'kill-emacs
  ;; -- jump
  "gl" 'goto-line
  ;; -- modes
  "am" 'artist-mode
  ;; -- find--
  "lml" 'list-matching-lines
  "rs" 'replace-string
  "qr" 'query-replace
  ;; -- auto complete--
  "ac" 'auto-complete-mode

  ;; -- code browser
  "ed" 'ecb-dired-directory-other-window
  "eg" 'ecb-grep-find-directory
  "gr" 'grep

  ;; -- go --
  "ga" 'go-goto-arguments
  "gd" 'go-goto-docstring
  "gf" 'go-goto-function
  "gn" 'go-goto-function-name
  "gv" 'go-goto-return-values
  "gm" 'go-goto-method-receiver
  "gofmt" 'gofmt
  "gj" 'godef-jump

  ;; -- c++ ------
  "cfg" 'cscope-find-global-definition ;;搜索定义
  "cft" 'cscope-find-this-symbol'
;;;;(global-set-key [C-,] 'cscope-pop-mark) ;; 跳出转向
;;;;(enable-visual-studio-bookmarks) ;; 启动VS书签子程序
;;;;(setq semanticdb-project-roots (list "d:/work")) ;; 设置cemanticdb的扫描根目录


  ;; --- eww -----
  "ew" 'eww
  "eu" 'eww-back-url

  ;; --- help ---
  "in" 'info

  )

 
(require 'evil)
(evil-mode 1) ;以上的是设置启动emacs载入evil
 
 
(global-set-key "\C-s" 'swiper)
 
;;;(add-hook 'after-init-hook #'split-window-to-four)


(provide 'init-common)
