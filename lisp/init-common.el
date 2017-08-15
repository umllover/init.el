
;; ------ Common Set -----
(global-hl-line-mode 1)
(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(window-divider-mode -1)
(window-numbering-mode 1)

;; ------font ------
(set-fontset-font (frame-parameter nil 'font)
		  'han '("宋体"."unicode-bmp"))
;; -- 编码 --
(setq default-buffer-file-coding-system 'utf-8)  
(prefer-coding-system 'utf-8)  


;; ----ecb -----
(require 'ecb) ;;加载ecb
;;;; 自动启动ecb，并且不显示每日提示
(setq ecb-auto-activate t
      ecb-tip-of-the-day nil)

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
 
 
;; dired
(setq dired-recursive-deletes 'always)
(setq dired-recursive-copies 'always)
(put 'dired-find-alternate-file 'disabled nil)
(with-eval-after-load 'dired
    (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file))
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

;; theme
(load-theme 'monokai 1)

(provide 'init-common)
