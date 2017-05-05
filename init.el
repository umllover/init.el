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
           ;;company
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
 
;;(global-company-mode 1)
;;(add-hook 'after-init-hook 'global-company-mode)
;;(setq company-dabbrev-downcase nil)
 
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
  ;; ---Scroll ---
  "p" 'scroll-down
  "n" 'scroll-up
  ;; ---Window ---
  "1"  'select-window-1
  "2"  'select-window-2
  "3"  'select-window-3
  "4"  'select-window-4
  "swr" 'split-window-right
  "swb" 'split-window-below
  "dow" 'delete-other-windows
  "dw" 'delete-window
  "al" 'ace-link
   ;; --- EWW
  "eww" 'eww
  "ewb" 'eww-back-url
  "elb" 'eww-list-bookmarks
  "eab" 'eww-add-bookmark
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

  )
 
 
(require 'evil)
(evil-mode 1) ;���ϵ�����������emacs����evil
 
 
(global-set-key "\C-s" 'swiper)
 
(load-theme 'monokai 1)
 
 
(global-set-key (kbd "M-x") 'smex)
 
 
 ;;git-emacs
(add-to-list 'load-path "./git-emacs/")
(require 'git-emacs)
 
;; ------ Common Set -----
(global-hl-line-mode 1)
(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(window-divider-mode -1)
;;(setq inhibit-splash-screen t)
;;(setq-default cursor-type 'bar)

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
