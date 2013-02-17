if version < 700
  syntax clear
elseif exists('b:current_syntax')
  finish
endif

" error
syntax region uniteError start=+!!!+ end=+!!!+ contains=uniteErrorHidden oneline
if has('conceal')
  syntax match uniteErrorHidden '!!!' contained conceal
else
  syntax match uniteErrorHidden '!!!' contained
endif
highlight default link uniteError Error
highlight default link uniteErrorHidden Ignore

syntax match uniteSourcePrompt /^Sources/ contained nextgroup=uniteSeparator
syntax match uniteSeparator /:/ contained nextgroup=uniteSourceNames
syntax match uniteSourceNames / [[:alnum:]_\/-]\+/ contained nextgroup=uniteSourceArgs,uniteCommand
syntax match uniteMessage /^\[.\{-}\].*$/  contains=uniteMessageSource,uniteNumber,uniteGitCommand,uniteBundleName
syntax match uniteMessageSource /^\[.\{-}\]/ contained
syntax match uniteSourceArgs /:\S\+/ contained
highlight default link uniteSourcePrompt Prompt
highlight default link uniteSeparator NONE
highlight default link uniteSourceNames Constant
highlight default link uniteMessage NONE
highlight default link uniteMessageSource Constant
highlight default link uniteSourceArgs Function

" git
syntax match uniteGitCommand /git \S\+ -\S\+/ contained contains=uniteGit,uniteGitArg
syntax match uniteGitArg /\-\S\+/ contained
syntax match uniteGit /git/ contained
syntax match uniteBundleName /|\@<=\S\+|\@=/ contained
highlight default link uniteGitCommand GitCommand
highlight default link uniteGitArg Arguments
highlight default link uniteGit Command
highlight default link uniteBundleName Identifier

" string
syntax match uniteStringSpecial '\\\([0-9]\+\|o[0-7]\+\|x[0-9a-fA-F]\+\|[\"\\'&\\abfnrtv]\|^[A-Z^_\[\\\]]\)' contained
syntax region uniteString start=+"+ end=+"+ contains=uniteStringSpecial,uniteCandidateInputKeyword oneline contained
syntax region uniteString start=+'+ end=+'+ contains=uniteStringSpecial,uniteCandidateInputKeyword oneline contained
highlight default link uniteStringSpecial SpecialChar
highlight default link uniteString String

" files
syntax match uniteFile '.\+\f\(\s\s\s\)\@=' contained containedin=uniteCandidateAbbr,uniteSource__FileMru contains=uniteCandidateInputKeyword
syntax match unitePdfHtml '.*\.\(pdf\|html\)\>' contained containedin=uniteFile contains=uniteCandidateInputKeyword
syntax match uniteArchive '.*\.\(lha\|lzh\|zip\|gz\|bz2\|cab\|rar\|7z\|tgz\|tar\)\>' contained containedin=uniteFile contains=uniteCandidateInputKeyword
syntax match uniteImage '.*\.\(eps\|bmp\|BMP\|png\|PNG\|gif\|GIF\|JPE\?G\|jpe\?g\|jp2\|tif\|ico\|wdp\|cur\|ani\)\>' contained containedin=uniteFile contains=uniteCandidateInputKeyword
syntax match uniteTypeMultimedia '.*\.\(
      \.avi\|asf\|wmv\|flv\|swf\|divx\|mov\|m1a\|
      \.m2[ap]\|mpe\?g\|m[12]v\|mp2v\|mp[34a]\|qt\|ra\|rm\|ram\|
      \.rmvb\|rpm\|smi\|mkv\|mid\|wav\|ogg\|wma\|au\)\>' contained containedin=uniteFile contains=uniteCandidateInputKeyword
syntax match uniteTypeSystem '.*\.\(o\|hi\|inf\|sys\|reg\|dat\|spi\|a\|so\|lib\|dll\)\>' contained containedin=uniteFile contains=uniteCandidateInputKeyword
syntax match uniteTypeSystem '\(#\S\+#\|configure[\s$]\|aclocal\.m4\|[Mm]akefile\(\.in\)\?\|stamp-h1\|config\.\(h\.in\~\?\|status\)\|output\.[0-9]\S\?\|requests\|traces\.[0-9]\S\?\)\s\@=' contained containedin=uniteFile contains=uniteCandidateInputKeyword
highlight default link unitePdfHtml PdfHtml
highlight default link uniteArchive Archive
highlight default link uniteImage Image
highlight default link uniteTypeMultimedia Multimedia
highlight default link uniteTypeSystem System

syntax region uniteMarkedLine start=/^\*/ end='$' keepend
syntax region uniteNonMarkedLine start=/^- / end='$' keepend contains=uniteCandidateMarker,uniteCandidateSourceName,uniteCandidateAbbr
syntax match uniteCandidateMarker /^- / contained
syntax match uniteQuickMatchTrigger /^.|/ contained
syntax match uniteNumber '\<\d\+\>' contained containedin=uniteStatusLine
syntax match uniteLineNumber '\(^- *+\? *\)\@<=\<\d\+\>' contained containedin=uniteSource__Line
highlight default link uniteNumber Number
highlight default link uniteLineNumber LineNr
highlight default link uniteMarkedLine Marked
highlight default link uniteQuickMatchTrigger Special
highlight default link uniteCandidateSourceName uniteSourceNames
highlight default link uniteCandidateMarker Icon
highlight default link uniteCandidateInputKeyword PreCondit

" vimshell history
syntax match uniteSpecial '[|<>;&]' contained
syntax match uniteCommand '\(^- vimshell/history \(\S\+\)\?\)\@<=\S\+' contained contains=uniteCandidateSourceName,uniteCandidateInputKeyword
syntax match uniteCommand '[|;&]\s*\f\+' contains=uniteSpecial,uniteCandidateInputKeyword contained
syntax match uniteArguments '\s-\=-[[:alnum:]-]\+' contained contains=uniteCandidateInputKeyword
syntax match uniteVimshellHistory '.*' contains=uniteSpecial,uniteCommand,uniteString,GitHubCommand,uniteNumber,uniteArguments,uniteDotFiles contained containedin=uniteSource__VimshellHistory
highlight default link uniteSpecial Special
highlight default link uniteCommand Command
highlight default link uniteArguments Arguments

highlight default link uniteChooseAction NONE
highlight default link uniteChooseCandidate NONE
highlight default link uniteChooseKey SpecialKey
highlight default link uniteChooseMessage NONE
highlight default link uniteChoosePrompt uniteSourcePrompt
highlight default link uniteChooseSource uniteSourceNames
highlight default link uniteSource__FileMru_Time Date

highlight default link uniteInputPrompt Prompt
highlight default link uniteInputPromptError Error
highlight default link uniteInputSpecial Special

" TODO: check what is done in this function
" TODO: 全面的に書きなおす
" TODO: あらゆるソースでうまくいくように
call unite#set_highlight()

let b:current_syntax = 'unite'

" TODO: waringとsearchを別に
