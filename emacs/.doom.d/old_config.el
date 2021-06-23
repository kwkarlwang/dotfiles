;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Karl Wang"
      user-mail-address "kwkarlwang@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

(setq doom-font (font-spec :family "Fira Code"
                           :size 13))

(after! highlight-numbers
  (set-face-bold 'highlight-numbers-number nil)
  )

;; doom-variable-pitch-font (font-spec :family "Monaco"
;;                                     :size 18)

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-dracula)
;; (setq doom-dracula-brighter-comments t)
;; change comment color and line number color for the TUI
(unless (display-graphic-p)
  (set-face-foreground 'font-lock-comment-face "#a8a8a8")
  (set-face-foreground 'line-number "#a8a8a8")
  (set-face-foreground 'font-lock-doc-face "#c6c6c6")
  (set-face-background 'default "undefined")
  )

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; No confirmation about quitting
(setq confirm-kill-emacs nil)

;; Fill column
(setq-default fill-column 100)
(global-visual-line-mode)
(global-auto-revert-mode)
(global-eldoc-mode -1)

;; Better defaults
(setq-default delete-by-moving-to-trash t
              window-combination-resize t)

;; Display time on the status bar
(display-time-mode 1)
;; treate "_" as a word in evil mode
(modify-syntax-entry ?_ "w")

;; no new line comment
(setq +evil-want-o/O-to-continue-comments nil)

(set-popup-rule! "^\\*format-all" :size 0.01 :ttl 0 :modeline nil)
;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;;------------------------------------------------------------------------------



(after! format-all
  (set-formatter! 'yapf "yapf -q " :modes'(python-mode))
  )

;; comment function
(map!
 :leader
 :desc "Toggle Comment" "c SPC" (lambda ()(interactive)(evilnc-comment-or-uncomment-lines -1))
 )

;; toggle terminal
(map!
 :leader
 :desc "Toggle Terminal" "j" (lambda ()(interactive)(+popup/toggle))
 )

;; Auto complete related
(after! company
  ;; Shortened keyboard typing auto complete delay
  (setq company-minimum-prefix-length 2
        company-idle-delay 0.0)
  ;; (add-to-list 'company--disabled-backends 'company-ispell)
  (set-company-backend! '(text-mode)
    '(:separate company-yasnippet company-files company-dabbrev))
  )

;; LSP related
(after! lsp-pyright
  (setq lsp-pyright-python-executable-cmd "python3"
        lsp-pyright-multi-root nil
        )
  )
(after! lsp-mode
  (setq
   lsp-headerline-breadcrumb-enable nil
   lsp-signature-render-documentation nil
   lsp-signature-auto-activate nil
   lsp-log-io nil
   lsp-idle-delay 0.5
  )
(after! lsp-ui
  (lsp-ui-sideline-mode -1)
  (setq
   lsp-ui-sideline-enable nil
   lsp-ui-doc-enable nil
   lsp-ui-doc-max-width 150
   lsp-ui-doc-max-height 30
   )
  (map!
   :map lsp-ui-mode
   :leader
   :desc "Show Documentation" "k" #'lsp-ui-doc-show
   )
  )

;; show for documentation

;; Latex view mapping

;; Markdown export pdf
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


;; ---------------- Python related ----------------

(after! python
  (setq python-shell-interpreter "python3"
        ;; python-shell-interpreter-args "--simple-prompt"
        python-shell-prompt-detect-failure-warning nil)
  (add-to-list 'python-shell-completion-native-disabled-interpreters "python3")

  (add-hook 'python-mode-hook (lambda() (add-hook 'after-save-hook #'lsp nil t)))

  (map!
   :map python-mode-map
   :n "<" #'python-indent-shift-left
   :n ">" #'python-indent-shift-right
   (:localleader
    :desc "New cell" "s" (lambda() (interactive) (insert "\n# %%\n"))
    :desc "New cell below" "S" (lambda() (interactive)
                                 (insert "\n# %%\n")
                                 (previous-line)
                                 (previous-line))
    )
   )
  )


;; For using the interactive shell
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

;; For document generation
(use-package! numpydoc
  :after python
  :init
  (setq numpydoc-insertion-style nil)
  (map!
   :map python-mode-map
   :localleader
   :desc "Docstring" "d" #'numpydoc-generate
   ))

;; For recongizing code cell
(use-package! code-cells
  :hook ((python-mode . code-cells-mode))
  :after python
  :init
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

   (:localleader
    :desc "Run cell python" "m" (code-cells-command 'python-shell-send-region)
    ))

  )

;; Tree sitter, use to highlight function call
(use-package! tree-sitter
  :after python
  :init
  (defun toggle-tree-sitter ()
    (interactive)
    (if tree-sitter-mode
        (tree-sitter-mode -1)
      (tree-sitter-hl-mode 1))
    )
  (map!
   :map python-mode-map
   :localleader
   :desc "Toggle tree-sitter" "t" #'toggle-tree-sitter
   )
  :config
  (require 'tree-sitter-langs)
  (pushnew! tree-sitter-major-mode-language-alist '(jupyter-repl-mode . python))
  (pushnew! tree-sitter-major-mode-language-alist '(inferior-python-mode . python))
  :hook ((python-mode . tree-sitter-hl-mode)
         (python-mode . (lambda ()
                          (add-function :before-until (local 'tree-sitter-hl-face-mapping-function)
                                        (lambda (capture-name)
                                          (pcase capture-name
                                            ("method.call" 'font-lock-function-name-face)
                                            ("function.call" 'font-lock-function-name-face)
                                            )))))
         (jupyter-repl-mode . tree-sitter-hl-mode)
         (inferior-python-mode . tree-sitter-hl-mode)
         )
  )
;; -----------------------------------------------
(after! org
  ;;adjust the scale of latex preview
  (plist-put org-format-latex-options :scale 1.1)
  (setq org-preview-latex-default-process 'dvisvgm)
  (map!
   :map org-mode-map
   :localleader
   :desc "Latex preview" "m" #'org-latex-preview))


;; make S work like before in vim
(remove-hook 'doom-first-input-hook #'evil-snipe-mode)


;; set default master file
(add-hook! 'lsp-texlab-after-open-hook (eldoc-mode -1)
           (lsp:set-completion-options-trigger-characters?
            (lsp:server-capabilities-completion-provider?
             (lsp--workspace-server-capabilities (cl-first
                                                  (lsp-workspaces)
                                                  )))
            ["\\" "{" "}" "@" "/"])
           )
(after! tex
  (setq TeX-parse-self t
        TeX-auto-save t
        LaTeX-indent-level 4
        )
  (map!
   :map LaTeX-mode-map
   :n "RET" #'org-latex-preview
   :localleader
   :desc "View" "v" #'TeX-view)
  )

;; Default pdf dark mode
(use-package pdf-view
  :hook (pdf-tools-enabled . pdf-view-midnight-minor-mode)
  :hook (pdf-tools-enabled . hide-mode-line-mode)
  :hook (pdf-tools-enabled . pdf-continuous-scroll-mode)
  :config
  (map!
   :map pdf-continuous-scroll-mode-map
   :n "j" #'pdf-continuous-scroll-forward
   :n "k" #'pdf-continuous-scroll-backward
   :n "g g" #'pdf-cscroll-first-page
   :n "G" #'pdf-cscroll-last-page
   :n "l" #'pdf-cscroll-image-forward-hscroll
   :n "h" #'pdf-cscroll-image-backward-hscroll
   :n "C-d" #'pdf-view-scroll-down-or-previous-page
   :n "C-u" #'pdf-view-scroll-up-or-next-page
   )
  (map!
   :map pdf-view-mode-map
   :n "c" #'pdf-continuous-scroll-mode
   )
  )

;; Appearnace
(add-hook! '(prog-mode-hook) #'rainbow-mode #'rainbow-delimiters-mode)


;; spell check
(after! ispell
  (setq ispell-dictionary "en")
  )

(add-hook! 'lsp-dockerfile-ls-after-open-hook
           (lsp:set-completion-options-trigger-characters?
            (lsp:server-capabilities-completion-provider?
             (lsp--workspace-server-capabilities (cl-first
                                                  (lsp-workspaces)
                                                  )))
            ["=" "$" "-"])
           )
