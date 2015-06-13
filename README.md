dotfiles
=============
Dotfiles managed by gnu stow.

eg.
stow [-v] [-t ~] tmux [other folders] -- will make symlink file ~/.tmux.conf pointing to <cur_dir>/tmux/.tmux.conf
stow -D [-v] [-t ~] <d_dir>           -- Remove symlinks from ~ dir which are pointed to objects in <d_dir>
stow -R [-v] [-t ~] <d_dir>           -- Update recent symlinks from ~ dir which are pointed to objects in <d_dir>
--ignore='.Trash'                     -- ignores files. eg --ignore='(?:\..*|[^+]*\+[^+]*)'
