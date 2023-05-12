" Vim indent file
" Language:	Io
" Maintainer:	Israel Chauca <vim@en.sent.com>
" Last Change:	2023 May 11
" Configuration:
"
" let g:ft_io_line_continuation = 3
"
" This variable determines how much the indentation level of continued lines is
" increased. The default value is 3 levels.

if exists("b:did_indent")
  finish
endif
let b:did_indent = 1

if has('vim9script')
  setlocal indentexpr=io#indent()
else
  setlocal indentexpr=GetIoIndent()
endif
setlocal indentkeys=0),!^F,o,O
setlocal nosmartindent
setlocal autoindent

let b:undo_indent = "setl inde< indk< si< ai<"
if exists('*GetIoIndent')
  finish
endif

function! GetIoIndent()
  let lnum = v:lnum
  if lnum == 1
    return 0
  endif
  if synIDattr(synID(lnum, 1, 1), "name") == 'IoStringLiteral'
    " do not change text
    return -1
  endif
  let cline = getline(lnum)
  let plnum = lnum - 1
  let pline = getline(lnum - 1)
  while plnum > 0 && (pline =~ '\m^\s*$'
        \ || synIDattr(synID(plnum, 1, 1), "name") == 'IoStringLiteral')
    let plnum -= 1
    let pline = getline(plnum)
    "echom 'reducing plnum: ' . plnum
  endwhile
  "echom 'lnum: ' . lnum
  "echom 'plnum: ' . plnum
  if synIDattr(synID(lnum, 1, 1), "name") == 'IoCommentBlock'
    "echom 'Comment block'
    let diff = 0
    if pline =~ '\m^\s*/\*'
      "echom 'Block begins here'
      " increase one level
      let diff += shiftwidth()
    endif
    if cline =~ '\m^\s*\*/'
      "echom 'Block ends here'
      " decrease one level
      let diff -= shiftwidth()
    endif
    return indent(plnum) + diff
  endif
  let ppline = getline(lnum - 2)
  "echom 'cline: ' . cline
  "echom 'pline: ' . pline
  "echom 'ppline: ' . ppline
  let balance = 0
  let p_ends_open = 0
  let c_start_open = 0
  " let's remove the strings
  let pline = pline->substitute('"\%(\\.\|[^"]\)*"', '', 'g')
  let ppline = ppline->substitute('"\%(\\.\|[^"]\)*"', '', 'g')
  " remove escaped characters
  let ppline = ppline->substitute('\\.', '', 'g')
  if pline =~ '\m\\$'
    "echom 'Continued line'
    " continuation line
    if ppline =~ '\m\\$'
      " second or higher continued line, just copy the previous indent
      return indent(plnum)
    endif
    " first continued line, increase indentation
    return indent(plnum) + shiftwidth() * g:->get('ft_io_line_continuation', 3)
  elseif ppline =~ '\m\\$'
    " this line is not a continued line but the previous line is, decrease
    " indentation
    return indent(plnum) - shiftwidth() * g:->get('ft_io_line_continuation', 3)
  endif
  " let's remove the eol comments
  let pline = pline->substitute('\%(#\|//\).*', '', '')
  if pline =~ '\m^\s*)'
    "echom 'pline starts with ): +1'
    let balance += 1
  endif
  if cline =~ '\m^\s*)'
    "echom 'cline starts with ): -1'
    let balance -= 1
  endif
  " remove anything that is not a paren
  let pline = pline->substitute('[^()]\+', '', 'g')
  let pparens = pline->split('\zs')->filter({k, v -> v == '(' || v == ')'})
  "echom 'pparens: ' . pparens->string()
  let plparen = pparens->copy()->filter({k, v -> v == '('})->len()
  "echom 'plparen: ' . plparen->string()
  let balance += plparen
  let prparen = pparens->copy()->filter({k, v -> v == ')'})->len()
  "echom 'prparen: ' . prparen->string()
  let balance -= prparen
  "echom 'balance: ' . balance
  let diff = balance * shiftwidth()
  let indent = indent(plnum)
  if (indent + diff) < 0
    return 0
  endif
  return indent + diff
endfunction
