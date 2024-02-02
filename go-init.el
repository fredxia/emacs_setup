;(use-package gopls
; :ensure
; :bind (:map go-mode-map

;; Company mode
(setq company-idle-delay 0)
(setq company-minimum-prefix-length 1)

;; Go - lsp-mode
;; Set up before-save hooks to format buffer and add/delete imports.
(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))
(add-hook 'go-mode-hook #'lsp-go-install-save-hooks)

;; Start LSP Mode and YASnippet mode
(add-hook 'go-mode-hook #'lsp-deferred)
(add-hook 'go-mode-hook #'yas-minor-mode)

;(defun lsp-go-install-save-hooks ()
;  (add-hook 'before-save-hook #'lsp-format-buffer t t)
;  (add-hook 'before-save-hook #'lsp-organize-imports t t))
;(add-hook 'go-mode-hook #'lsp-go-install-save-hooks)

;; Start LSP Mode and YASnippet mode
(add-hook 'go-mode-hook #'lsp-deferred)
(add-hook 'go-mode-hook #'yas-minor-mode)

(defun go-mode-func()
  (add-hook 'before-save-hook 'gofmt-before-save)
  (setq tab-width 4)
  (setq standard-indent 4)
  (setq indent-tabs-mode 1)
  (let ((map go-mode-map))
    (define-key map (kbd "M-m") 'lsp-ui-imenu)
    (define-key map (kbd "M-.") 'lsp-find-definition)
    (define-key map (kbd "M-n") 'lsp-find-references)
    (define-key map (kbd "C-c C-c l") 'flycheck-list-errors)
    (define-key map (kbd "C-c C-c a") 'lsp-execute-code-action)
    (define-key map (kbd "C-c C-c q") 'lsp-workspace-restart)
    (define-key map (kbd "C-c C-c Q") 'lsp-workspace-shutdown)))

(add-hook 'go-mode-hook 'go-mode-func)
