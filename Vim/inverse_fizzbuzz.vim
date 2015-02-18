"=============================================================================
" FILE: inverse_fizzbuzz.vim
" AUTHOR: haya14busa
" License: MIT license
" REFERENCE:
" - [Inverse Fizzbuzz - just another scala quant](http://www.jasq.org/just-another-scala-quant/inverse-fizzbuzz)
" - [逆FizzBuzz問題 (Inverse FizzBuzz) - 猫とC#について書くmatarilloの雑記](http://d.hatena.ne.jp/matarillo/20120515/p1)
"=============================================================================

let s:T = !0
let s:F = !!0

function! s:is_fizzbuzz(x) abort
  return a:x % 3 is 0 || a:x % 5 is 0
endfunction

function! s:to_fizzbuzz(x) abort
  return
  \   a:x % 15 == 0 ? 'fizzbuzz'
  \ : a:x %  5 == 0 ? 'buzz'
  \ : a:x %  3 == 0 ? 'fizz'
  \ : a:x
endfunction

function! s:map_fizzbuzz(xs) abort
  return map(filter(a:xs, 's:is_fizzbuzz(v:val)'), 's:to_fizzbuzz(v:val)') 
endfunction

let s:cycle_n = filter(range(1, 15), 's:is_fizzbuzz(v:val)')
let s:cycle = map(copy(s:cycle_n), 's:to_fizzbuzz(v:val)')

" search range
let s:srange = s:cycle + s:cycle[0:-2]
" :echo s:srange
" " => ['fizz', 'buzz', 'fizz', 'fizz', 'buzz', 'fizz', 'fizzbuzz', 'fizz', 'buzz', 'fizz', 'fizz', 'buzz', 'fizz']

let s:srange_n = s:cycle_n + map(copy(s:cycle_n[0:-1]), 'v:val + 15')
" :echo s:srange_n
" " => [3, 5, 6, 9, 10, 12, 15, 18, 20, 21, 24, 25, 27, 30]

" fizzbuzz distance
function! s:fb_distance(s, len) abort
  return s:srange_n[a:s + a:len - 1] - s:srange_n[a:s]
endfunction

" " USAGE:
" :echo s:list_findall([1,2,3,1,2,3,4,4,1,2,3], [1,2,3])
" "                     ^____ ^____     ^____
" " => [0, 3, 8]        0     3         8
function! s:list_findall(target, xs) abort
  let is = [] " index list
  " i: index for target
  for i in range(len(a:target))
    let is_matched = s:T
    " j: index for xs
    for j in range(len(a:xs))
      if len(a:target) <= i + j
        let is_matched = s:F
        break
      endif
      if a:target[i + j] isnot# a:xs[j]
        let is_matched = s:F
      endif
    endfor
    if is_matched
      let is += [i]
    endif
  endfor
  return is
endfunction

" :echo s:drop_cycle([3,4,5,1,2,3,4,5,1,2,3,4,5,1,2], [1,2,3,4,5])
"                           ___________________ <- drop
" " => [3,4,5,1,2]
function! s:drop_cycle(target, cycle) abort
  let ss = s:list_findall(a:target, a:cycle)
  if empty(ss)
    return a:target
  endif
  for i in range(len(ss))
    let s = ss[i]
    if i + 1 == len(ss)
      break
    elseif (s + len(a:cycle)) == ss[i + 1]
      continue
    else
      throw 'the list is not cycle'
    endif
  endfor
  let first = ss[0] is 0 ? [] : a:target[:ss[0]-1]
  return first + a:target[ss[-1] + len(a:cycle):]
endfunction

" Main: ---

" fbs: List[String]
" @return: [start, end]
function! s:inverse_fizzbuzz(fbs) abort
  let search = s:drop_cycle(a:fbs, s:cycle)
  let dropped_cycle = (len(a:fbs) - len(search)) / len(s:cycle)
  if empty(search)
    let search = s:cycle
    let dropped_cycle -= 1
  endif
  let ss = s:list_findall(s:srange, search)
  if empty(ss)
    throw 'invalid'
  endif
  let min_i = ss[0]
  for s in ss[1:]
    if (s:fb_distance(min_i, len(search))) > (s:fb_distance(s, len(search)))
      let min_i = s
    endif
  endfor
  return [s:srange_n[min_i], s:srange_n[min_i + len(search) - 1] + dropped_cycle * 15]
endfunction


" Test: ---

echo s:inverse_fizzbuzz(s:cycle) | " => [3, 15]
echo s:inverse_fizzbuzz(s:cycle + s:cycle) | " => [3, 30]

echo s:inverse_fizzbuzz(['fizz'])         | " => [3, 3]
echo s:inverse_fizzbuzz(['fizz', 'buzz']) | " => [9, 10]
echo s:inverse_fizzbuzz(['buzz', 'fizz']) | " => [5, 6]
echo s:inverse_fizzbuzz(['fizzbuzz'])     | " => [15, 15]

echo s:inverse_fizzbuzz(['fizzbuzz', 'fizz']) | " => [15, 18]
echo s:inverse_fizzbuzz(['fizzbuzz'] + s:cycle + ['fizz']) | " => [15, 33]
echo s:inverse_fizzbuzz(['fizzbuzz'] + s:cycle + s:cycle + ['fizz']) | " => [15, 48]
echo s:inverse_fizzbuzz(['fizzbuzz'] + s:cycle + s:cycle + s:cycle + ['fizz']) | " => [15, 63]

let as = ['fizzbuzz'] + s:cycle + s:cycle + ['fizz']
let r = s:inverse_fizzbuzz(as)
let rs = s:map_fizzbuzz(range(r[0], r[-1]))
echo as == rs

