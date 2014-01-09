" Vim syntax file
" Language:	C
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last Change:	2013 Jul 05

" Quit when a (custom) syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

setlocal iskeyword+=:
setlocal iskeyword+=#
syn case ignore

"syn match todoHome	"[a-zA-Z0-9._-]\+#"
"syn match console	"^[a-zA-Z0-9._-]\{,20}#"
"syn match datestamp	"^\*.\{,25}\s"
syn match datestamp	"^*.*\.[0-9]\{3}"
"syn match celComment "#.*$" 
syn match debug "%.*?\:" 
syn match hash "[#>]" 


syn keyword basicLanguageKeywords CST: SP\-STDBY: RP-STDBY: DFC1: DFC2: DFC3: DFC4: DFC5: DFC6: DFC7: SP: RP:  

syn region section_tech	start="^\-"  end='$'
syn region celString start='"' end='"'
"syn region debug	start='%'  end=':'
"syn region todoWork	start=/^w: / end=/
"/ 
"syn region todoPersonal	start=/^p: / end=/
"/
"syn region section_tech	start=/^/- / end=/$
"/
highlight link celString		Type
highlight link console		Boolean
highlight link datestamp		String
highlight link hash		PreProc
highlight link celComment	Statement
highlight link section_tech	Special
highlight link basicLanguageKeywords	Constant
highlight link debug Type   

let b:current_syntax = "cisco_logs"












