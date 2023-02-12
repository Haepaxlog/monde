;;; monde.el --- Description -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2023 Constantin Rohde
;;
;; Author: Constantin Rohde <rohdeconstantin@gmail.com>
;; Maintainer: Constantin Rohde <rohdeconstantin@gmail.com>
;; Created: February 11, 2023
;; Modified: February 11, 2023
;; Version: 0.0.1
;; Keywords: abbrev bib c calendar comm convenience data docs emulations extensions faces files frames games hardware help hypermedia i18n internal languages lisp local maint mail matching mouse multimedia news outlines processes terminals tex tools unix vc wp
;; Homepage: https://github.com/Haepaxlog/monde
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;; Commentary:
;;  "monde" was choosen, because I just like the french expression for everyone, <<tout le monde>>.
;;  Likewise "monde" enables you to see everything your Emacs stores ;).
;;
;;  Description:
;;  This is a simple bundle of Emacs Lisp functions, which enable you to see the Kill-Ring in a seperate Buffer and copy from it.
;;
;;; Code:

(defun monde-reload-buffer ()
  "Reloads the buffer with curren kill ring."
  (interactive)
  (let ((inhibit-read-only t))
    (erase-buffer)
    (monde-insert-kill-ring)))

(defun monde-text-copy ()
  "Copy an element under the cursor to the clipboard."
  (interactive)
  (let ((i (save-excursion
        (backward-paragraph)
        (if (equal (line-number-at-pos) 1)
            nil
          (forward-line))
        (string-to-number (buffer-substring-no-properties (point) (forward-sentence))))))
        (kill-new (substring-no-properties (current-kill i 'do-not-move) 0 (length (current-kill i 'do-not-move))))
        (message (format "Succesfully Copied Line %s to Clipboard!"
                         i)))
  (monde-reload-buffer))

(defun monde-insert-kill-ring ()
        "Insert 'kill-ring' elements as strings into buffer with name 'monde'."
        (goto-char (point-min))
        (save-excursion
        (let ((map (make-sparse-keymap)))
          (define-key map [mouse-1] 'monde-text-copy)
          (define-key map (kbd "RET") 'monde-text-copy)
        (dotimes (n (length kill-ring))
                (if (eq n nil) nil
                  (if (string-match-p "^\s*$" (nth n kill-ring)) nil
                    (let ((s (propertize (nth n kill-ring) 'face 'bold-italic 'mouse-face 'highlight 'help-echo "mouse-1 copy text" 'keymap map)))
                      (insert (format "%s.\t" n))
                      (insert (format "%s\n" s))
                      (newline) )))))))

(defun monde-open-kill-ring-buffer ()
    "Open a new buffer with 'kill-ring' displayed."
    (interactive)
    (let ((buffer-name "*monde*"))
      (if (get-buffer buffer-name) (kill-buffer buffer-name) nil)
      (get-buffer-create buffer-name)
      (select-window (split-window-right))
      (switch-to-buffer (set-buffer buffer-name))
      (monde-insert-kill-ring)
      (read-only-mode t)))

(provide 'monde)
;;; monde.el ends here
