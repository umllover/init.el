
;; ----------Package Management
;; --- source ---------
(require 'package)
(add-to-list 'package-archives
	     '("gnu"   . "http://elpa.emacs-china.org/gnu/") t)
(add-to-list 'package-archives
	     '("melpa" . "http://elpa.emacs-china.org/melpa/") t)
 
(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))
 
;; Add Packages
(defvar my-packages
  '(   auto-complete
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
       magit) "Default packages")

(mapc #'(lambda (package)
	   (unless (package-installed-p package)
	     (package-install package)))
       my-packages)


;;
;;(setq package-selected-packages my/packages)
;; 
;;(defun my/packages-installed-p ()
;;    (loop for pkg in my/packages
;;      when (not (package-installed-p pkg)) do (return nil)
;;      finally (return t)))
;; 
;;(unless (my/packages-installed-p)
;;    (message "%s" "Refreshing package database...")
;;    (package-refresh-contents)
;;    (dolist (pkg my/packages)
;;      (when (not (package-installed-p pkg))
;;    (package-install pkg))))
 
(provide 'init-package)
 
