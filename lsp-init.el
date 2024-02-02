(use-package lsp-mode
  :ensure
  :commands lsp
  :custom
  ;; what to use when checking on-save. "check" is default, I prefer clippy
  ;(lsp-rust-analyzer-cargo-watch-command "clippy")
  (lsp-eldoc-render-all t)
  (lsp-idle-delay 0.6)
  (lsp-lens-enable nil)
  (lsp-eldoc-enable-hover t)
  (lsp-headerline-breadcrumb-enable nil)
  (lsp-enable-symbol-highlighting nil)
  (lsp-signature-auto-activate nil)
  (lsp-signature-render-documentation nil)
  ; flycheck
  (lsp-diagnostics-provider nil)
  :config
  (add-hook 'lsp-mode-hook 'lsp-ui-mode))

(use-package lsp-ui
  :ensure
  :commands lsp-ui-mode
  :custom
  (lsp-ui-peek-always-show t)
  (lsp-ui-sideline-show-hover nil)
  (lsp-ui-doc-enable nil)
  (lsp-ui-sideline-enable nil)
  (lsp-ui-doc-show-with-cursor nil))

 (use-package company
   :ensure
   :custom
   (company-idle-delay 0.5) ;; how long to wait until popup
   ;; (company-begin-commands nil) ;; uncomment to disable popup
   :bind
   (:map company-active-map
 	      ("C-n". company-select-next)
 	      ("C-p". company-select-previous)
 	      ("M-<". company-select-first)
 	      ("M->". company-select-last)))

 (use-package yasnippet
   :ensure
   :config
   (yas-reload-all)
   (add-hook 'prog-mode-hook 'yas-minor-mode)
   (add-hook 'text-mode-hook 'yas-minor-mode))

(use-package flycheck :ensure)

;; ------------------------------------------------------------------------
;; c++
;; ------------------------------------------------------------------------

;; ------------------------------------------------------------------------
;; rust
;; ------------------------------------------------------------------------
(use-package rustic
  :ensure
  :bind (:map rustic-mode-map
              ("M-m" . lsp-ui-imenu)
              ("M-." . lsp-find-definition)
              ("M-n" . lsp-find-references)
              ("C-c C-c l" . flycheck-list-errors)
              ("C-c C-c a" . lsp-execute-code-action)
              ("C-c C-c r" . lsp-rust-analyzer-inlay-hints-mode)
              ("C-c C-c q" . lsp-workspace-restart)
              ("C-c C-c Q" . lsp-workspace-shutdown)
              ("C-c C-c s" . lsp-rust-analyzer-status))
  :config
  (lsp-rust-analyzer-cargo-watch-command nil)
  (lsp-rust-analyzer-server-display-inlay-hints t)
  ;; uncomment for less flashiness
  ;; (setq lsp-eldoc-hook nil)
  ;; (setq lsp-enable-symbol-highlighting nil)
  ;; (setq lsp-signature-auto-activate nil)

  ;; comment to disable rustfmt on save
  ;(setq rustic-format-on-save nil)
  (setq rustic-format-trigger nil)
  (add-hook 'rustic-mode-hook 'rustic-mode-hook))

(defun rustic-mode-hook ()
  ;; so that run C-c C-c C-r works without having to confirm, but don't try to
  ;; save rust buffers that are not file visiting. Once
  ;; https://github.com/brotzeit/rustic/issues/253 has been resolved this should
  ;; no longer be necessary.
  (when buffer-file-name
    (setq-local buffer-save-without-query t))
;  (setq lsp-rust-analyzer-cargo-override-command "/home/fxia/notes/rust_for_ana.sh")
  )

; Toggle inlay hints mode
(defun rust_hints()
 (interactive)
 (lsp-rust-analyzer-inlay-hints-mode t))

;; ------------------------------------------------------------------------
;; python
;; ------------------------------------------------------------------------
(use-package lsp-pyright
  :ensure t
  :hook (python-mode . (lambda ()
                         (require 'lsp-pyright)
                         (lsp-deferred)))
  :bind (:map python-mode-map
              ("M-m" . lsp-ui-imenu)
              ("M-." . lsp-find-definition)
              ("M-n" . lsp-find-references))
  )

;(add-hook 'python-mode-hook #'lsp-deferred)
;(add-hook 'python-mode-hook #'yas-minor-mode)
