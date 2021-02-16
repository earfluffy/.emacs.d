(require 'package)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(auth-source-save-behavior nil)
 '(blink-cursor-mode nil)
 '(column-number-mode t)
 '(custom-enabled-themes '(moe-dark-custom))
 '(custom-safe-themes
   '("e8e66a2e4e8e84e5164c926e4034717be60d7eb681fcad4f6c3b2b24573324d8" "ae65ccecdcc9eb29ec29172e1bfb6cadbe68108e1c0334f3ae52414097c501d2" "7675ffd2f5cb01a7aab53bcdd702fa019b56c764900f2eea0f74ccfc8e854386" "c9ddf33b383e74dac7690255dd2c3dfa1961a8e8a1d20e401c6572febef61045" "a19265ef7ecc16ac4579abb1635fd4e3e1185dcacbc01b7a43cf7ad107c27ced" "a09242d736bedcf7778d4c5e04017f0609ca8d6345b1a46023350842ba7276ae" "d8e2beb2edf021b0fa648d98ac5dcddbf81bb389507d10563fab341fb88f6175" "8dbd6aa1896c70d53d7ac938515d05e816d3d03e510905ed3f8292fe52710d89" "9ad62b66f939b7a8c588c2cb7b580a71fafc091c9e184a28d525de64671fe232" "b9cbfb43711effa2e0a7fbc99d5e7522d8d8c1c151a3194a4b176ec17c9a8215" "b9a06c75084a7744b8a38cb48bc987de10d68f0317697ccbd894b2d0aca06d2b" "eb05414d9757c99758b41a4add2523dcf8d01503835ad98393d689dd8df310b8" "ffa9fef1aa2df06b30f35bee05809d30806d34a63f0fad725abe1ddeef20889f" "ee9ff4f8dbf32f4fcee8d0495e5358caf6c9ec749e09b9fd0933be5cc5dd0a38" "36ca8f60565af20ef4f30783aa16a26d96c02df7b4e54e9900a5138fb33808da" "f3cb5e4d416faa014619923c717777afdf71a0541ac602b81328d798546e7af6" default))
 '(custom-unlispify-menu-entries nil)
 '(custom-unlispify-tag-names nil)
 '(electric-pair-mode t)
 '(emacs-lisp-mode-hook '(eldoc-mode))
 '(flycheck-emacs-lisp-load-path 'inherit)
 '(font-lock-global-modes '(not speedbar-mode))
 '(frame-background-mode nil)
 '(global-smart-tab-mode t)
 '(global-subword-mode t)
 '(haskell-mode-hook '(flyspell-prog-mode interactive-haskell-mode))
 '(haskell-process-auto-import-loaded-modules t)
 '(haskell-process-log t)
 '(haskell-process-suggest-remove-import-lines t)
 '(haskell-process-type 'cabal-repl)
 '(haskell-stylish-on-save t)
 '(haskell-tags-on-save t)
 '(helm-completion-style 'helm)
 '(helm-mode t)
 '(hippie-expand-try-functions-list
   '(helm-dabbrev try-expand-all-abbrevs try-expand-list try-complete-file-name try-complete-file-name-partially try-expand-dabbrev-all-buffers try-expand-dabbrev-from-kill try-expand-line try-complete-lisp-symbol-partially try-complete-lisp-symbol))
 '(hscroll-step 1)
 '(inhibit-startup-echo-area-message t)
 '(inhibit-startup-screen t)
 '(ispell-highlight-face 'flyspell-incorrect)
 '(org-agenda-files '("~/org/tasks.org"))
 '(overflow-newline-into-fringe nil)
 '(package-archives
   '(("gnu" . "http://elpa.gnu.org/packages/")
     ("melpa-stable" . "http://stable.melpa.org/packages/")
     ("melpa" . "http://melpa.org/packages/")))
 '(package-selected-packages
   '(crux helm-org eglot markdown-mode magit ledger-mode flycheck haskell-mode hledger-mode moe-theme pdf-tools smart-tab use-package auctex))
 '(pdf-view-display-size 'fit-page)
 '(prog-mode-hook
   '(flyspell-prog-mode flymake-mode display-line-numbers-mode))
 '(reb-re-syntax 'string)
 '(scroll-bar-mode nil)
 '(search-default-mode t)
 '(smart-tab-using-hippie-expand t)
 '(tab-always-indent 'complete)
 '(text-mode-hook '(turn-on-flyspell text-mode-hook-identify))
 '(tool-bar-mode nil)
 '(tool-bar-style 'text)
 '(tooltip-resize-echo-area t)
 '(visible-cursor nil)
 '(winner-mode t))
(when (< emacs-major-version 27)
  (package-initialize))

;; use-package
(eval-when-compile (require 'use-package))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(line-number ((t (:inherit (shadow default) :background "#4e4e4e" :foreground "#b2b2b2")))))

;; Set frame title to file being edited
(setq frame-title-format "%f")

;; Answer y or n instead of yes or no at minibar prompts.
(defalias 'yes-or-no-p 'y-or-n-p)

;; Use Google style formatting for Java/C/C++
(add-to-list 'load-path "~/.emacs.d/google-c-style/")
(require 'google-c-style)
(autoload 'google-set-c-style "google-c-style")
(autoload 'google-make-newline-indent "google-c-style")
(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook 'google-make-newline-indent)

;; Enable auto-org-mode
(require 'org)
(define-key global-map "\C-c\ l" 'org-store-link)
(define-key global-map "\C-c\ a" 'org-agenda)
(define-key global-map "\C-c\ C-a" 'org-capture)
(setq org-log-done t)


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

;; Enable hasktags
(let ((my-cabal-path (expand-file-name "~/.cabal/bin")))
  (setenv "PATH" (concat my-cabal-path path-separator (getenv "PATH")))
  (add-to-list 'exec-path my-cabal-path))

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

;; Helm
(add-to-list 'load-path "/usr/share/emacs/site-lisp/helm")
(use-package helm-config
  :bind (("M-x" . helm-M-x)
	 ("C-x C-f" . helm-find-files)
	 ("C-x b" . helm-mini)))

;; Smart tab
(use-package smart-tab)

;; Moe-theme
(use-package moe-theme)

;; PDF Tools
(use-package pdf-tools
  :config
  (pdf-tools-install))

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
