;; 四分屏
(defun split-window-to-four()
  "split current frame to four"
  (interactive)
  (progn
    (split-window-horizontally)
    (set-window-buffer (next-window) (current-buffer))
    (split-window-vertically)
    (set-window-buffer (next-window) (current-buffer))
    (other-window 2)
    (split-window-vertically)
    (set-window-buffer (next-window) (current-buffer))
    (other-window -2)))

;; --- Leader Key ----
(require 'evil-leader)
(global-evil-leader-mode)
(evil-leader/set-leader "<SPC>")
 
(evil-leader/set-key
  ;; --- M-x ---
  "x"  'counsel-M-x
  "sh" 'shell
  "sc" 'shell-command
  ;; --- File ---
  "ff" 'find-file
  "fow" 'find-file-other-window
  "rf" 'recentf-open-files
  ;; --- dir ---
  "md" 'mkdir
  ;; ---Buffer----
  "sb" 'save-buffer
  "stb" 'switch-to-buffer
  "eb" 'eval-buffer
  "mwb" 'mark-whole-buffer
  "lb" 'list-buffers
  "lp" 'list-packages
  "rb" 'rename-buffer
  "ru" 'rename-uniquely
  "kb" 'kill-buffer
  "ssb" 'save-some-buffers

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
  "9"  'select-window-9
  "swr" 'split-window-right
  "swb" 'split-window-below
  "swf" 'split-window-to-four
  "dow" 'delete-other-windows
  "dw" 'delete-window
  "al" 'ace-link
  ;;--- kill emacs
  "ke" 'kill-emacs
  ;; -- jump
  "gl" 'goto-line
  ;; -- modes
  "am" 'artist-mode
  ;; -- find--
  "lml" 'list-matching-lines
  "rs" 'replace-string
  "qr" 'query-replace
  ;; -- auto complete--
  "ac" 'auto-complete-mode

  ;; -- code browser
  "ed" 'ecb-dired-directory-other-window
  "egr" 'ecb-grep-find-directory
  "gr" 'grep

  ;; -- go --
  "gd" 'godef-jump

  ;; python
  "egd" 'elpy-goto-definition

  ;; -- cpp ------
  "cfd" 'cscope-find-global-definition ;;搜索定义
  "cfs" 'cscope-find-this-symbol

  ;; --- eww -----
  "ew" 'eww
  "eu" 'eww-back-url

  ;; -- org
  "oi" 'org-insert-src-block

  ;; --- help ---
  "in" 'info
  "df" 'describe-function
  "dv" 'describe-variable
  )

 
(require 'evil)
(evil-mode 1) ;以上的是设置启动emacs载入evil
 
 
(global-set-key "\C-s" 'swiper)
(global-set-key "\C-i" 'semantic-ia-complete-symbol-menu)

;;(add-hook 'ecb-activate-hook 'recentf-open-files)
(add-hook 'ecb-activate-hook 'split-window-to-four)

(provide 'init-keymap)
