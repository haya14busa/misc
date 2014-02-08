" Sample vim-easymotion setting with introducing new feature

" config leader key or turn off default mapping(recommend)
map <Leader> <Plug>(easymotion-prefix)
let g:EasyMotion_do_mapping = 0 " turn off

" bi-directional find motion
" - you can jump to anywhere with only three type `s{char}{target}`
" - `s<CR>` repeat last find motion.
" - default `s` can be replaced with `cl` but you can map any key you like.
nmap s <Plug>(easymotion-s)
xmap s <Plug>(easymotion-s)
omap z <Plug>(easymotion-s) " consider vim-surround mapping.

" provide `t` like motion. It's useful in operator-pending mode. (e.g. `d<Leader>z]`)
" I think vim-sneak should implement this motion to use as a textobject
omap <Leader>t <Plug>(easymotion-t)
omap <Leader>T <Plug>(easymotion-T)

" if you want to type two chars as target. <Leader>s{char}<CR> to use one character
map <Leader>s <Plug>(easymotion-s2)
" if you want to type `n` chars as target. <Leader>n{char}{char}...<CR> to jump.
map <Leader>n <Plug>(easymotion-sn)

" Extention of `h`, `l`
" with default JK motion, you can move more easily
map <Leader>h <Plug>(easymotion-linebackward)
map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
" keep cursor colum JK motion compatibile with default `j`,`k`
let g:EasyMotion_startofline = 0

" bi-directional word motion or jumptoanywheremotion
map <Leader>w <Plug>(easymotion-bd-w)
map <Space><Space> <Plug>(easymotion-jumptoanywhere)

" New option
" smartcase in find motion (type `a` and match `a`&`A`)
let g:EasyMotion_smartcase = 1
" Smartsign (type `1` and match `1`&`!`)
let g:EasyMotion_use_smartsign_us = 1
" Use upper case(show label by upper case and you can type it as lower case. It improves label readability)
let g:EasyMotion_keys='HKLYUIOPNM,QWERTZXCVBASDGJF;'
let g:EasyMotion_use_upper = 1

" Type enter and jump to first match.
" Sample: Type `dz)<CR>` and delete to first `)`
let g:EasyMotion_enter_jump_first = 1
