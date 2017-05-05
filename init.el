;; ----------Package Management
 
;; --- source ---------
 (when (>= emacs-major-version 24)
     (require 'package)
     (package-initialize)
     (setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
              ("melpa" . "http://elpa.emacs-china.org/melpa/"))))
 
;; cl - Common Lisp Extension
(require 'cl);; loop 为common lisp 的扩展
 
;; Add Packages
(defvar my/packages '(
           ;; --- Auto-completion ---
           ;;company
           ;; --- Better Editor ---
           evil
           evil-leader
           smooth-scrolling
           hungry-delete
           swiper
           counsel
           smartparens
           ;; popwin
           ;; -- python
           elpy
	   ;; -- webmode
	   web-mode
	   js2-mode
           ;; --- Themes ---
           monokai-theme
           ;; --- Window Jump --
           ace-link
           window-numbering
           ) "Default packages")
 
(setq package-selected-packages my/packages)
 
(defun my/packages-installed-p ()
    (loop for pkg in my/packages
      when (not (package-installed-p pkg)) do (return nil)
      finally (return t)))
 
(unless (my/packages-installed-p)
    (message "%s" "Refreshing package database...")
    (package-refresh-contents)
    (dolist (pkg my/packages)
      (when (not (package-installed-p pkg))
    (package-install pkg))))
 
;;(global-company-mode 1)
;;(add-hook 'after-init-hook 'global-company-mode)
;;(setq company-dabbrev-downcase nil)
 
(elpy-enable)
(require 'hungry-delete)
(global-hungry-delete-mode)
 
(global-set-key (kbd "M-p") 'ace-window)
 
(window-numbering-mode 1)

;; -- webmode
(setq auto-mode-alist
      (append
       '(("\\.js\\'" . js2-mode))
       '(("\\.html\\'" . web-mode))
       auto-mode-alist))
(defun my-web-mode-indent-setup ()
  (setq web-mode-markup-indent-offset 2) ; web-mode, html tag in html file
  (setq web-mode-css-indent-offset 2)    ; web-mode, css in html file
  (setq web-mode-code-indent-offset 2)   ; web-mode, js code in html file
  )
(add-hook 'web-mode-hook 'my-web-mode-indent-setup)

(add-to-list 'load-path "~/.emacs.d/js2-mode") 
(autoload 'js2-mode "js2-mode" nil t) 
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;; --- Leader Key ----
(require 'evil-leader)
(global-evil-leader-mode)
(evil-leader/set-leader "<SPC>")
 
(evil-leader/set-key
  ;; --- M-x ---
  "x"  'counsel-M-x
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
  ;; ---Scroll ---
  "p" 'scroll-down
  "n" 'scroll-up
  ;; ---Window ---
  "1"  'select-window-1
  "2"  'select-window-2
  "3"  'select-window-3
  "4"  'select-window-4
  "swr" 'split-window-right
  "swb" 'split-window-below
  "dow" 'delete-other-windows
  "dw" 'delete-window
  "al" 'ace-link
   ;; --- EWW
  "eww" 'eww
  "ewb" 'eww-back-url
  "elb" 'eww-list-bookmarks
  "eab" 'eww-add-bookmark
  ;;--- kill emacs
  "ke" 'kill-emacs
  ;; -- jump
  "gl" 'goto-line
  ;; --- shell
  "sh" 'shell
  "sc" 'shell-command
  ;; -- modes
  "am" 'artist-mode
  ;; -- find--
  "lml" 'list-matching-lines
  "rs" 'replace-string
  "qr" 'query-replace

  )
 
 
(require 'evil)
(evil-mode 1) ;以上的是设置启动emacs载入evil
 
 
(global-set-key "\C-s" 'swiper)
 
(load-theme 'monokai 1)
 
 
(global-set-key (kbd "M-x") 'smex)
 
 
 ;;git-emacs
(add-to-list 'load-path "./git-emacs/")
(require 'git-emacs)
 
;; ------ Common Set -----
(global-hl-line-mode 1)
(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(window-divider-mode -1)
;;(setq inhibit-splash-screen t)
;;(setq-default cursor-type 'bar)

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
 
;; --------------- Org --------------
(org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (emacs-lisp         . t)
   (dot        . t)
   (plantuml . t)
   (python . t)
   ))
 
(setq org-plantuml-jar-path
      (expand-file-name "~/.emacs.d/scripts/plantuml.jar"))
;; --预览
(add-hook 'org-babel-after-execute-hook 'bh/display-inline-images 'append)
; Make babel results blocks lowercase
(setq org-babel-results-keyword "results")
(defun bh/display-inline-images ()
  (condition-case nil
      (org-display-inline-images)
    (error nil)))
 
;;要想语法高亮代码块中的代码,可以将下面代码放到 .emacs 初始化文件中:
(setq org-confirm-babel-evaluate nil
      org-src-fontify-natively t)
