
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

;;(defun org-babel-execute:plantuml (body params)
;;  "Execute a block of plantuml code with org-babel.
;;This function is called by `org-babel-execute-src-block'."
;;  (let* ((result-params (split-string (or (cdr (assoc :results params)) "")))
;;     (out-file (or (cdr (assoc :file params))
;;               (error "PlantUML requires a \":file\" header argument")))
;;     (cmdline (cdr (assoc :cmdline params)))
;;     (in-file (org-babel-temp-file "plantuml-"))
;;     (java (or (cdr (assoc :java params)) ""))
;;     (cmd (if (string= "" org-plantuml-jar-path)
;;          (error "`org-plantuml-jar-path' is not set")
;;        (concat "java " java " -jar "
;;            (shell-quote-argument
;;             (expand-file-name org-plantuml-jar-path))
;;            (if (string= (file-name-extension out-file) "svg")
;;                " -tsvg" "")
;;            (if (string= (file-name-extension out-file) "eps")
;;                " -teps" "")
;;            " -p " cmdline " < "
;;            (org-babel-process-file-name in-file)
;;            " > "
;;            (org-babel-process-file-name out-file)))))
;;    (unless (file-exists-p org-plantuml-jar-path)
;;      (error "Could not find plantuml.jar at %s" org-plantuml-jar-path))
;;    (with-temp-file in-file (insert (concat "@startuml\n" body "\n@enduml")))
;;    (message "%s" cmd) (org-babel-eval cmd "")
;;    nil))
;;  中文支持：cmdline -charset UTF-8

 
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
