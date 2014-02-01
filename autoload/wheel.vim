" ============================================================================
" File:        wheel.vim
" Description: autoload functions for vim-wheel plugin
" Maintainer:  Reed Esau <github.com/reedes>
" Created:     February 01, 2014
" License:     The MIT License (MIT)
" ============================================================================

scriptencoding utf-8

if &cp || (exists('g:autoloaded_wheel')
      \ && !exists('g:force_reload_wheel'))
  finish
endif
let g:autoloaded_wheel = 1

function! wheel#VScroll(cmd, visual)
  " cmd: 0=up 1=down
  let l:threshold = max([&scrolloff, g:wheel#line#threshold])
  let l:ln = line('.')
  if a:visual ==# ''
    if a:cmd
      if &wrap || l:ln <= l:threshold
        exe "normal! gj"
      else
        exe "normal! gj\<C-E>"
      endif
    else
      if &wrap || (line('$') - l:ln) < l:threshold
        exe "normal! gk"
      else
        exe "normal! gk\<C-Y>"
      endif
    endif
  else          " some kind of visual
    if a:cmd
      if &wrap
        exe "normal! gvgj"
      else
        exe "normal! gvgj\<C-E>"
      endif
    else
      if &wrap
        exe "normal! gvgk"
      else
        exe "normal! gvgk\<C-Y>"
      endif
    endif
  endif
endfunction

function! wheel#HScroll(cmd, visual)
  " cmd: 0=left 1=right
  if a:visual ==# ''
    if &wrap
      if a:cmd
        exe "normal! l"
      else
        exe "normal! h"
      endif
    else
      let l:c = col('.')
      let l:e = col('$')
      if a:cmd
        if l:c <# (l:e - &sidescrolloff - 1)
          exe "normal! zll"
        elseif l:c <# (l:e - 1)
          exe "normal! l"
        endif
      elseif l:c ># &sidescrolloff
        exe "normal! zhh"
      elseif l:c ># 1
        exe "normal! h"
      endif
    endif
  else          " some kind of visual
    if &wrap
      if a:cmd
          exe "normal! gvl"
      else
          exe "normal! gvh"
      endif
    else
      if a:cmd
          exe "normal! gvzll"
      else
          exe "normal! gvzhh"
      endif
    endif
  endif
endfunction
