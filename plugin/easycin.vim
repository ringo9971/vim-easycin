scriptencoding utf-8

let s:save_cpo = &cpo
set cpo&vim

if exists('g:loaded_easycin')
  finish
endif
let g:loaded_easycin = 1


command! Inputcin call easycin#easycin()

let &cpo = s:save_cpo
unlet s:save_cpo
