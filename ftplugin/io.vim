" Vim filetype file
" Language:	Io
" Maintainer:	Israel Chauca <vim@en.sent.com>
" Last Change:	2023 May 11

if exists("b:did_ftplugin")
  " Stop here when a syntax file was already loaded
  finish
endif
let b:did_ftplugin = 1

let s:cpo_save = &cpo
set cpo&vim

" From javascript ftplugin
" Set 'formatoptions' to break comment lines but not other lines,
" and insert the comment leader when hitting <CR> or using "o".
setlocal formatoptions-=t formatoptions+=croql

setlocal comments&
setlocal commentstring=#%s

let b:undo_ftplugin = "setl fo< com< cms<"

let &cpo = s:cpo_save
unlet s:cpo_save
