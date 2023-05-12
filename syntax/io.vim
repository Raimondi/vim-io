" Vim syntax file
" Language:	Io
" Maintainer:	Israel Chauca <vim@en.sent.com>
" Last Change:	2023 May 11
" Configuration:
"
" let g:ft_io_highlight_messages = 'all'
"
" This variable determines how extensive the highlighting of messages will be.
" It can have the following values:
"   'all':	Highlight all messages [default]
"   'none':	No highlighting of messages
"   'flow':	Only flow control messages are highlighted
"   'object':	All slots of Object are highlighted in messages

if exists("b:current_syntax")
  " Stop here when a syntax file was already loaded
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

syn sync fromstart
syn iskeyword @,48-57,192-255

" TODO Should we use more colors?

syn match IoPrototype /\<\u\w*\>/
syn match IoOperator /[^a-zA-Z0-9";._()]\|\.\.\+/

if g:->get('ft_io_highlight_messages', 'all') ==? 'flow_control'
  syn keyword IoSlot if ifTrue ifFalse ifTrueIfFalse then else elseif
  syn keyword IoSlot ifDebug ifNil ifNilEval ifError for loop reverseForeach
  syn keyword IoSlot foreach foreachSlot map continue break yield while do
  syn keyword IoSlot return returnIfError returnIfNonNil exit block method
elseif g:->get('ft_io_highlight_messages', 'all') ==? 'object'
  syn keyword IoSlot actorProcessQueue actorRun ancestorWithSlot ancestors and contained
  syn keyword IoSlot appendProto apropos argIsActivationRecord argIsCall contained
  syn keyword IoSlot asSimpleString asString become block break checkMemory contained
  syn keyword IoSlot clone cloneWithoutInit compact compactState compare contained
  syn keyword IoSlot contextWithSlot continue coroDo coroDoLater coroFor contained
  syn keyword IoSlot coroWith currentCoro debugOff debugOn debugWriteln contained
  syn keyword IoSlot deprecatedWarning do doFile doMessage doRelativeFile contained
  syn keyword IoSlot doString doURL evalArg evalArgAndReturnNil contained
  syn keyword IoSlot evalArgAndReturnSelf for foreach foreachSlot forward contained
  syn keyword IoSlot getLocalSlot getSlot handleActorException hasLocalSlot contained
  syn keyword IoSlot hasProto hasSlot if ifDebug ifError ifNil ifNilEval contained
  syn keyword IoSlot ifNonNil ifNonNilEval in inlineMethod isActivatable contained
  syn keyword IoSlot isError isIdenticalTo isKindOf isLaunchScript isNil contained
  syn keyword IoSlot isTrue justSerialized launchFile lazySlot list contained
  syn keyword IoSlot localsForward localsUpdateSlot loop markClean memorySize contained
  syn keyword IoSlot memorySizeOfState message method newSlot not or ownsSlots contained
  syn keyword IoSlot pSlots pause perform performWithArgList persist contained
  syn keyword IoSlot persistData persistMetaData persistSlots ppid contained
  syn keyword IoSlot prependProto print println proto protos raiseIfError contained
  syn keyword IoSlot relativeDoFile removeAllProtos removeAllSlots removeProto contained
  syn keyword IoSlot removeSlot resend return returnIfError returnIfNonNil contained
  syn keyword IoSlot selfserialized serializedSlots serializedSlotsWithNames contained
  syn keyword IoSlot setIsActivatable setPpid setProto setProtos setSlot contained
  syn keyword IoSlot setSlotWithType shallowCopy shouldPersistByDefault contained
  syn keyword IoSlot slotDescriptionMap slotNames slotSummary slotValues contained
  syn keyword IoSlot stopStatus super switch tailCall thisContext contained
  syn keyword IoSlot thisLocalContext thisMessage try type uniqueHexId contained
  syn keyword IoSlot uniqueId unpersist updateSlot wait while write writeln contained
  syn keyword IoSlot yield contained
elseif g:->get('ft_io_highlight_messages', 'all') ==? 'none'
  " nothing to highlight here
else " 'all'
  syn match IoSlot /[^;()[:blank:]]\+/ contained
endif

syn match IoMessage /[^;.()=[:blank:]]\+\s*(/ contains=IoSlot

syn match IoString /"\%(\\.\|[^"]\)*"/ contains=IoStringEsc
syn region IoStringLiteral start=/"""/ skip=/\\"/ end=/"""/
syn match IoStringEsc /\\./ contained

syn match IoNumber /-\?\<\d\+\%([eE]-\?\d\+\)\?\>/ contains=IoNumberExp,IoNumberNeg
syn match IoNumber /-\?\%(\<\d\+\)\?\.\d\+\%([eE]-\?\d\+\)\?\>/ contains=IoNumberExp,IoNumberDot,IoNumberNeg
syn match IoNumber /\<0[xX]\x\+\>/ contains=IoNumberHex
syn match IoNumberHex /[xX]/ contained
syn match IoNumberExp /[eE]/ contained

syn region IoCommentBlock start=+/\*+ end=+\*/+
syn match IoComment /\%(#\|\/\/\).*/
syn keyword IoCommentTodo FIXME NOTE NOTES TODO XXX containedin=IoComment,IoCommentBlock

hi def link IoComment		Comment
hi def link IoCommentBlock	Comment
hi def link IoCommentTodo	Todo
hi def link IoString		String
hi def link IoStringLiteral	String
hi def link IoStringEsc		Special
hi def link IoSlot		Function
hi def link IoPrototype		Type
hi def link IoIdent		Identifier
hi def link IoOperator		Operator
hi def link IoNumber		Number
hi def link IoNumberHex		SpecialChar
hi def link IoNumberExp		SpecialChar

let b:current_syntax = "io"

let &cpo = s:cpo_save
unlet s:cpo_save
