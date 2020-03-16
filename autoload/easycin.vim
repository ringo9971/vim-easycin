scriptencoding utf-8

let s:save_cpo = &cpo
set cpo&vim

function! easycin#easycin() abort
  let s:line = getline('.') 
  let s:text = matchstr(s:line, '\(int\|string\|char\)', 'g')


  if s:text ==# 'int' || s:text ==# 'string' || s:text ==# 'char'
    let s:out = 'cin >> '
    let s:line = split(s:line, ' ')[1:]

    for i in s:line
      let s:out .= i[:-2] . ' >> '
    endfor
    let s:out = s:out[:-5] . ';'

    call append(line('.'), s:out)
    normal +=h 
  endif
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
