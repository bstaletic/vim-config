# vim-config

### How I (ab)used vim's runtime path

- All the plugins are located in `pack`.
- Filetype specific stuff is in `ftplugin`.
  - Except python which is in `after/ftplugin`.
- Every single function is in `autoload`.
- Settings of plugins are in `plugin`.
- `vimrc` contains miscelinous `autocmd`s, `noremap`s and `set`s.
