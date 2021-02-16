;;; init.el --- Emacs initialization file
;;; Commentary:

;; Some commentary

;;; Code:


;; Straight bootstrap code
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))


;; Push the mouse out of the way when the cursor approaches.
(if window-system
    (progn
      (autoload 'avoid "avoid" "Avoid mouse and cursor being near each other")
      (eval-after-load 'avoid (mouse-avoidance-mode 'jump))))

;; "I never use set-fill-column and I hate hitting it by accident." - gwern
(global-set-key "\C-x\ f" 'helm-find-files)

;; Create keybinds for scrolling screen independently of cursor.
(global-set-key (kbd "C-;") '(lambda () (interactive) (scroll-up-line 3)))
(global-set-key (kbd "C-'") '(lambda () (interactive) (scroll-down-line 3)))

;; Set frame title to file being edited
(setq frame-title-format "%f")

;; Answer y or n instead of yes or no at minibar prompts.
(defalias 'yes-or-no-p 'y-or-n-p)

(defun push-mark-no-activate ()
  "This function pushes `point' to `mark-ring' and does not activate the region.
Equivalent to \\[set-mark-command] when
\\[transient-mark-mode] is disabled"
  (interactive)
  (push-mark (point) t nil)
  (message "Pushed mark to ring"))

(global-set-key (kbd "C-`") 'push-mark-no-activate)


(defun jump-to-mark ()
  "Jumps to the local mark, respecting the `mark-ring' order.
This is the same as using \\[set-mark-command] with the
prefix argument."
  (interactive)
  (set-mark-command 1))
(global-set-key (kbd "M-`") 'jump-to-mark)


(defun exchange-point-and-mark-no-activate ()
  "Identical to \\[exchange-point-and-mark] but will not activate the region."
  (interactive)
  (exchange-point-and-mark)
  (deactivate-mark nil))
(define-key global-map [remap exchange-point-and-mark] 'exchange-point-and-mark-no-activate)


;; use-package
;; (eval-when-compile (require 'use-package))
(straight-use-package 'use-package)

(require 'package)
(add-to-list 'package-archives
	     '(("gnu" . "http://elpa.gnu.org/packages/")
	       ("melpa-stable" . "http://stable.melpa.org/packages/")
	       ("melpa" . "http://melpa.org/packages/")))

;; Use Google style formatting for Java/C/C++
(add-to-list 'load-path "~/.emacs.d/google-c-style/")
(require 'google-c-style)
(autoload 'google-set-c-style "google-c-style")
(autoload 'google-make-newline-indent "google-c-style")
(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook 'google-make-newline-indent)

(setq straight-use-package-by-default t)

(use-package org)
(use-package org-pomodoro)
(use-package org-roam)
(use-package org-journal)
(use-package exec-path-from-shell)
(when (daemonp)
  (exec-path-from-shell-initialize))

;; Enable auto-org-mode
(define-key global-map "\C-c\ l" 'org-store-link)
(define-key global-map "\C-c\ a" 'org-agenda)
(define-key global-map "\C-c\ C-a" 'org-capture)
(setq org-log-done t)

;; Haskell mode
(use-package haskell-mode)
;; Haskell keybindings
(eval-after-load 'haskell-mode
  '(progn
     (define-key haskell-mode-map (kbd "C-c C-l") 'haskell-process-load-or-reload)
     (define-key haskell-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
     (define-key haskell-mode-map (kbd "C-c C-n C-t") 'haskell-process-do-type)
     (define-key haskell-mode-map (kbd "C-c C-n C-i") 'haskell-process-do-info)
     (define-key haskell-mode-map (kbd "C-c C-n C-c") 'haskell-process-cabal-build)
     (define-key haskell-mode-map (kbd "C-c C-n c") 'haskell-process-cabal)
     (define-key haskell-mode-map (kbd "C-c C-o") 'haskell-compile)))
(eval-after-load 'haskell-cabal
  '(progn
     (define-key haskell-cabal-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
     (define-key haskell-cabal-mode-map (kbd "C-c C-k") 'haskell-interactive-mode-clear)
     (define-key haskell-cabal-mode-map (kbd "C-c C-c") 'haskell-process-cabal-build)
     (define-key haskell-cabal-mode-map (kbd "C-c c") 'haskell-process-cabal)
     (define-key haskell-cabal-mode-map (kbd "C-c C-o") 'haskell-compile)))

;; Enable hashtags
(let ((my-cabal-path (expand-file-name "~/.cabal/bin")))
  (setenv "PATH" (concat my-cabal-path path-separator (getenv "PATH")))
  (add-to-list 'exec-path my-cabal-path))

;; Helm
;; (add-to-list 'load-path "/usr/share/emacs/site-lisp/helm")
(straight-use-package 'helm)
(straight-use-package 'helm-system-packages)
(use-package helm
  :bind (("M-x" . helm-M-x)
	 ("C-x C-f" . helm-find-files)
	 ("C-x b" . helm-mini)
	 ("C-x C-b" . helm-mini))
  :config (helm-mode t))

;; Moe-theme
(use-package moe-theme)

;; company mode
(use-package company)

;; PDF Tools
(use-package pdf-tools
  :config
  (pdf-tools-install))

;; ebib
(use-package ebib)

;; ledger mode
(use-package ledger-mode)

;; crux
(use-package crux)

;; helm-org
(use-package helm-org)
(use-package org-ql)


;; eglot
(use-package project)
(load-library "project")
(use-package eglot)

;; hledger-mode
(use-package hledger-mode)

;; magit
(use-package magit)

;; flycheck
(use-package flycheck)

;; auctex
(use-package tex-mode
  :defer t
  :requires (auctex)
  :config
  (setq TeX-auto-save t))
(straight-use-package 'auctex)

;; sage-shell-mode for Sage Math
(use-package sage-shell-mode)

;; Run SageMath by M-x run-sage instead of M-x sage-shell:run-sage
(sage-shell:define-alias)

;; Turn on eldoc-mode in Sage terminal and in Sage source files
(add-hook 'sage-shell-mode-hook #'eldoc-mode)
(add-hook 'sage-shell:sage-mode-hook #'eldoc-mode)

;; Mu4e
(use-package mu)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-auto-save t)
 '(TeX-command-BibTeX "Biber")
 '(TeX-engine 'luatex)
 '(TeX-parse-self t)
 '(TeX-view-program-selection
   '(((output-dvi has-no-display-manager)
      "dvi2tty")
     ((output-dvi style-pstricks)
      "dvips and gv")
     (output-dvi "xdvi")
     (output-pdf "PDF Tools")
     (output-html "xdg-open")))
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(auth-source-save-behavior nil)
 '(blink-cursor-mode nil)
 '(column-number-mode t)
 '(completion-styles '(flex partial-completion emacs22))
 '(current-language-environment "UTF-8")
 '(custom-enabled-themes '(moe-dark-custom))
 '(custom-safe-themes
   '("e8e66a2e4e8e84e5164c926e4034717be60d7eb681fcad4f6c3b2b24573324d8" default))
 '(custom-unlispify-menu-entries nil)
 '(custom-unlispify-tag-names nil)
 '(electric-pair-mode t)
 '(emacs-lisp-mode-hook '(eldoc-mode))
 '(fill-column 80)
 '(flycheck-emacs-lisp-load-path 'inherit)
 '(font-lock-global-modes '(not speedbar-mode))
 '(frame-background-mode nil)
 '(global-subword-mode t)
 '(haskell-mode-hook '(flyspell-prog-mode interactive-haskell-mode))
 '(haskell-process-auto-import-loaded-modules t)
 '(haskell-process-log t)
 '(haskell-process-suggest-remove-import-lines t)
 '(haskell-process-type 'cabal-repl)
 '(haskell-stylish-on-save t)
 '(haskell-tags-on-save t)
 '(helm-autoresize-mode t)
 '(helm-completion-style 'emacs)
 '(helm-ff-keep-cached-candidates 'nil)
 '(helm-mode t)
 '(helm-move-to-line-cycle-in-source nil)
 '(helm-split-window-inside-p t)
 '(hippie-expand-try-functions-list
   '(helm-dabbrev try-expand-all-abbrevs try-expand-list try-complete-file-name try-complete-file-name-partially try-expand-dabbrev-all-buffers try-expand-dabbrev-from-kill try-expand-line try-complete-lisp-symbol-partially try-complete-lisp-symbol))
 '(hscroll-step 1)
 '(image-animate-loop t)
 '(image-converter 'ffmpeg)
 '(image-use-external-converter t)
 '(inhibit-startup-echo-area-message t)
 '(inhibit-startup-screen t)
 '(ispell-highlight-face 'flyspell-incorrect)
 '(org-agenda-files '("~/org/tasks.org"))
 '(org-pomodoro-long-break-length 10)
 '(overflow-newline-into-fringe nil)
 '(pdf-view-display-size 'fit-page)
 '(prog-mode-hook
   '(flyspell-prog-mode flymake-mode display-line-numbers-mode company-mode))
 '(reb-re-syntax 'string)
 '(scroll-bar-mode nil)
 '(search-default-mode t)
 '(sentence-end-double-space nil)
 '(straight-recipes-gnu-elpa-ignored-packages '(cl-generic cl-lib nadvice seq project))
 '(tab-always-indent 'complete)
 '(text-mode-hook '(turn-on-flyspell text-mode-hook-identify))
 '(tool-bar-mode nil)
 '(tool-bar-style 'text)
 '(tooltip-resize-echo-area t)
 '(visible-cursor nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(line-number ((t (:inherit (shadow default) :background "#4e4e4e" :foreground "#b2b2b2")))))

(provide 'init)

;;; init.el ends here
