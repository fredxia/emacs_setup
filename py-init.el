(use-package lsp-pyright
  :ensure t
  :hook (python-mode . (lambda ()
                         (require 'lsp-pyright)
                         (lsp-deferred)))
;  :bind (:map python-mode-map
;              ("M-m" . lsp-ui-imenu)
;              ("M-." . lsp-find-definition)
;              ("M-n" . lsp-find-references))
  )

;(add-hook 'python-mode-hook #'lsp-deferred)
;(add-hook 'python-mode-hook #'yas-minor-mode)
