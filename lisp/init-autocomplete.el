
;; -- checker ---
(add-hook 'after-init-hook #'global-flycheck-mode)
(add-to-list 'display-buffer-alist
             `(,(rx bos "*Flycheck errors*" eos)
              (display-buffer-reuse-window
               display-buffer-in-side-window)
              (side            . bottom)
              (reusable-frames . visible)
              (window-height   . 0.2)))


;; -- auto complete mode
(global-auto-complete-mode t)
;; -- auto complete
(ac-config-default)
(setq ac-use-menu-map t)
(define-key ac-menu-map "\C-n" 'ac-next)
(define-key ac-menu-map "\C-p" 'ac-previous)


;; -- hungry delete
(require 'hungry-delete)
(global-hungry-delete-mode)

(provide 'init-autocomplete)
