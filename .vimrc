" PLUGINS ---------------------------------------------------------------- {{{
" Plugin code goes here.
" }}}


" MAPPINGS --------------------------------------------------------------- {{{
" Mappings code goes here.
" Map q to Ctrl + V for accessing Visual Block mode in WSL
nnoremap q <c-v>
" Add numbers to each line on the left-hand side.
set number
" }}}


" VIMSCRIPT -------------------------------------------------------------- {{{
" This will enable code folding.
" Use the marker method of folding.
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END
" WSL clipboard
if !empty($WSL_DISTRO_NAME)
  let s:clip = '/mnt/c/Windows/System32/clip.exe'
  if executable(s:clip)
    augroup WSLYank
      autocmd!
      autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
    augroup END
  endif
endif
" More Vimscripts code goes here.
" }}}


" STATUS LINE ------------------------------------------------------------ {{{
" Status bar code goes here.
" }}}
