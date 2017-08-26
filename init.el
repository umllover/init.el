
;; main entry

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)
(add-to-list 'load-path "~/.emacs.d/lisp/")

(defun open-my-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(require 'init-package)
(require 'init-common)
(require 'init-autocomplete)
(require 'init-langs)
(require 'init-keymap)
(require 'init-org)
;;(require 'file-search)

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
    (magit flycheck go-autocomplete go-mode graphviz-dot-mode ecb xcscope auto-complete evil evil-leader smooth-scrolling hungry-delete swiper counsel smartparens elpy web-mode js2-mode monokai-theme ace-link window-numbering))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
