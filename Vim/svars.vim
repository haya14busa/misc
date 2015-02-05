let s:V = vital#of('vital')
let s:S = s:V.import('Vim.Snoop')

let s:GETSFUNCNAME = '___GET_S___' . localtime()

let s:_get_s_func = [
\   printf('function! s:%s() abort', s:GETSFUNCNAME),
\   '    return s:',
\   'endfunction',
\ ]

function! s:svars(path) abort
    let sid = s:S.sid(a:path)
    let fullpath = expand(s:S.scriptnames()[sid])
    let lines = readfile(fullpath)
    try
        call writefile(s:_get_s_func, fullpath)
        execute 'source' fullpath
        let s = s:S.sid2sfuncs(sid)[s:GETSFUNCNAME]()
        execute 'delfunction' printf("\<SNR>%d_%s", sid, s:GETSFUNCNAME)
        return s
    finally
        call writefile(lines, fullpath)
    endtry
endfunction

echo PP(s:svars('autoload/incsearch/util.vim'))

