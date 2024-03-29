;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Karl Wang"
      user-mail-address "kwkarlwang@gmail.com")

(setq doom-font (font-spec :family "JetBrainsMono Nerd Font"
                           :size 12
                           ))
(setq ns-use-thin-smoothing t)

(setq doom-theme 'dracula)
;; (setq doom-theme 'doom-dracula)
;; (setq doom-dracula-brighter-comments t)

(after! doom-themes
  (setq doom-themes-enable-bold nil)
  )

;;(unless (display-graphic-p)
  ;; (set-face-foreground 'font-lock-comment-face "#a8a8a8")
  ;; (set-face-foreground 'line-number "#a8a8a8")
  ;; (set-face-foreground 'font-lock-doc-face "#c6c6c6")
  ;; (set-face-background 'default "unspecfied")

  ;; (set-face-attribute 'region nil :background "#524867")
  ;; (set-face-attribute 'lazy-highlight nil :foreground "#f8f8f2" :background "#524867")
  ;; (after! lsp-mode
  ;;   (set-face-attribute 'lsp-face-highlight-textual nil :foreground "#f8f8f2" :background "#524867" :weight 'normal)
  ;;   (set-face-background 'markdown-code-face "unspecified")
  ;;   )
  ;; (after! magit
  ;;   (set-face-background 'magit-diff-removed-highlight "unspecified")
  ;;   (set-face-background 'magit-diff-added-highlight "unspecified")
  ;;   (set-face-background 'magit-diff-removed "unspecified")
  ;;   (set-face-background 'magit-diff-added "unspecified")
  ;;   )
  ;;)

;; (setq display-line-numbers-type 'visual)
(setq display-line-numbers-type 'nil)
;; Make evil-mode up/down operate in screen lines instead of logical lines
(define-key evil-motion-state-map "j" 'evil-next-visual-line)
(define-key evil-motion-state-map "k" 'evil-previous-visual-line)
;; Also in visual mode
(define-key evil-visual-state-map "j" 'evil-next-visual-line)
(define-key evil-visual-state-map "k" 'evil-previous-visual-line)

;; Scroll off
(setq scroll-margin 8)

(map!
 :n "C-s" #'+eshell/toggle
 :leader
 :desc "Toggle Comment" "c SPC" (lambda ()(interactive)(evilnc-comment-or-uncomment-lines -1))
 ;;:desc "Toggle Terminal" "j" (lambda ()(interactive)(+popup/toggle))
 :desc "Toggle line highlight" "t h" #'global-hl-line-mode
 )

(general-evil-setup)
(general-auto-unbind-keys)
(general-nmap "d"
  (general-key-dispatch 'evil-delete
    "h" #'evil-window-left
    "j" #'evil-window-down
    "k" #'evil-window-up
    "l" #'evil-window-right
    )
  )
(general-omap "h" #'evil-window-left)
(general-omap "j" #'evil-window-down)
(general-omap "k" #'evil-window-up)
(general-omap "l" #'evil-window-right)
(general-vmap "d" 'evil-delete)
;; FIXME: currently now working for some reason
;; (after! 'evil-org
;;   (general-nmap
;;     :keymaps evil-org-mode-map
;;     "d"
;;     (general-key-dispatch 'evil-org-delete
;;       "h" #'evil-window-left
;;       "j" #'evil-window-down
;;       "k" #'evil-window-up
;;       "l" #'evil-window-right
;;       )
;;     )
;;   )

(general-nmap "`" (general-key-dispatch 'evil-goto-mark
                    "`" #'evil-switch-to-windows-last-buffer
                    ))

(general-nmap "s"
  (general-key-dispatch 'evil-substitute
    "d" #'evil-window-delete
    "s" #'save-buffer
    )
  )

(general-nmap "c" (general-key-dispatch 'evil-change
                    "c" #'evilnc-comment-or-uncomment-lines
                    ))
;; (general-vmap "c" 'evil-change)

(general-nmap "'" #'evil-avy-goto-char-2-below)
(general-nmap "\"" #'evil-avy-goto-char-2-above)

(setq confirm-kill-emacs nil)

(setq-default fill-column 100)

(global-visual-line-mode)

(global-reveal-mode)

(global-eldoc-mode -1)

(modify-syntax-entry ?_ "w")

(setq undo-limit 80000000
      evil-want-fine-undo t)

(setq evil-vsplit-window-right t
      evil-split-window-below t)

(setq +evil-want-o/O-to-continue-comments nil)

(remove-hook 'doom-first-input-hook #'evil-snipe-mode)

;; (remove-hook 'text-mode-hook #'spell-fu-mode)

(setq ns-use-proxy-icon nil
      frame-title-format nil
      )

(setq-default delete-by-moving-to-trash t
              window-combination-resize t)

(after! company
  ;; Shortened keyboard typing auto complete delay
  (setq company-minimum-prefix-length 2
        company-idle-delay 0.0)
  ;; disable in eshell mode
  (add-to-list 'company-global-modes #'eshell-mode t)
  ;; (add-to-list 'company--disabled-backends 'company-ispell)
  (set-company-backend! '(text-mode org-mode)
    '(:separate company-yasnippet company-files company-dabbrev))
  )

(after! lsp-mode
  (setq
   lsp-headerline-breadcrumb-enable nil  ; not useful
   lsp-signature-render-documentation nil ; really annoying
   lsp-signature-auto-activate nil ; really annoying
   lsp-log-io nil ; increases performance
   lsp-idle-delay 0.5
   lsp-enable-symbol-highlighting nil
   lsp-eldoc-enable-hover nil
   ;; +lsp-company-backends
   ;; '(:separate company-capf company-yasnippet)
   )

  )
(after! lsp-ui
  ;; (lsp-ui-sideline-mode -1) ; flycheck is better
  (setq
   lsp-ui-sideline-enable 1
   lsp-ui-doc-enable nil
   ;; lsp-ui-doc-max-width 150
   ;; lsp-ui-doc-max-height 30
   )

  ;; show documentation
  (map!
   :map lsp-ui-mode
   :leader
   :desc "Show Documentation" "k" #'lsp-ui-doc-show
   )
  )

(after! lsp-pyright
  (setq lsp-pyright-python-executable-cmd "python3"
        lsp-pyright-multi-root nil
        lsp-pyright-use-library-code-for-types t
        lsp-pyright-diagnostic-mode "workspace"
        )
  )

;; (add-hook! 'lsp-pyright-after-open-hook
;;            (lsp:set-completion-options-trigger-characters?
;;             (lsp:server-capabilities-completion-provider?
;;              (lsp--workspace-server-capabilities (cl-first
;;                                                   (lsp-workspaces)
;;                                                   )))
;;             [])
;;  )

(add-hook! 'lsp-texlab-after-open-hook (eldoc-mode -1)
           (lsp:set-completion-options-trigger-characters?
            (lsp:server-capabilities-completion-provider?
             (lsp--workspace-server-capabilities (cl-first
                                                  (lsp-workspaces)
                                                  )))
            ["\\" "{" "}" "@" "/"])
           )

(add-hook! 'lsp-dockerfile-ls-after-open-hook
           (lsp:set-completion-options-trigger-characters?
            (lsp:server-capabilities-completion-provider?
             (lsp--workspace-server-capabilities (cl-first
                                                  (lsp-workspaces)
                                                  )))
            ["=" "$" "-"])
           (setq company-capf--sorted nil)
           )

(defun markdown-export-pdf ()
  "Export the current markdown to pdf using pandoc"
  (interactive)
  (save-buffer)
  (shell-command (concat "pandoc "
                         buffer-file-name
                         " -V geometry:margin=1in --pdf-engine=pdflatex -o "
                         (file-name-sans-extension buffer-file-name)
                         ".pdf"))
  )
(map!
 :map markdown-mode-map
 :localleader
 :desc "Export" "m" #'markdown-export-pdf)

(after! python
  ;; set shell
  (setq python-shell-interpreter "python3"
        ;; python-shell-interpreter-args "--simple-prompt"
        python-shell-prompt-detect-failure-warning nil)
  (add-to-list 'python-shell-completion-native-disabled-interpreters "python3")

  ;; NOTE: reenable lsp after format, local hook
  ;;(add-hook 'python-mode-hook (lambda() (add-hook 'after-save-hook #'lsp nil t)))

  ;; keybindings
  (map!
   :map python-mode-map
   (:localleader
    :desc "New cell" "s" (lambda() (interactive)
                           (+evil/insert-newline-below)
                           (next-line)
                           (insert "# %%\n")
                           )
    :desc "New cell below" "S" (lambda() (interactive)
                                 (+evil/insert-newline-below)
                                 (next-line)
                                 (insert "# %%\n")
                                 (previous-line)
                                 (previous-line))
    )
   )
  )

(use-package! jupyter
  :init
  ;; print to the REPL buffer
  (setq jupyter-repl-echo-eval-p t
        jupyter-repl-allow-RET-when-busy t
        )

  (defun init-jupyter-repl()
    "Initialize a python jupyter repl"
    (interactive)
    (set-face-background 'jupyter-repl-traceback nil)
    (jupyter-repl-associate-buffer
     (jupyter-run-repl "python37464bitbasecondabf9c15066bab4a48b97e94b7e7c780cc"))
    (jupyter-repl-pop-to-buffer)
    (previous-window-any-frame)
    )

  ;; set python jupyter shortcut
  (map!
   :map python-mode-map
   (:localleader
    (:prefix-map ("j" . "jupyter")
     :desc "Open REPL" "j"  #'init-jupyter-repl
     :desc "Show buffer" "s" (lambda()(interactive)
                               (jupyter-repl-pop-to-buffer)
                               (previous-window-any-frame))
     :desc "Associate buffer" "a" (lambda() (interactive) (jupyter-repl-associate-buffer))
     ))
   :ni "C-n" #'code-cells-forward-cell
   :ni "C-p" #'code-cells-backward-cell
   )
  )

(use-package! numpydoc
  :after python
  :init
  (setq numpydoc-insertion-style nil)
  (map!
   :map python-mode-map
   :localleader
   :desc "Docstring" "d" #'numpydoc-generate
   ))

(use-package! code-cells
  :hook ((python-mode . code-cells-mode))
  :after python
  :init
  ;; map forcut
  (map!
   :map python-mode-map
   :ni "C-<return>" (lambda()(interactive) (code-cells-do
                                            (pulse-momentary-highlight-region start end)
                                            (jupyter-eval-region start end)))

   :ni "S-<return>" (lambda()(interactive) (code-cells-do
                                            (pulse-momentary-highlight-region start end)
                                            (jupyter-eval-region start end)
                                            (code-cells-forward-cell)
                                            ))
   ;; used for general repl
   (:localleader
    :desc "Run cell python" "m" (code-cells-command 'python-shell-send-region)
    ))
  )

(after! org
  ;;adjust the scale of latex preview
  (plist-put org-format-latex-options :scale 1.7)
  ;; higher resolution preview
  (setq org-preview-latex-default-process 'dvisvgm)
  (add-hook 'org-mode-hook 'org-fragtog-mode)
  ;; markdown export
  ;; (setq org-pandoc-format-extensions '(markdown_github+pipe_tables+raw_html))
  (map!
   :map org-mode-map
   :localleader
   :desc "Latex preview" "m" #'org-latex-preview))
(after! ox-latex
  (add-to-list 'org-latex-classes '("IEEETran" "\\documentclass[conference]{IEEETran}"
                                    ("\\section{%s}" . "\\section*{%s}")
                                    ("\\subsection{%s}" . "\\subsection*{%s}")
                                    ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                                    ("\\paragraph{%s}" . "\\paragraph*{%s}")
                                    ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

  )

(after! tex
  (setq TeX-parse-self t
        TeX-auto-save t
        ;;LaTeX-indent-level 4
        )
  (map!
   :map LaTeX-mode-map
   :n "RET" #'org-latex-preview
   :localleader
   :desc "View" "v" #'TeX-view
   )
  )

(set-popup-rule! "^\\*format-all" :size 0.01 :ttl 0 :modeline nil)

(after! format-all
  (set-formatter! 'yapf "yapf -q " :modes'(python-mode))
  (add-to-list '+format-on-save-enabled-modes 'yaml-mode t)
  (add-hook! before-save '+format/buffer)
  )

(use-package! tree-sitter
  :init
  (defun toggle-tree-sitter ()
    (interactive)
    (if tree-sitter-mode
        (tree-sitter-mode -1)
      (tree-sitter-hl-mode))
    )
  (map!
   :leader
   :desc "Toggle tree-sitter" "t t" #'toggle-tree-sitter
   )
  (add-hook! 'tree-sitter-after-on-hook
    (add-hook! 'iedit-mode-hook :local (tree-sitter-mode -1))
    (add-hook! 'iedit-mode-end-hook :local (tree-sitter-hl-mode)))
  :config
  (require 'tree-sitter-langs)
  ;; Treat jupyter and python shell as python
  (pushnew! tree-sitter-major-mode-language-alist '(jupyter-repl-mode . python))
  (pushnew! tree-sitter-major-mode-language-alist '(inferior-python-mode . python))
  :hook (
         ;; enable tree sitter for the following mode
         (python-mode . tree-sitter-hl-mode)
         (jupyter-repl-mode . tree-sitter-hl-mode)
         (inferior-python-mode . tree-sitter-hl-mode)
         )
  )

(use-package pdf-view
  :hook (pdf-tools-enabled . pdf-view-midnight-minor-mode)
  :hook (pdf-tools-enabled . hide-mode-line-mode)
  :hook (pdf-tools-enabled . pdf-continuous-scroll-mode)
  )

(after! ispell
  (setq ispell-dictionary "en")
  )

(add-hook! '(prog-mode-hook) #'rainbow-mode #'rainbow-delimiters-mode)

(after! magit
  (setq git-commit-style-convention-checks nil
        magit-diff-hide-trailing-cr-characters t
        )
  )

(after! leetcode
  (setq leetcode-prefer-language "python3"
        leetcode-save-solutions t
        leetcode-directory "~/leetcode"
        )
  )
