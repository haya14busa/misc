let s:FIZZBUZZ = { 'fizz': 'F', 'buzz': 'B', 'fizzbuzz': 'Z' }
" and other is defined as 'A'

function! s:to_fizzbuzz(n) abort
  return a:n % 15 ? a:n % 5 ? a:n % 3 ? 'A' : 'F' : 'B' : 'Z'
endfunction

" 15 cycle with 'A'
let s:cycle = join(map(range(1, 15), 's:to_fizzbuzz(v:val)'), '')
" Fizzbuzz cycle (without 'A')
let s:fb_cycle = substitute(s:cycle, 'A', '', 'g')
" The search field. If you remove the unneeded cycle to be searched, all
" pattern will be appear in the below field.
let s:field = s:cycle . s:cycle[:-2]

function! s:inverse_fizzbuzz(fbs) abort
  " Convert to 'FBZ' sequence
  let fbs = join(map(copy(a:fbs), 's:FIZZBUZZ[v:val]'), '')
  " Remove 'FBFFBFZ' cycle
  let fizzbuzz_cycle_pattern = '[^^]\zs\(' . s:fb_cycle . '\)\+'
  " If ['fizz', 'buzz'] given then target sequence will be 'FB'
  let target_fbs = substitute(fbs, fizzbuzz_cycle_pattern, '', '')
  " Insert 'A*' to generate pattern. e.g. FA*BA*F
  let t_pattern = join(split(target_fbs, '\zs'), 'A*')

  let start_idx = 0 " @var
  " The min_len is up to len(s:cycle)
  let min_len = len(s:cycle) " @var
  let r = [] " @var result [start, end]
  while 1
    let m = matchstr(s:field, t_pattern, start_idx)
    if m is# ''
      break
    endif
    let begin = stridx(s:field, m, start_idx)
    let len = strlen(m)
    if min_len > len
      let min_len = len
      " Fix 0 origin for answer
      let r = [begin + 1, begin + len]
    endif
    let start_idx += begin + 1
  endwhile

  if len(r) isnot 2
    " throw 'invalid'
    return []
  endif

  " Plus offset because of removed cycle
  let plus = ((len(fbs) - len(target_fbs)) / len(s:fb_cycle)) * len(s:cycle)
  return [r[0], r[1] + plus]
endfunction

" TEST: ---

let s:unit = ['fizz', 'buzz', 'fizz', 'fizz', 'buzz', 'fizz', 'fizzbuzz']

echo s:inverse_fizzbuzz(['fizz'])                                    == [3, 3]
echo s:inverse_fizzbuzz(['buzz'])                                    == [5, 5]
echo s:inverse_fizzbuzz(['fizzbuzz'])                                == [15, 15]
echo s:inverse_fizzbuzz(['fizz','fizz'])                             == [6, 9]
echo s:inverse_fizzbuzz(['fizz','buzz'])                             == [9, 10]
echo s:inverse_fizzbuzz(['fizz','buzz','fizz'])                      == [3, 6]
echo s:inverse_fizzbuzz(['fizz','fizz','buzz'])                      == [6, 10]
echo s:inverse_fizzbuzz(['buzz','fizz','fizz'])                      == [5, 9]
echo s:inverse_fizzbuzz(s:unit)                                      == [3, 15]
echo s:inverse_fizzbuzz(s:unit + s:unit)                             == [3, 30]
echo s:inverse_fizzbuzz(['fizzbuzz'] + repeat(s:unit, 0) + ['fizz']) == [15, 18]
echo s:inverse_fizzbuzz(['fizzbuzz'] + repeat(s:unit, 1) + ['fizz']) == [15, 33]
echo s:inverse_fizzbuzz(['fizzbuzz'] + repeat(s:unit, 2) + ['fizz']) == [15, 48]
echo s:inverse_fizzbuzz(['fizzbuzz'] + repeat(s:unit, 3) + ['fizz']) == [15, 63]

" invalid
echo s:inverse_fizzbuzz(['fizzbuzz'] + repeat(s:unit, 3) + ['buzz']) == []
echo s:inverse_fizzbuzz(['buzz', 'buzz'])                            == []

