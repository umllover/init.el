;; ----------Package Management
 
;; --- source ---------
 (when (>= emacs-major-version 24)
     (require 'package)
     (package-initialize)
     (setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
              ("melpa" . "http://elpa.emacs-china.org/melpa/"))))
 
;; cl - Common Lisp Extension
(require 'cl);; loop Ϊcommon lisp ����չ
 
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

;; -- ���� --
(setq default-buffer-file-coding-system 'utf-8)  
(prefer-coding-system 'utf-8)  

;; -- c/c++
;;(require 'xcscope)
;;(add-hook 'c-mode-common-hook '(lambda() (require 'xcscope)))

(require 'xcscope) ;;����xcscope
(require 'cedet) ;;����cedet
(require 'ecb) ;;����ecb
;;(global-set-key [C-.] 'cscope-find-global-definition) ;;��������
;;;;(global-set-key [C-,] 'cscope-pop-mark) ;; ����ת��
;;;;(enable-visual-studio-bookmarks) ;; ����VS��ǩ�ӳ���
;;;;(setq semanticdb-project-roots (list "d:/work")) ;; ����cemanticdb��ɨ���Ŀ¼
(add-hook 'c-mode-common-hook ( lambda() ( c-set-style "k&r" ) ) ) ;;����C����Ĭ�ϸ�ʽ
(add-hook 'c++-mode-common-hook ( lambda() ( c-set-style "k&r" ) ) ) ;;����C++����Ĭ�ϸ�ʽ 


;; -- go lang --
(require 'go-mode)
(require 'go-autocomplete)
(require 'auto-complete-config)
(ac-config-default)

(add-to-list 'load-path "~/.emacs.d/go-mode")
;;(require 'go-flymake)
;;(require 'go-mode-autoloads)
;;(require 'go-mode-pkg)


;; --- Leader Key ----
(require 'evil-leader)
(global-evil-leader-mode)
(evil-leader/set-leader "<SPC>")
 
(evil-leader/set-key
  ;; --- M-x ---
  "x"  'counsel-M-x
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
  "swr" 'split-window-right
  "swb" 'split-window-below
  "dow" 'delete-other-windows
  "dw" 'delete-window
  "al" 'ace-link
  ;;--- kill emacs
  "ke" 'kill-emacs
  ;; -- jump
  "gl" 'goto-line
  ;; --- shell
  "sh" 'shell
  "sc" 'shell-command
  ;; -- modes
  "am" 'artist-mode
  ;; -- find--
  "lml" 'list-matching-lines
  "rs" 'replace-string
  "qr" 'query-replace
  ;; -- auto complete--
  "ac" 'auto-complete-mode

  ;; -- code browser
  "ea" 'ecb-activate ;;����F12��Ϊ����ecb
  "ed" 'ecb-deactivate ;;����Ctrl+F12Ϊֹͣecb
  "gr" 'grep

  ;; -- go --
  "ga" 'go-goto-arguments
  "gd" 'go-goto-docstring
  "gf" 'go-goto-function
  "gn" 'go-goto-function-name
  "gv" 'go-goto-return-values
  "gm" 'go-goto-method-receiver
  "gofmt" 'gofmt
  )

 


(require 'evil)
(evil-mode 1) ;���ϵ�����������emacs����evil
 
 
(global-set-key "\C-s" 'swiper)
 
(load-theme 'monokai 1)
 
 
(global-set-key (kbd "M-x") 'smex)
 
 
 ;;git-emacs
;;(add-to-list 'load-path "./git-emacs/")
;;(require 'git-emacs)
 
;; ------ Common Set -----
(global-hl-line-mode 1)
(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(window-divider-mode -1)

;; ------font ------
;(set-default-font "DejaVu Sans Mono 11")
(set-fontset-font (frame-parameter nil 'font)
		  'han '("����"."unicode-bmp"))
;;(setq inhibit-splash-screen t)
;;(setq-default cursor-type 'bar)


;;�Զ�����ƥ�������
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
(add-hook 'go-mode-hook 'my-c-mode-auto-pair)


(defun my-c-mode-set ()
  (c-set-style "k&r")
  (hs-minor-mode t)
;;��״̬������ʾ��ǰ������ĸ��������ڲ�
  (which-function-mode)
;; ����C/C++���������ַ���
  (setq c-basic-offset 4))

(add-hook 'c-mode-hook 'my-c-mode-set)
(add-hook 'c++-mode-hook 'my-c-mode-set)



(setq  initial-frame-alist (quote ((fullscreen . maximized))))
;; �ر�������������
(setq inhibit-splash-screen 1)
;;(global-hl-line-mode t)
(setq make-backup-files nil)
(global-linum-mode 1)
 
;; recent open files
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-item 10)
 
(delete-selection-mode 1)
 
;;����Ĵ�������� Emacs �Զ������ⲿ�޸Ĺ����ļ���
(global-auto-revert-mode 1)
 
;;ʹ������Ĵ�����Թر��Լ������ı����ļ���֮ǰ�����Ѿ��رչ��� Emacs �Զ������� �����ļ��ˣ������ǹر��Զ������ļ�����
(setq auto-save-default nil)
 
 
;; ----------- Dired Mode -----------------
;;+ ����Ŀ¼
;;g ˢ��Ŀ¼
;;C ����
;;D ɾ��
;;R ������
;;d ���ɾ��
;;u ȡ�����
;;x ִ�����еı��
;;�����м�������Ż��ĵط�����һ��ɾ��Ŀ¼��ʱ�� Emacs ��ѯ���Ƿ�ݹ�ɾ���򿽱��� ��Ҳ��Щ�鷳���ǿ�������������ý����趨ΪĬ�ϵݹ�ɾ��Ŀ¼�����ڰ�ȫԭ��Ŀ��ǣ� Ҳ������Ҫ���ִ���Ϊ���������е���������ذ������ã���
 
(setq dired-recursive-deletes 'always)
(setq dired-recursive-copies 'always)
 
;;�ڶ��ǣ�ÿһ�������һ���س�����һ���µ�Ŀ¼���ǣ�һ���µĻ������ͻᱻ��������ʹ �����ǵĻ������б��г����˴���û��ʵ������ļ�¼�����ǿ���ʹ������Ĵ��룬�� Emacs ����Ψһ��һ����������Ϊ Dired Mode ��ʾר�û�������
 
(put 'dired-find-alternate-file 'disabled nil)
 
;; �������� Dired Mode
;; (require 'dired)
;; (defined-key dired-mode-map (kbd "RET") 'dired-find-alternate-file)
 
;; �ӳټ���
(with-eval-after-load 'dired
    (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file))
 
;;���� dired-x ������ÿһ�ν��� Dired ģʽʱ��ʹ���µĿ�ݼ� C-x C-j �Ϳ��Խ� �뵱ǰ�ļ��е����ڵ�·����
(require 'dired-x)
 
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
;; --Ԥ��
(add-hook 'org-babel-after-execute-hook 'bh/display-inline-images 'append)
; Make babel results blocks lowercase
(setq org-babel-results-keyword "results")
(defun bh/display-inline-images ()
  (condition-case nil
      (org-display-inline-images)
    (error nil)))
 
;;Ҫ���﷨����������еĴ���,���Խ��������ŵ� .emacs ��ʼ���ļ���:
(setq org-confirm-babel-evaluate nil
      org-src-fontify-natively t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ecb-options-version "2.50")
 '(ecb-source-path (quote (("f:" "f:") ("e:" "e:"))))
 '(package-selected-packages
   (quote
    (flycheck go-autocomplete go-mode graphviz-dot-mode ecb xcscope auto-complete evil evil-leader smooth-scrolling hungry-delete swiper counsel smartparens elpy web-mode js2-mode monokai-theme ace-link window-numbering))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

