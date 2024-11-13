;; -*- coding: utf-8; lexical-binding: t; -*-
;; basic gnu emacs settings. Everything in this file is for plain gnu emacs only.
;; for emacs 28 or later.
;; Version: 2024-08-21

;; Emacs: Init File Tutorial
;; http://xahlee.info/emacs/emacs/emacs_init_file.html

;; HHHH---------------------------------------------------
;; UTF-8 as default encoding
;; http://xahlee.info/emacs/emacs/emacs_file_encoding.html
;; http://xahlee.info/emacs/emacs/emacs_encoding_decoding_faq.html

(set-language-environment "utf-8")
(set-default-coding-systems 'utf-8-unix)
(set-keyboard-coding-system 'utf-8-unix)
(set-terminal-coding-system 'utf-8-unix)

;; HHHH---------------------------------------------------
;; initial window and default window
;; http://xahlee.info/emacs/emacs/emacs_customize_default_window_size.html

(setq inhibit-startup-screen t)

(push '(tool-bar-lines . 0) default-frame-alist)
;(push '(background-color . "honeydew") default-frame-alist)

;; HHHH---------------------------------------------------
;; backup
;; http://xahlee.info/emacs/emacs/emacs_set_backup_into_a_directory.html

(setq make-backup-files t)

;; make multiple versions, ending in ~1~ ~2~ etc
(setq version-control t)

;; make sure hard link and creation date, owner, etc is preserved
(setq backup-by-copying t)

;; make backup even in git controlled dir
(setq vc-make-backup-files t)

;; silently delete old backup
(setq delete-old-versions :no) ; default nil
;; t means silent delete
;; nil means ask
;; other values means do not delete

;; (setq kept-old-versions 2) ; default 2
;; (setq kept-new-versions 2) ; default 2

;; function that decide a file should be backed up
;; (setq backup-enable-predicate 'normal-backup-enable-predicate )

;; a alist (regex . dir) to decide where to place backup
;; (setq backup-directory-alist '(("." . "~/.emacs.d/backup")))

;; HHHH---------------------------------------------------
;;; real auto save

;; Emacs: Real Automatic Save File
;; http://xahlee.info/emacs/emacs/emacs_auto_save.html

;; (when (>= emacs-major-version 26)
;;   (auto-save-visited-mode 1)
;;   (setq auto-save-visited-interval 30) ; default 5
;;   )

(defun xah-save-all-unsaved ()
  "Save all unsaved files. no ask.
Version 2019-11-05"
  (interactive)
  (save-some-buffers t ))

(when (>= emacs-major-version 27)
  (setq after-focus-change-function 'xah-save-all-unsaved)
  ;; to undo this, run
  ;; (setq after-focus-change-function 'ignore)
  )

;; Emacs: auto-save (filename with #hashtag#)
;; http://xahlee.info/emacs/emacs/emacs_auto-save_backup.html
(setq auto-save-default nil)
(setq create-lockfiles nil)

;; HHHH---------------------------------------------------
;; Emacs: Bookmark Init
;; http://xahlee.info/emacs/emacs/emacs_bookmark_init.html

;; save bookmark on change
(setq bookmark-save-flag 1)

;; HHHH---------------------------------------------------
;; file related

;; auto refresh
;; http://xahlee.info/emacs/emacs/emacs_refresh_file.html
(global-auto-revert-mode 1)

;; Emacs: Open Recently Opened File
;; http://xahlee.info/emacs/emacs/emacs_recentf.html
;(require 'recentf)
(recentf-mode 1)

(progn
  ;; (desktop-save-mode 1)
  (setq desktop-restore-frames t)
  (setq desktop-auto-save-timeout 300)
  (setq desktop-globals-to-save nil)
  ;; (setq desktop-globals-to-save '(desktop-missing-file-warning tags-file-name tags-table-list search-ring regexp-search-ring register-alist file-name-history))
  (setq desktop-save t))

;; HHHH---------------------------------------------------
;; user interface

(when (> emacs-major-version 26)
  (global-display-line-numbers-mode))

(column-number-mode 1)
(blink-cursor-mode 0)
;; (setq use-dialog-box nil)

(progn
  ;; no need to warn
  (put 'narrow-to-region 'disabled nil)
  (put 'narrow-to-page 'disabled nil)
  (put 'upcase-region 'disabled nil)
  (put 'downcase-region 'disabled nil)
  (put 'erase-buffer 'disabled nil)
  (put 'scroll-left 'disabled nil)
)

(setq mouse-highlight nil)

;; HHHH---------------------------------------------------
;; Emacs: Dired Customization
;; http://xahlee.info/emacs/emacs/emacs_dired_tips.html

;; copy, move, rename etc to the other pane
(setq dired-dwim-target t)

;; allow copy dir with subdirs
(setq dired-recursive-copies 'top)
(setq dired-recursive-deletes 'top)

(put 'dired-find-alternate-file 'disabled nil)

;; some goodies
(require 'dired-x)

;; HHHH---------------------------------------------------

;(progn
  ;; minibuffer setup
;  (setq enable-recursive-minibuffers t)
;  (savehist-mode 0)
  ;; big minibuffer height, for ido to show choices vertically
;  (setq max-mini-window-height 0.5)
  ;; minibuffer, stop cursor going into prompt
;  (customize-set-variable
;   'minibuffer-prompt-properties
;   (quote (read-only t cursor-intangible t face minibuffer-prompt))))

(when (>= emacs-major-version 28)
  (progn
    (setq completion-styles '(flex))))
 ;   (icomplete-vertical-mode 1)))

;; HHHH---------------------------------------------------

;; remember cursor position
(when (>= emacs-major-version 25) (save-place-mode 1))

;; HHHH---------------------------------------------------
;;; editing related

;; make typing delete/overwrites selected text
(delete-selection-mode 1)

;; disable shift select
(setq shift-select-mode nil)

(electric-pair-mode 1)

;; for isearch-forward, make these equivalent: space newline tab hyphen underscore
(setq search-whitespace-regexp "[-_ \t\n]+")

(setq composition-break-at-point t)

(setq hippie-expand-try-functions-list
      '(
        try-expand-dabbrev
        try-expand-dabbrev-all-buffers
        ;; try-expand-dabbrev-from-kill
        try-complete-lisp-symbol-partially
        try-complete-lisp-symbol
        try-complete-file-name-partially
        try-complete-file-name
        ;; try-expand-all-abbrevs
        ;; try-expand-list
        ;; try-expand-line
        ))

;; 2015-07-04 bug of pasting in emacs.
;; http://debbugs.gnu.org/cgi/bugreport.cgi?bug=16737#17
;; http://xahlee.info/emacs/misc/emacs_bug_cant_paste_2015.html
;; (setq x-selection-timeout 300)
;; (setq save-interprogram-paste-before-kill t)
;; (setq x-select-enable-clipboard-manager nil)

;; HHHH---------------------------------------------------
;; editing, mark

;; Emacs: Jump to Previous Position
;; http://xahlee.info/emacs/emacs/emacs_jump_to_previous_position.html

;; repeated C-u set-mark-command move cursor to previous mark in current buffer
(setq set-mark-command-repeat-pop t)

(setq mark-ring-max 10)
(setq global-mark-ring-max 10)

;; HHHH---------------------------------------------------
;;; rendering related for coding/editting

;; force line wrap to wrap at word boundaries
;; http://xahlee.info/emacs/emacs/emacs_toggle-word-wrap.html
(setq-default word-wrap t)

;; set highlighting brackets
(show-paren-mode 1)
(setq show-paren-style 'parenthesis)

;; HHHH---------------------------------------------------
;; Emacs: Tab/Indent Setup
;; http://xahlee.info/emacs/emacs/emacs_tabs_space_indentation_setup.html

(electric-indent-mode 0)

(set-default 'tab-always-indent 'complete)

;; no mixed tab space
(setq-default indent-tabs-mode nil)
 ; gnu emacs at least 23.1 to 28 default is t

;; gnu emacs default to 8. tooo big. but problem of diff value is that some elisp source code in gnu emacs expected 8 to look nice, cuz they use mixed tab and space. but in golang, 8 is too much. also, python and others, standardize to 4
(setq-default tab-width 4)

(setq sentence-end-double-space nil )

;; HHHH---------------------------------------------------

;; load emacs 24's package system. Add MELPA repository.
(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   '("melpa" . "https://melpa.org/packages/")
   t))

;; HHHH---------------------------------------------------

(progn
  ;; Make whitespace-mode with very basic background coloring for whitespaces.
  ;; http://xahlee.info/emacs/emacs/whitespace-mode.html
  (setq whitespace-style (quote (face spaces tabs newline space-mark tab-mark newline-mark)))

  ;; Make whitespace-mode and whitespace-newline-mode use “¶” for end of line char and “▷” for tab.
  (setq whitespace-display-mappings
        ;; all numbers are unicode codepoint in decimal. e.g. (insert-char 182 1)
        '((space-mark 32 [183] [46]) ; SPACE 32 「 」, 183 MIDDLE DOT 「·」, 46 FULL STOP 「.」
          (newline-mark 10 [182 10]) ; LINE FEED,
          (tab-mark 9 [9655 9] [92 9]) ; tab
          )))

;; HHHH---------------------------------------------------

(if (version< emacs-version "28.1")
    (defalias 'yes-or-no-p 'y-or-n-p)
  (setq use-short-answers t))

;; HHHH---------------------------------------------------

;; 2021-12-21. fuck Alan Mackenzie
;; Emacs Lisp Doc String Curly Quote Controversy
;; http://xahlee.info/emacs/misc/emacs_lisp_curly_quote_controversy.html
(setq text-quoting-style 'grave)

;; 2023-08-04 turn off byte compile warning on unescaped single quotes
(setq byte-compile-warnings '(not docstrings) )

(setq byte-compile-docstring-max-column 999)

;; HHHH---------------------------------------------------

;; up/down arrow move based on logical lines (newline char) or visual line
(setq line-move-visual nil)
;; default is t
;; http://xahlee.info/emacs/emacs/emacs_arrow_down_move_by_line.html

;; HHHH---------------------------------------------------

;; (global-tab-line-mode)

(tooltip-mode -1)

;; HHHH---------------------------------------------------

;; 2023-01-24 apache per dir config file
(add-to-list 'auto-mode-alist '("\\.htaccess\\'" . conf-unix-mode))

;; 2023-01-24 pdf mode is super slow. should use dedicated app
(add-to-list 'auto-mode-alist '("\\.pdf\\'" . fundamental-mode))
