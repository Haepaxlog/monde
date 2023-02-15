# monde - kill-ring displayer
`"tout le monde le connaît"` - someone

monde is a collection of Emacs Lisp functions, which enable you to interact more easily with your kill-ring. It can 
- display the kill-ring in a buffer
- reload the kill-ring interactively in said buffer
- copy from that buffer into your kill-ring

## How-To

### `monde-open-kill-ring-buffer`
Opens the kill-ring in a right Window Split. The buffer is non-writeable.

### `monde-reload-buffer`
Loads kill-ring into current buffer. (Should only be used in designated monde-buffer as it erases the selected buffer)

### `monde-text-copy`
Copies text element from an ordered list seperated by newline into the kill-ring. (Also only really makes sense when used in designated monde-buffer)

## Installing
After downloading the file, add following command to your Emacs Config File:
``` emacs lisp
(load "path-to-monde.el")
```



