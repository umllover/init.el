
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

;; 在org 中使用 auto
(setq ac-modes
        (append ac-modes '(org-mode objc-mode jde-mode sql-mode
                                    change-log-mode text-mode
                                    makefile-gmake-mode makefile-bsdmake-mo
                                    autoconf-mode makefile-automake-mode)))



(provide 'init-org)
