scriptencoding utf-8

let s:save_cpo = &cpo
set cpo&vim

function! easycin#easycin() abort
  let s:line = getline('.')
  let s:text = matchstr(s:line, '\(int\|string\|char\|double\|vector\)', 'g')
  let s:is_pair = v:false

  if s:text ==# 'int' || s:text ==# 'string' || s:text ==# 'char' || s:text ==# 'double'
    let s:line = split(s:line, ' ')[1:]

    let s:out = 'cin >> '
    for i in s:line
      let s:out .= i[:-2] . ' >> '
    endfor
    let s:out = s:out[:-5] .';'

  elseif s:text ==# 'vector'
    if count(s:line, 'vector') == 1
      if count(s:line, 'pair') == 1
        let s:line = split(s:line, ' ')[2:]
        let s:is_pair = v:true
      else
        let s:line = split(s:line, ' ')[1:]
      endif

      let s:name = []
      for i in s:line
        let s:num = matchstr(i, '(.\{-})', 'g')[1:-2]
        call add(s:name, matchstr(i, '.\{-}(', 'g')[:-2])
      endfor

      let s:out = 'REP(i, ' . s:num . ') cin >> '
      for i in s:name
        if s:is_pair
          let s:out .= i . '[i].first >> ' . i . '[i].second >> '
        else
          let s:out .= i . '[i] >> '
        endif
      endfor
      let s:out = s:out[:-5] .';'

    elseif count(s:line, 'vector') == 3
      let s:line = split(s:line, ' ')[1:]
      let s:name = matchstr(s:line[0], '.\{-}(')[:-2]
      let s:i    = matchstr(s:line[0], '(.\{-},')[1:-2]
      let s:j    = matchstr(s:line[1], '(.\{-})')[1:-2]

      let s:out = 'REP(i, ' . s:i . ') REP(j, ' . s:j .') cin >> ' . s:name .'[i][j];'
    endif
  else
    return
  endif

  call append(line('.'), s:out)
  normal +=h 
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
