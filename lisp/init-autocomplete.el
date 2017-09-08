
;; -- auto complete
(require 'auto-complete-config)
(global-auto-complete-mode t)
(ac-config-default)
(setq ac-use-menu-map t)
(define-key ac-menu-map "\C-n" 'ac-next)
(define-key ac-menu-map "\C-p" 'ac-previous)

;; -- yasnippet ---
(require 'yasnippet)
(yas-global-mode 1)


;; -- checker ---
(add-hook 'after-init-hook #'global-flycheck-mode)
(add-to-list 'display-buffer-alist
             `(,(rx bos "*Flycheck errors*" eos)
              (display-buffer-reuse-window
               display-buffer-in-side-window)
              (side            . bottom)
              (reusable-frames . visible)
              (window-height   . 0.2)))

;; -- hungry delete
(require 'hungry-delete)
(global-hungry-delete-mode)


;;自动插入匹配的括号
(setq skeleton-pair t)
(global-set-key (kbd "(") 'skeleton-pair-insert-maybe)    
(global-set-key (kbd "{") 'skeleton-pair-insert-maybe)    
(global-set-key (kbd "\'") 'skeleton-pair-insert-maybe)    
(global-set-key (kbd "\"") 'skeleton-pair-insert-maybe)    
(global-set-key (kbd "[") 'skeleton-pair-insert-maybe)    
(global-set-key (kbd "<") 'skeleton-pair-insert-maybe)    


;;自动插入匹配的括号
;;c/cpp  mode
(defun my-c-mode-auto-pair ()
  (interactive)
  (make-local-variable 'skeleton-pair-alist)
  (setq skeleton-pair-alist  '(
    (?{ \n > _ \n ?} >)))
  (setq skeleton-pair t)
  (local-set-key (kbd "(") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "[") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "\"") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "{") 'skeleton-pair-insert-maybe)   
  (backward-char))
(add-hook 'c-mode-hook 'my-c-mode-auto-pair)
(add-hook 'c++-mode-hook 'my-c-mode-auto-pair)


(provide 'init-autocomplete)
