
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
	   auto-complete
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
	   ;; -- c/c++
	   xcscope
           ) "Default packages")

;; -- checker ---
(add-hook 'after-init-hook #'global-flycheck-mode)
(add-to-list 'display-buffer-alist
             `(,(rx bos "*Flycheck errors*" eos)
              (display-buffer-reuse-window
               display-buffer-in-side-window)
              (side            . bottom)
              (reusable-frames . visible)
              (window-height   . 0.2)))


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

;; -- auto complete
(ac-config-default)
(setq ac-use-menu-map t)
(define-key ac-menu-map "\C-n" 'ac-next)
(define-key ac-menu-map "\C-p" 'ac-previous)

;; -- c/c++
;;(require 'xcscope)
;;(add-hook 'c-mode-common-hook '(lambda() (require 'xcscope)))

(require 'xcscope) ;;加载xcscope
(require 'cedet) ;;加载cedet


;; ----ecb -----
(require 'ecb) ;;加载ecb
;;;; 自动启动ecb，并且不显示每日提示
(setq ecb-auto-activate t
      ecb-tip-of-the-day nil)

;;(global-set-key [C-.] 'cscope-find-global-definition) ;;搜索定义
;;;;(global-set-key [C-,] 'cscope-pop-mark) ;; 跳出转向
;;;;(enable-visual-studio-bookmarks) ;; 启动VS书签子程序
;;;;(setq semanticdb-project-roots (list "d:/work")) ;; 设置cemanticdb的扫描根目录
(add-hook 'c-mode-common-hook ( lambda() ( c-set-style "k&r" ) ) ) ;;设置C语言默认格式
(add-hook 'c++-mode-common-hook ( lambda() ( c-set-style "k&r" ) ) ) ;;设置C++语言默认格式 


;; -- go lang --
(require 'go-mode)
(require 'go-autocomplete)
(require 'auto-complete-config)
(ac-config-default)

(add-to-list 'load-path "~/.emacs.d/go-mode")

;; theme
(load-theme 'monokai 1)


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
  "ea" 'ecb-activate ;;定义F12键为激活ecb
  "ed" 'ecb-deactivate ;;定义Ctrl+F12为停止ecb
  "eh" 'ecb-hide-ecb-windows
  "es" 'ecb-show-ecb-windows
  "eo" 'ecb-open-source-in-editwin1
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

  ;; --- eww -----
  "ew" 'eww
  "eu" 'eww-back-url

  )

 
(require 'evil)
(evil-mode 1) ;以上的是设置启动emacs载入evil
 
 
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "M-x") 'smex)
 
 
 ;;git-emacs
;;(add-to-list 'load-path "~/git-emacs")
;;(require 'git-emacs)
 
