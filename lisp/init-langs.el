
;; -- go lang --
(add-to-list 'load-path "~/.emacs.d/go-mode")
(require 'go-mode)
(require 'go-autocomplete)


;; -- webmode
(elpy-enable)
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

;; -- c/cpp --
(require 'xcscope)
(add-hook 'c-mode-common-hook '(lambda() (require 'xcscope)))
(require 'cedet) ;;加载cedet
(require 'semantic)

(defun my-c-mode-set ()
  (c-set-style "k&r")
  (hs-minor-mode t)
;;在状态条上显示当前光标在哪个函数体内部
  (which-function-mode)
;; 设置C/C++语言缩进字符数
  (setq c-basic-offset 4))

(add-hook 'c-mode-hook 'my-c-mode-set)
(add-hook 'c++-mode-hook 'my-c-mode-set)


(provide 'init-langs)
