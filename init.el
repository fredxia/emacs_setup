;;
;; Must clone this repo into ~/gnu/src/emacs_setup
;;
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'epa-file)
(epa-file-enable)
(setq epa-file-select-keys nil)
(setq epa-pinentry-mode 'loopback)
(setq epa-file-cache-passphrase-for-symmetric-encryption t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-cursor-mode nil)
 '(column-number-mode t)
 '(epq-gpg-program "/usr/bin/gpg2")
 '(frame-background-mode 'dark)
 '(fringe-mode 0 nil (fringe))
 '(grep-files-aliases
   '(("el" . "*.el")
     ("ch" . "*.[ch] *.cpp\12*.hxx *.cxx *.hpp")
     ("t" . "*.tac *.tin *.py *.[ch] *.cpp *.hxx *.cxx\12*.hpp")))
 '(indent-tabs-mode nil)
 '(lsp-enable-file-watchers nil)
 '(lsp-ui-imenu-buffer-position 'left)
 '(lsp-ui-peek-enable nil)
 '(menu-bar-mode nil)
 '(org-ascii-global-margin 4)
 '(org-ascii-inner-margin 4)
 '(org-ascii-text-width 88)
 '(org-display-custom-times t)
 '(org-html-postamble-format
   '(("en" "<br><hr><p class=\"author\">%a, updated on %C</p><br>")))
 '(org-html-preamble-format
   '(("en" "<p class=\"author\">%a, updated on %C</p><hr><br>")))
 '(org-time-stamp-custom-formats '("<%m/%d %a>" . "<%m/%d %a %H:%M>"))
 '(package-selected-packages
   '(xcscope json-mode bazel helm-xref dockerfile-mode docker org magit-diff-flycheck compat lsp-ivy lsp-pyright lsp-ui flycheck-rust company lsp-mode rust-auto-use go-mode magit gopls protobuf-mode yaml-mode yaml toml-mode rust-mode))
 '(tool-bar-mode nil)
 '(visible-bell t)
 '(yaml-indent-offset 2))

(add-to-list 'load-path "/usr/share/emacs/site-lisp")
(add-to-list 'load-path "~/gnu/src/emacs_setup/")
(add-to-list 'load-path "~/gnu/src/org-mode/lisp")
(load "~/~/gnu/src/emacs_setup/rust-init.el")
;(load "~/~/gnu/src/emacs_setup/go-init.el")
(load "~/~/gnu/src/emacs_setup/py-init.el")
;(load "~/~/gnu/src/emacs_setup/clang-init.el")
(load "~/~/gnu/src/emacs_setup/idutils.el")

;; This is for eglot LSP setup
(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               `(c++-mode . ("/usr/bin/clangd-16" "--compile-commands-dir=/home/fred.xia/ota"))))

(autoload 'gid "idutils")

(autoload 'go-mode "go-mode" nil t)
(autoload 'rust-mode "rust-mode" nil t)
(autoload 'json-mode "json-mode" nil t)
(autoload 'bazel-mode "bazel-mode" nil t)

(add-to-list 'auto-mode-alist '("\\.go\\'" . go-mode))
(add-hook 'go-mode-hook
          (lambda ()
            (add-hook 'before-save-hook 'gofmt-before-save)
            (setq tab-width 2)
            (setq indent-tabs-mode nil)))

;(setq gofmt-command "goimports")
;(add-hook 'before-save-hook 'gofmt-before-save)

(setq indent-tabs-mode nil)

(add-hook 'write-file-hooks 'delete-trailing-whitespace)

(global-visual-line-mode t)

;;; Mode suffix mapping ;;;
(setq auto-mode-alist '(("\\.py$"   . python-mode)
                        ("\\.hpp$"  . c++-mode)
                        ("\\.cpp$"  . c++-mode)
                        ("\\.h$"    . c++-mode)
			("\\.hxx$"  . c++-mode)
                        ("\\.c$"    . c++-mode)
                        ("\\.cc$"   . c++-mode)
			("\\.cxx$"  . c++-mode)
                        ("\\.pl$"   . perl-mode)
                        ("\\.pm$"   . perl-mode)
                        ("\\.cpt$"  . org-mode)
                        ("\\.org$"  . org-mode)
                        ("\\.go$"   . go-mode)
                        ("\\.rs$"   . rustic-mode)
                        ("\\.toml$" . toml-mode)
                        ("\\.yaml$" . yaml-mode)
                        ("\\.yml$"  . yaml-mode)
                        ("\\.proto$" . protobuf-mode)
                        ("\\.el$" . emacs-lisp-mode)
                        ("\\.md$" . markdown-mode)
                        ("BUILD" . bazel-module-mode)
                        ))

(setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84 88))
(setq backup-inhibited t)
;;; Don't do tab-indent ;;;
(setq-default indent-tabs-mode nil)

;;; Display columns ;;;
(setq-default column-number-mode t)

(blink-cursor-mode nil)
(global-set-key "\M-i" 'tab-to-tab-stop)
(global-set-key "\C-q" 'dabbrev-expand)
(global-set-key "\r"   'newline-and-indent)
(global-set-key "\M-g" 'goto-line)
(global-set-key "\M-1" 'replace-string)
(global-set-key "\M-2" 'query-replace-string)
(global-set-key "\M-3" 'replace-regexp)
(global-set-key "\M-4" 'query-replace-regexp)
(global-set-key "\C-cc"	'calendar)
(global-set-key "\C-c\C-g" 'indent-region)
(global-set-key "\C-c\C-h" 'highlight-changes-mode)
(global-set-key "\M-w" 'copy-region-as-kill)
(global-set-key "\C-x\C-l" 'buffer-menu)

(defun org-mode-func()
  (setq org-log-done t)
  (define-key global-map "\C-cl" 'org-store-link)
  (define-key global-map "\C-ca" 'org-agenda)
  (define-key global-map "\C-cd" 'org-move-subtree-down)
  (define-key global-map "\C-cu" 'org-move-subtree-up)
  (define-key global-map "\C-cv" 'org-archive-subtree)
  (setq org-todo-keywords
    '((type "TODO" "LONG" "DONE")))
  )
(add-hook 'org-mode-hook 'org-mode-func)

(defun py-hook()
  (setq py-indent-offset 4)
  (setq python-indent 4)
  (setq python-continuation-offset 4)
  )

(add-hook 'python-mode-hook 'py-hook)

(defun yaml-hook()
  (setq yaml-indent-offset 4))
(add-hook 'yaml-mode-hook 'yaml-hook)

(make-face-bold 'mode-line)
(make-face-bold 'mode-line-buffer-id)

;; your coding style
(c-add-style "mycodingstyle"
             '((c-basic-offset . 4)
               (c-comment-only-line-offset . 0)
               (c-hanging-braces-alist . ((substatement-open before after)))
               (c-offsets-alist . ((topmost-intro        . 0)
                                   (topmost-intro-cont   . 0)
                                   (substatement         . 4)
                                   (substatement-open    . 0)
                                   (statement-case-open  . 4)
                                   (statement-cont       . 4)
                                   (access-label         . -4)
                                   (inclass              . 4)
                                   (inline-open          . 4)
                                   (innamespace          . 0)
                                   ))))

(defun cc-hook()
  (c-set-style "mycodingstyle")
  ;  (setq c-basic-offset 8)
  (setq c-indent-offset 2)
  (c-set-offset 'innamespace 0)
  (setq indent-tabs-mode nil)
  (setq c-tab-always-indent nil)
  (setq c-append-paragraph-start 0)
  ; (setq show-trailing-whitespace t)
  )

(add-hook 'c++-mode-hook 'cc-hook)
(add-hook 'c-mode-hook 'cc-hook)

;; Company mode
;(setq company-idle-delay 0)
;(setq company-minimum-prefix-length 1)

;;; Set up ediff ;;;
(setq ediff-split-window-function 'split-window-vertically)
(defun my-ediff-hook ()
  (setq ediff-split-window-function 'split-window-vertically)
  (setq truncate-partial-width-windows nil))
(add-hook 'ediff-mode-hook 'my-ediff-hook)


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "unspecified-bg" :foreground "color-230" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 1 :width normal :foundry "default" :family "default"))))
 '(bold ((t (:foreground "color-208" :weight normal))))
 '(button ((t (:foreground "color-202"))))
 '(custom-comment ((((type tty)) (:background "grey30" :foreground "pale green"))))
 '(diff-header ((t (:extend t :background "color-58"))))
 '(ediff-current-diff-A ((((class color) (min-colors 16)) (:background "color-26" :foreground "pale green"))))
 '(ediff-current-diff-Ancestor ((((class color) (min-colors 16)) (:background "skyblue4" :foreground "white"))))
 '(ediff-current-diff-B ((t (:extend t :background "color-22" :foreground "color-253"))))
 '(ediff-current-diff-C ((((class color) (min-colors 16)) (:background "grey50" :foreground "skyblue"))))
 '(ediff-even-diff-A ((((class color) (min-colors 16)) (:background "color-238" :foreground "color-220"))))
 '(ediff-even-diff-Ancestor ((((class color) (min-colors 16)) (:background "Grey30" :foreground "White"))))
 '(ediff-even-diff-B ((((class color) (min-colors 16)) (:background "Grey30" :foreground "color-202"))))
 '(ediff-even-diff-C ((((class color) (min-colors 16)) (:background "grey50" :foreground "skyblue"))))
 '(ediff-fine-diff-B ((t (:background "color-17"))))
 '(ediff-odd-diff-A ((((class color) (min-colors 16)) (:background "color-238" :foreground "color-81"))))
 '(ediff-odd-diff-B ((t (:background "color-20"))))
 '(ediff-odd-diff-C ((((class color) (min-colors 16)) (:background "Grey50" :foreground "White"))))
 '(font-lock-builtin-face ((((class color) (min-colors 88) (background dark)) (:foreground "color-187"))))
 '(font-lock-comment-face ((t (:foreground "color-214"))))
 '(font-lock-doc-face ((t (:foreground "color-214"))))
 '(font-lock-function-name-face ((t (:foreground "color-46" :weight normal))))
 '(font-lock-keyword-face ((t (:foreground "cyan"))))
 '(font-lock-preprocessor-face ((t (:foreground "color-204"))))
 '(font-lock-string-face ((t (:foreground "color-202"))))
 '(font-lock-type-face ((t (:foreground "color-173" :weight normal))))
 '(font-lock-variable-name-face ((t (:foreground "color-117"))))
 '(header-line ((t (:inherit mode-line :inverse-video nil :underline nil :weight normal))))
 '(highlight ((t (:underline "color-238"))))
 '(isearch ((((class color) (min-colors 88) (background dark)) (:background "gray60" :foreground "blue"))))
 '(italic ((t (:slant normal))))
 '(link ((t (:foreground "color-44" :underline "color-241"))))
 '(lsp-rust-analyzer-inlay-face ((t (:inherit font-lock-comment-face :foreground "color-68"))))
 '(markdown-header-face-1 ((t (:foreground "color-215" :weight bold :height 1.0))))
 '(markdown-header-face-2 ((t (:foreground "brightyellow" :height 1.0))))
 '(minibuffer-prompt ((t (:foreground "color-221"))))
 '(mode-line ((t (:background "color-23" :foreground "color-152" :box (:line-width -1 :style released-button) :weight normal))))
 '(mode-line-buffer-id ((t (:foreground "color-226" :weight normal))))
 '(mode-line-highlight ((((class color) (min-colors 88)) (:box (:line-width 2 :color "color-80" :style released-button)))))
 '(org-block ((t (:foreground "color-87"))))
 '(org-checkbox ((t (:foreground "brightred" :weight semi-bold))))
 '(org-code ((t (:foreground "color-160"))))
 '(org-date ((t (:foreground "color-108" :underline nil))))
 '(org-done ((t (:background "black" :foreground "brightred" :strike-through t :weight bold))))
 '(org-hide ((t (:foreground "black"))))
 '(org-level-1 ((t (:foreground "color-220" :weight normal))))
 '(org-level-2 ((t (:extend nil :foreground "LightSalmon" :weight normal :width normal))))
 '(org-level-3 ((t (:foreground "color-230"))))
 '(org-level-4 ((t (:foreground "color-166"))))
 '(org-link ((t (:foreground "color-75"))))
 '(org-meta-line ((t (:foreground "color-112"))))
 '(org-tag ((t (:foreground "color-172" :weight bold))))
 '(org-target ((t (:foreground "color-208" :underline t))))
 '(org-todo ((t (:foreground "brightmagenta" :weight bold))))
 '(org-verbatim ((t (:foreground "color-204"))))
 '(p4-depot-added-face ((t (:foreground "skyblue"))) t)
 '(p4-depot-branch-op-face ((t (:foreground "skyblue"))) t)
 '(p4-depot-unmapped-face ((t (:foreground "white"))) t)
 '(p4-diff-change-face ((t (:foreground "cornsilk"))) t)
 '(p4-diff-file-face ((t (:background "gray30"))) t)
 '(p4-diff-head-face ((t (:background "gray30"))) t)
 '(p4-diff-ins-face ((t (:foreground "skyblue"))) t)
 '(py-class-name-face ((t (:foreground "color-202"))))
 '(py-decorators-face ((t (:foreground "color-136"))))
 '(region ((((class color) (min-colors 88) (background dark)) (:background "brown4"))))
 '(rfcview-headname-face ((t (:foreground "orangered" :underline t :weight bold))))
 '(rust-builtin-formatting-macro ((t (:foreground "cyan"))))
 '(rust-string-interpolation ((t (:background "black" :foreground "color-202"))))
 '(speedbar-directory-face ((((class color) (background dark)) (:foreground "brown"))))
 '(speedbar-file-face ((((class color) (background dark)) (:foreground "color-180"))))
 '(speedbar-separator-face ((((class color) (background dark)) (:background "grey30" :foreground "color-155" :overline "gray" :underline t))))
 '(tab-bar ((t (:background "color-237" :foreground "color-178"))))
 '(tab-bar-tab ((t (:inherit tab-bar :foreground "brightyellow" :box 1))))
 '(tab-bar-tab-inactive ((t (:inherit tab-bar-tab :background "color-237" :foreground "color-230"))))
 '(tool-bar ((default (:foreground "white" :box (:line-width 1 :style released-button))) (nil nil)))
 '(trailing-whitespace ((((class color) (background dark)) (:background "yellow2"))))
 '(underline ((t (:foreground "color-208" :underline t))))
 '(vertical-border ((t (:inherit mode-line-inactive :background "color-23" :foreground "color-23")))))
