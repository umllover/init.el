
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
	   ;; -- ecb
	   ecb
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
	   ;; -- git ---
	   magit
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
 
(provide 'init-package)
 
