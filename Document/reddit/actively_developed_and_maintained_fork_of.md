http://www.reddit.com/r/vim/comments/1v9qyu/actively_developed_and_maintained_fork_of/



different from vim-eneak
======
I did not look at it yet, but how would you compare to justinmk's https://github.com/justinmk/vim-sneak that has mostly taken over (for me at least) that space?

[–]justinmkw 7 points 9 hours ago

@haya14busa has actually contributed a couple of very helpful bug reports to vim-sneak. And, he recently added the repeat last search with <CR> feature, which I assume was inspired by vim-sneak :)

I think of the various EasyMotion forks as "kitchen sink" motion plugins: they have tons of features like "remote yank" and "remote line moving" (use the jumplist, people!), which vim-sneak will never have. The goal for vim-sneak on the other hand is to be a very tightly-designed, reliable, complementary tool with conceptual integrity. Not a grab-bag of random features that may or may not work consistently with visual-mode, operators, count prefixes, motion-repeat, operator-repeat, etc.

The vision for vim-sneak is:

    100% bug-free (recently a lot of good bugs were reported after an influx of new users--so, working on that...)
        test suite to prevent regressions (haven't seen this in any of the easymotion forks)
    support all modes and motions consistently
    support alternate keymaps (committing this week)
    support multibyte (works in sneak "basic"; planned for streak-mode)
    extremely simple UI (only one keymap to remember, unless you also choose to map f etc)
    simple and predictable behavior: optimize for the common case
    complement existing Vim features--no gee-wiz features like "remote" operations
    get out of the way as quickly as possible
    small codebase (~500 lines vs ~2000+)

EasyMotion unfortunately has a ton complexity because of two things:

    it supports "text object" targets
    it edits the buffer temporarily to do its highlighting
        vim-sneak avoids this by using Vim's "conceal" feature, which is also much faster

Text-objects are great, but if the user wanted to use a text-object, s/he wouldn't need the motion plugin. I think the value in vim-sneak and EasyMotion is being able to jump to an arbitrary location for which no text object was appropriate. So choosing a text-object at that point is moot.
  
------

> it supports "text object" targets

I think supporting "text object" targets is good, and if users doesn't want to use easymotion as textobject (or in operator-pending mode), they can configure mapping like
  nmap s <Plug>(easymotion-s)
  xmap s <Plug>(easymotion-s)
  " omap z <Plug>(easymotion-s) " don't use easymotion in operator-pending mode

To be precise, if you want to say supporting "text object", it should support "." repeat. As far as I know vim-sneak is "." repeatable only when type two chars as target, and EasyMotion didn't implement "." repeating feature. But just yesterday I implemented "." repeatable feature with all motion type(I didn't commit yet to see how it works correctly, but I think it's fine right now).
Example:

  omap z <Plug>(easymotion-t2)
  let g:EasyMotion_keys='hklyuiopnm,qwertzxcvbasdgjf;'

`<Plug>(easymotion-t2)` is like vim's default 't' motion but can type two characters as target (z{char}{char}) inspired vim-seek/vim-sneak.
  {cursor}Lorem ipsum dolor sit ame*t,* consectetur adipisicing eli*t,* sed do eiusmod tempor

type `dzt,` and type first target marker(in this case, `h`)

  {cursor}*t,* consectetur adipisicing eli*t,* sed do eiusmod tempor

type '.'(require vim-repeat and I didn't merged into master yet)

  *t,* sed do eiusmod tempor

I think this is cool, and highly configurable in vimrc.All motion support this feature, and if you want to confine targets current line, you can use within line motion(e.g. `<Plug>(easymotion-sl)` tl,fl...)

> it edits the buffer temporarily to do its highlighting

I know that I couldn't say it's good to edits the buffer temporarily, but I carefully consider not to involve side effect and fixed some trivial bugs already. As far as I know, there aren't any side effect right now.
And I want to mention that "conceal" feature has many limitation.
I could implement more powerful feature including multibyte bug fix by allowing to edit the buffer temporarily.


[–]takac00[S] 1 point 10 hours ago

tl;dr It does everything sneak does and more.

I really dislike overwriting a existing and useful mapping, I never really got to grips with sneak. Easymotion covers all the bases and very extendable which is a great benefit.

Mapping easy motion to the space bar means you can move around the document extremely fast. If you want to move up 8 lines <Space>kh. This is actually a lot faster than using relative line numbers or thinking about how many lines up you need to move. You can do similar movements for end of lines.

    permalink
    parent
    report
    give gold
    reply

[–]justinmkw 2 points 9 hours ago

    overwriting a existing and useful mapping

You can map sneak to anything. If you just want <space> to navigate anywhere:

nmap <space> H<Plug>SneakStreak

    using relative line numbers or thinking about how many lines up you need to move

Right, if you're thinking about line numbers with vim-sneak, I guess you didn't try streak-mode :)

    permalink
    parent
    report
    give gold
    reply

[–]takac00[S] 2 points 9 hours ago

I'll take it for a spin then :)




======
Things I like:

    Bi-directional search by default
    Smart-case sensitive search is very nice
    <Plug> support is cool

Things I don't like

    Removed visual line selection aka 'vl'
    Removed yank line range aka 'dl'


> Smart-case sensitive search is very nice

Thanks. Additionaly, I implemented like smart-sign feature.

    " Smartsign
    let g:EasyMotion_use_smartsign_us = 1

If your keyboard is US layout, you can type `2` and match `2` & `@`. I think it's cool.

> Removed visual line selection aka 'vl'
> Removed yank line range aka 'dl'

I modify default mapping because `vl` and `dl` mappings are conflict with default vim's mapping.
But if you want to change back mapping `vl` & `dl`, you can configure it by vimrc

  xmap l <Plug>(easymotion-special-l)
  nmap dl <Plug>(easymotion-special-ld)
  nmap yl <Plug>(easymotion-special-ly)


> You can map sneak to anything. If you just want <space> to navigate anywhere: 
>   nmap <space> H<Plug>SneakStreak

This is clearly workaround and it ignore cursor position. My fork easymotion provide bi-directional motion considering cursor position. It's better than vim-sneak that if there are many targets, EasyMotion show marker label two key by default to type smoothly.

Additionally. It provide `<Plug>(easymotion-anywhere)` motion. This motion match start of words, end of words, start and end of line, and this matching regrex is configurable by vimrc.

Sample:

  nmap <Space><Space> <Plug>(easymotion-anywhere)


------
Thank you for your comments.

I love Lokaltog's vim-easymotion, but it seems the development has stopped and I think there are much room to improve, so I developed vim-easymotion more and more useful. If you have already know Lokaltog's vim-easymotion, you can easily move to my fork version because I carefully consider backward compatibility. All new feature is turned off by default except bi-directional motion and showing two label character feature.

So please look up `:h easymotion.txt` and configure them by your vimrc. I implemented a lot of new cool feature.

There are too many new feature to mention them all(I'll rewrite help & readme near future). I want to introduce with vimrc settings sample some of them tips especially I think it's cool.

It's different from vim-sneak, easymotion provide useful word(or regrex) motion in addition to find motion and highly configurable by vimrc.

" config leader key or turn off default mapping(recommend)
map <Leader> <Plug>(easymotion-prefix)
let g:EasyMotion_do_mapping = 0 " turn off

" bi-directional find motion
" - you can jump to anywhere with only three type `s{char}{target}`
" - `s<CR>` repeat last find motion.
" - default `s` can be replaced with `cl` but you can mapping any key you like.
nmap s <Plug>(easymotion-s)
xmap s <Plug>(easymotion-s)
omap z <Plug>(easymotion-s) " consider vim-surround mapping.

" provide `t` like motion. It's useful in operator-pending mode. (e.g. `d<Leader>z]`)
omap <Leader>t <Plug>(easymotion-s) " consider vim-surround mapping.

" if you want to type two chars as target. s{char}<CR> to use one character
map <Leader>s <Plug>(easymotion-s2)
" if you want to type `n` chars as target. s{char}{char}...<CR> to jump.
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

" Option
" smartcase
let g:EasyMotion_smartcase = 1
" Smartsign
let g:EasyMotion_use_smartsign_us = 1
" Use upper case(show label by upper case and you can type it as lower case. It improves label readability)
let g:EasyMotion_keys='HKLYUIOPNM,QWERTZXCVBASDGJF;'
let g:EasyMotion_use_upper = 1

" Type enter and jump to first match. Type `dz)<CR>` and delete to first `)`
let g:EasyMotion_enter_jump_first = 1
