vim9script
# Vim autoload functions file
# Language:	Io
# Maintainer:	Israel Chauca <vim@en.sent.com>
# Last Change:	2023 May 11
# Configuration:
#
# let g:ft_io_line_continuation = 3
#
# This variable determines how much the indentation level of continued lines is
# increased. The default value is 3 levels.

export def Indent(_lnum = 0): number
  var lnum: number = _lnum > 0 ? _lnum : v:lnum
  var plnum: number
  var plparen: number
  var prparen: number
  var balance: number
  var diff: number
  var indent: number
  var cline: string
  var pline: string
  var ppline: string
  var pparens: list<string>
  if lnum == 1
    return 0
  endif
  if synIDattr(synID(lnum, 1, 1), "name") == 'IoStringLiteral'
    # do not change text
    #echom 'Literal String'
    return -1
  endif
  cline = getline(lnum)
  plnum = lnum - 1
  pline = getline(plnum)
  while plnum > 0 && (pline =~ '\m^\s*$'
        || synIDattr(synID(plnum, 1, 1), "name") == 'IoStringLiteral')
    plnum -= 1
    pline = getline(plnum)
    #echom 'reducing plnum: ' .. plnum
  endwhile
  #echom 'lnum: ' .. lnum
  #echom 'plnum: ' .. plnum
  if synIDattr(synID(lnum, 1, 1), "name") == 'IoCommentBlock'
    #echom 'Comment block'
    diff = 0
    if pline =~ '\m^\s*/\*'
      #echom 'Block begins here'
      # increase one level
      diff += shiftwidth()
    endif
    if cline =~ '\m^\s*\*/'
      "echom 'Block ends here'
      # decrease one level
      diff -= shiftwidth()
    endif
    return indent(plnum) + diff
  endif
  ppline = getline(lnum - 2)
  #echom 'cline: ' .. cline
  #echom 'pline: ' .. pline
  #echom 'ppline: ' .. ppline
  balance = 0
  # let's remove the strings
  pline = pline->substitute('"\%(\\.\|[^"]\)*"', '', 'g')
  ppline = ppline->substitute('"\%(\\.\|[^"]\)*"', '', 'g')
  # remove escaped characters
  ppline = ppline->substitute('\\.', '', 'g')
  if pline =~ '\m\\$'
    #echom 'Continued line'
    # continuation line
    if ppline =~ '\m\\$'
      # second or higher continued line, just copy the previous indent
      return indent(plnum)
    endif
    # first continued line, increase indentation
    return indent(plnum) + shiftwidth() * g:->get('ft_io_line_continuation', 3)
  elseif ppline =~ '\m\\$'
    #echom 'Previous is continued line'
    # this line is not a continued line but the previous line is, decrease
    # indentation
    return indent(plnum) - shiftwidth() * g:->get('ft_io_line_continuation', 3)
  endif
  # let's remove the eol comments
  pline = pline->substitute('\%(#\|//\).*', '', '')
  if pline =~ '\m^\s*)'
    #echom 'pline starts with ): +1'
    balance += 1
  endif
  if cline =~ '\m^\s*)'
    #echom 'cline starts with ): -1'
    balance -= 1
  endif
  # remove anything that is not a paren
  pline = pline->substitute('[^()]\+', '', 'g')
  pparens = pline->split('\zs')->filter((k, v) => v == '(' || v == ')')
  #echom 'pparens: ' .. pparens->string()
  plparen = pparens->copy()->filter((k, v) => v == '(')->len()
  #echom 'plparen: ' .. plparen
  balance += plparen
  prparen = pparens->copy()->filter((k, v) => v == ')')->len()
  #echom 'prparen: ' .. prparen
  balance -= prparen
  diff = balance * shiftwidth()
  indent = plnum > 0 ? indent(plnum) : 0
  if (indent + diff) < 0
    return 0
  endif
  return indent + diff
enddef
