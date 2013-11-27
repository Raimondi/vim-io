" Vim Syntax File
" Language:     Io
" Creator:      Scott Dunlop <swdunlop@verizon.net>
" Fixes:        Manpreet Singh <junkblocker@yahoo.com>
"               Jonathan Wright <quaggy@gmail.com>
"               Erik Garrison <erik.garrison@gmail.com>
"
" Packaging:    Andrei Maxim <andrei@andreimaxim.ro>
" Last Change:  2013 Nov 26

if version < 600
    syntax clear
elseif exists("b:current_syntax")
    finish
endif

syntax case match

" equivalent to io-mode-prototype-names in io-mode.el
syntax keyword IoType Array AudioDevice AudioMixer Block Box Buffer CFunction
syntax keyword IoType CGI Color Curses DBM DNSResolver DOConnection DOProxy
syntax keyword IoType DOServer Date Directory Duration DynLib Error Exception
syntax keyword IoType FFT File Fnmatch Font Future GL GLE GLScissor GLU
syntax keyword IoType GLUCylinder GLUQuadric GLUSphere GLUT Host Image Importer
syntax keyword IoType LinkList List Lobby Locals MD5 MP3Decoder MP3Encoder Map
syntax keyword IoType Message Movie Notification Number Object
syntax keyword IoType OpenGL Point Protos Regex SGML SGMLElement SGMLParser SQLite
syntax keyword IoType Server ShowMessage SleepyCat SleepyCatCursor Socket
syntax keyword IoType Sequence SocketManager Sound Soup Store String Tree UDPSender
syntax keyword IoType UPDReceiver URL User Warning WeakLink
syntax keyword IoType Random BigNum Sequence

" Object methods
syntax keyword IoKeyword activate activeCoroCount actorProcessQueue actorRun
syntax keyword IoKeyword addTrait ancestorWithSlot ancestors and appendProto
syntax keyword IoKeyword apropos argIsActivationRecord argIsCall asSimpleString
syntax keyword IoKeyword asString asyncSend become block break call catch clone
syntax keyword IoKeyword cloneWithoutInit collectGarbage compare compileString
syntax keyword IoKeyword contextWithSlot continue coroDo coroDoLater coroFor
syntax keyword IoKeyword coroWith currentCoro deprecatedWarning do doFile
syntax keyword IoKeyword doMessage doRelativeFile doString else elseif evalArg
syntax keyword IoKeyword evalArgAndReturnNil evalArgAndReturnSelf exit for
syntax keyword IoKeyword foreach foreachSlot forward futureSend
syntax keyword IoKeyword getEnvironmentVariable getLocalSlot getSlot
syntax keyword IoKeyword handleActorException hasDirtySlot hasLocalSlot hasProto
syntax keyword IoKeyword hasSlot if ifError ifFalse ifNil ifNilEval ifNonNil
syntax keyword IoKeyword ifNonNilEval ifTrue in init inlineMethod isActivatable
syntax keyword IoKeyword isActive isError isIdenticalTo isKindOf isLaunchScript
syntax keyword IoKeyword isNil isResumable isTrue justSerialized launchFile
syntax keyword IoKeyword lazySlot lexicalDo list loop markClean memorySize
syntax keyword IoKeyword message method newSlot not or ownsSlots parent pass
syntax keyword IoKeyword pause perform performWithArgList prependProto print
syntax keyword IoKeyword println proto protos raise raiseIfError raiseResumable
syntax keyword IoKeyword relativeDoFile removeAllProtos removeAllSlots
syntax keyword IoKeyword removeProto removeSlot resend resume return
syntax keyword IoKeyword returnIfError returnIfNonNil schedulerSleepSeconds self
syntax keyword IoKeyword sender serialized serializedSlots
syntax keyword IoKeyword serializedSlotsWithNames setIsActivatable setProto
syntax keyword IoKeyword setProtos setSchedulerSleepSeconds setSlot
syntax keyword IoKeyword setSlotWithType shallowCopy slotDescriptionMap
syntax keyword IoKeyword slotNames slotSummary slotValues stopStatus super
syntax keyword IoKeyword switch system then thisBlock thisContext
syntax keyword IoKeyword thisLocalContext thisMessage try type uniqueHexId
syntax keyword IoKeyword uniqueId updateSlot wait while write writeln yield

syntax keyword IoBoolean true false nil

syntax match IoProtos     +\<\u\a*\>(\@!+
syntax match IoDelimiters +[][{}()]+

syntax match IoOperator +\s\([@?;.]\)\1\?\%([ (]\|\_w\)\@=+
syntax match IoOperator +\s:\{,2}=\%([ (]\|\_w\)\@=+
syntax match IoOperator +\s[<>!=]=\%([ (]\|\_w\)\@=+
syntax match IoOperator +\s[*/<>+-]\%([ (]\|\_w\)\@=+

syntax match IoHexNumber +\<0[xX]\>+ display
syntax match IoHexNumber +\<0[xX]\x\+[lL]\?\>+ display
syntax match IoFloat     +\.\d\+\([eE][+-]\?\d\+\)\?[jJ]\?\>+ display
syntax match IoFloat     +\<\d\+\%(\.\d*\)\?\%([eE][+-]\?\d\+\)\?[jJ]\?\>+ display
syntax match IoNumber    +\<\d\+[lLjJ]\?\>+ display

syntax match IoOctalError "\<0\o*[89]\d*[lL]\=\>" display
syntax match IoError      "\<0[xX]\X\+[lL]\=\>" display

syntax region  IoComment start=+#\|//+ end=+$+
syntax region  IoComment start=+/\*+ end=+\*/+
syntax keyword IoTodo TODO XXX NOTE FIXME BUG HACK containedin=IoComment contained
syntax match   IoCommentTitle -\%(^\|/[/*]\|#\)\s*\%(\u\w*\s*\)\+:- containedin=IoComment contained contains=IoCommentLead
syntax match   IoCommentLead +/[*/]\|#+ contained

syntax region IoString start=+"+ skip=+\\"+ end=+"+
syntax region IoString start=+"""+ end=+"""+
syntax region IoInterpolate matchgroup=IoInterpolateDelim start=+#{+ end=+}+ containedin=IoString contains=TOP,IoComment.* keepend contained

highlight link IoType             Type
highlight link IoProtos           Type
highlight link IoBoolean          Boolean
highlight link IoKeyword          Function
highlight link IoString           String
highlight link IoDelimiters       Delimiter
highlight link IoComment          Comment
highlight link IoTodo             Todo
highlight link IoCommentLead      Comment
highlight link IoCommentTitle     PreProc
highlight link IoOperator         Operator
highlight link IoInterpolate      Normal
highlight link IoInterpolateDelim Delimiter
highlight link IoHexNumber        Number
highlight link IoNumber           Number
highlight link IoFloat            Float
highlight link IoOctalError       Error
highlight link IoError            Error

let b:current_syntax = "io"
" vim: set sw=2 sts=2 et fdm=marker:
