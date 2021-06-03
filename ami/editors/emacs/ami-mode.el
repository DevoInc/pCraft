;; AMI Mode -- A Major Mode for AMI files
;; Written by Sebastien Tricaud, Dec. 2020

(provide 'ami-mode)

(defgroup ami nil
  "Ami Language Major Mode"
  :group 'languages)

(defconst ami-language-version "1.0"
  "Ami language version number.")

(defvar ami-mode-menu nil "Menu for Ami mode")
(defvar ami-mode-hook nil "Ami mode hook")

(progn
  (add-to-list 'auto-mode-alist '("\\.hmi\\'" . ami-mode))
  (add-to-list 'auto-mode-alist '("\\.ami\\'" . ami-mode)))

;; Make sure comments are colorized
(defvar ami-mode-syntax-table nil "Syntax table for `ami-mode'.")
(setq ami-mode-syntax-table
      (let ((ami-mode-syntax-table (make-syntax-table)))
        (modify-syntax-entry ?# "<"  ami-mode-syntax-table)
        (modify-syntax-entry ?\n ">" ami-mode-syntax-table)
        ami-mode-syntax-table))

;; Hook to Meta-; for commenting/uncommenting
(add-hook 'ami-mode-hook
          (lambda ()
	    (set (make-local-variable 'comment-start-skip) "#+ *")
            (set (make-local-variable 'comment-start) "#")
            (set (make-local-variable 'comment-end) "")))

(defconst ami-keywords-directives
  '(
    ;; Headers
    "ami_version" "av" "start_time" "st" "revision" "author" "shortdesc" "description"
    "reference" "tag" "message" "slice_run" "slice_div" "ignore_group_sleep" "skip_repeat"

    ;; Include
    "include"

    ;; Other keywords
    "debugon" "debugoff" "exit"))

(defconst ami-keywords-functions
  '( "action" "repeat"
    ))

(defconst ami-keywords-statements
  '(
    ;; Statement
    "field" "exec" "sleep" "local" "delete" "fromgroup" "group"

    ;; Loops
    "as"))

(defconst ami-constants
  '(
    ;; Boolean
    "true" "false"))

(setq ami-globalconcatvar-regexp (rx "${" (group (+(any alnum "-_+/."))) "}" ))
(setq ami-globalvar-regexp (rx "$" (group (+(any alnum "-_+/."))) " " ))
(setq ami-globalvar-regexp2 (rx "$" (group (+(any alnum "-_+/."))) "\n" ))

(defvar ami-font-lock-keywords
  (append
   `(
     ;; Keywords, constants and types
     (,(regexp-opt ami-keywords-directives  'symbols) . font-lock-keyword-face)
     (,(regexp-opt ami-constants            'symbols) . font-lock-constant-face)
     (,(regexp-opt ami-keywords-statements  'symbols) . font-lock-type-face)
     (,(regexp-opt ami-keywords-functions   'symbols) . font-lock-function-name-face)
     (,ami-globalconcatvar-regexp . font-lock-variable-name-face)
     (,ami-globalvar-regexp . font-lock-variable-name-face)
     (,ami-globalvar-regexp2 . font-lock-variable-name-face)
     )))



(define-derived-mode ami-mode css-mode "ami mode"
  "Major mode for editing AMI files"
    (set-syntax-table ami-mode-syntax-table)
    (setq font-lock-defaults '((ami-font-lock-keywords))))

