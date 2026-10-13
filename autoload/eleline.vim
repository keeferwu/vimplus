" =============================================================================
" Filename: eleline.vim
" Author: Liu-Cheng Xu
" URL: https://github.com/liuchengxu/eleline.vim
" License: MIT License
" =============================================================================
scriptencoding utf-8
if exists('g:loaded_eleline') || v:version < 700
  finish
endif
let g:loaded_eleline = 1

let s:save_cpo = &cpoptions
set cpoptions&vim

let s:font = get(g:, 'eleline_powerline_fonts', 1)
let s:fn_icon = get(g:, 'eleline_function_icon', '')
let s:gui = has('gui_running')
let s:is_win = has('win32')
let s:git_branch_cmd = add(s:is_win ? ['cmd', '/c'] : ['bash', '-c'], 'git branch')
let s:git_branch_symbol = s:font ? "  \ue0a0" : '  Git'
let s:codeium_symbol = s:font ? " \U1F4BB" : ' Ai'
let s:jobs = {}

function! ElelineBufnrWinnr() abort
  let l:bufnr = bufnr('%')
  if !s:gui
    " transform to circled num: nr2char(9311 + l:bufnr)
    let l:bufnr = l:bufnr > 0 ? l:bufnr : nr2char(9311 + l:bufnr).' '
  endif
"  let mode = get(s:mode_map, mode(), '')
  let mode = win_gettype() == "preview" ? 'Preview' :
		   \ &filetype == "nerdtree" ? 'NERDTree' :
		   \ &filetype == "netrw" ? 'Netrw' :
		   \ &filetype == "defx" ? 'Defx' :
		   \ &filetype == "tagbar" ? 'Tagbar' :
		   \ &filetype == "qf" ? 'Quickfix' :
		   \ get(s:mode_map, mode(), '')
  return '  '.mode.'❖ '.l:bufnr.' '
endfunction

function! ElelineTotalBuf() abort
  return '[TOT:'.len(filter(range(1, bufnr('$')), 'buflisted(v:val)')).']'
endfunction

function! ElelinePaste() abort
  return &paste ? '[P] ' : ''
endfunction

function! ElelineFsize(f) abort
  let l:size = getfsize(expand(a:f))
  if l:size == 0 || l:size == -1 || l:size == -2
    return ''
  endif
  if l:size < 1024
    let size = l:size.' bytes'
  elseif l:size < 1024*1024
    let size = printf('%.1f', l:size/1024.0).'k'
  elseif l:size < 1024*1024*1024
    let size = printf('%.1f', l:size/1024.0/1024.0) . 'm'
  else
    let size = printf('%.1f', l:size/1024.0/1024.0/1024.0) . 'g'
  endif
  return '  '.size.' '
endfunction

function! ElelineCurFname() abort
  if !exists('g:relative_path_file')
	let g:relative_path_file = 1
  endif
  if g:relative_path_file == 0
	return &filetype ==# 'startify' ? '' : '  '.expand('%:p:t').' '
  else
	return &filetype ==# 'startify' ? '' : '  '.expand('%:f').' '
  endif
endfunction

function! ElelineError() abort
  if exists('g:loaded_ale') && get(g:, 'ale_enabled', 1)
    let s:ale_counts = ale#statusline#Count(bufnr(''))
    return s:ale_counts[0] == 0 ? '' : '•'.s:ale_counts[0].' '
  elseif exists('b:clap_diagnostics')
      let error_count = b:clap_diagnostics.error
    return error_count == 0 ? '' : '•'.error_count.' '
  endif
  return ''
endfunction

function! ElelineWarning() abort
  if exists('g:loaded_ale') && get(g:, 'ale_enabled', 1)
    " Ensure ElelineWarning() is called after ElelineError() so that s:ale_counts can be reused.
    return s:ale_counts[1] == 0 ? '' : '•'.s:ale_counts[1].' '
  elseif exists('b:clap_diagnostics')
    let warn_count = b:clap_diagnostics.warn
    return warn_count == 0 ? '' : '•'.warn_count.' '
  endif
  return ''
endfunction

function! s:is_tmp_file() abort
  return !empty(&buftype)
        \ || index(['startify', 'gitcommit', 'defx', 'vista', 'vista_kind', 'qf', 'tagbar', 'nerdtree', 'netrw'], &filetype) > -1
        \ || expand('%:p') =~# '^/tmp'
endfunction

function! s:GetGitBranchName(...) abort
  if exists('*FugitiveExtractGitDir')
    return
  endif
  if s:is_tmp_file()
    return
  endif
  "let l:file_path = expand('%:p:h')
  let l:file_path = fnamemodify(bufname('%'), ':p:h')
  if s:is_win
    let l:file_path = substitute(l:file_path, '\', '/', 'g')
  endif
  " not a dir
  if !isdirectory(l:file_path)
    return
  endif
  " find git dir
  let l:git_dir = finddir('.git', l:file_path . ';')
  if empty(l:git_dir)
    return
  endif
  " get current buffer git branch
  let l:git_branch = system('git -C ' . shellescape(l:file_path) . ' rev-parse --abbrev-ref HEAD')
  " remove line breaks from the output message
  let l:branch_name = substitute(l:git_branch, '\n\+$', '', '')
  " string starting with 'fatal:' or end with 'HEAD'
  if l:branch_name =~? '^fatal:' || l:branch_name =~? 'HEAD$'
    return
  endif
  call setbufvar(bufnr('%'), 'eleline_branch', s:git_branch_symbol.':'.l:branch_name)
endfunction

" Reference: https://github.com/chemzqm/vimrc/blob/master/statusline.vim
function! ElelineGitBranch(...) abort
  if s:is_tmp_file()
    return ''
  endif
  let reload = get(a:, 1, 0) == 1
  if exists('b:eleline_branch') && !reload
    return b:eleline_branch
  endif
  if !exists('*FugitiveExtractGitDir')
    return ''
  endif
  let dir = exists('b:git_dir') ? b:git_dir : FugitiveExtractGitDir(resolve(expand('%:p')))
  if empty(dir)
    return ''
  endif
  let b:git_dir = dir
  let roots = values(s:jobs)
  let root = fnamemodify(dir, ':h')
  if index(roots, root) >= 0
    return ''
  endif

  if exists('*job_start')
    let job = job_start(s:git_branch_cmd, {'out_io': 'pipe', 'err_io':'null',  'out_cb': function('s:out_cb')})
    if job_status(job) ==# 'fail'
      return ''
    endif
    let s:cwd = root
    let job_id = ch_info(job_getchannel(job))['id']
    let s:jobs[job_id] = root
  elseif exists('*jobstart')
    let job_id = jobstart(s:git_branch_cmd, {
      \ 'cwd': root,
      \ 'stdout_buffered': v:true,
      \ 'stderr_buffered': v:true,
      \ 'on_exit': function('s:on_exit')
      \})
    if job_id == 0 || job_id == -1
      return ''
    endif
    let s:jobs[job_id] = root
  elseif exists('g:loaded_fugitive')
    let l:head = fugitive#head()
    return empty(l:head) ? '' : s:git_branch_symbol.':'.l:head.' '
  endif

  return ''
endfunction

function! s:out_cb(channel, message) abort
  if a:message =~# '^* '
    let l:job_id = ch_info(a:channel)['id']
    if !has_key(s:jobs, l:job_id)
      return
    endif
    let l:branch = substitute(a:message, '*', s:git_branch_symbol.':', '')
    call s:SetGitBranch(s:cwd, l:branch.' ')
    call remove(s:jobs, l:job_id)
  endif
endfunction

function! s:on_exit(job_id, data, _event) dict abort
  if !has_key(s:jobs, a:job_id) || !has_key(self, 'stdout')
    return
  endif
  if v:dying
    return
  endif
  let l:cur_branch = join(filter(self.stdout, 'v:val =~# "*"'))
  if !empty(l:cur_branch)
    let l:branch = substitute(l:cur_branch, '*', s:git_branch_symbol.':', '')
    call s:SetGitBranch(self.cwd, l:branch.' ')
  else
    let err = join(self.stderr)
    if !empty(err)
      echoerr err
    endif
  endif
  call remove(s:jobs, a:job_id)
endfunction

function! s:SetGitBranch(root, str) abort
  let buf_list = filter(range(1, bufnr('$')), 'bufexists(v:val)')
  let root = s:is_win ? substitute(a:root, '\', '/', 'g') : a:root
  for nr in buf_list
    let path = fnamemodify(bufname(nr), ':p')
    if s:is_win
      let path = substitute(path, '\', '/', 'g')
    endif
    if match(path, root) >= 0
      call setbufvar(nr, 'eleline_branch', a:str)
    endif
  endfor
  redraws!
endfunction

function! ElelineGitStatus() abort
  if exists('b:sy.stats')
    let l:summary = b:sy.stats
  elseif exists('b:clap_git.summary')
    let l:summary = b:clap_git.summary
  elseif exists('b:gitgutter.summary')
    let l:summary = b:gitgutter.summary
  else
    let l:summary = [0, 0, 0]
  endif
  if max(l:summary) > 0
    return ' +'.l:summary[0].' ~'.l:summary[1].' -'.l:summary[2].' '
  elseif !empty(get(b:, 'coc_git_status', ''))
    return ' '.b:coc_git_status.' '
  endif
  return ''
endfunction

function! ElelineFunction() abort
  let l:function = ''
  if !empty(get(b:, 'clap_current_symbol', ''))
    if empty(b:clap_current_symbol.scope)
      return printf('%s %s', b:clap_current_symbol.kind_icon, b:clap_current_symbol.name)
    else
      let scope = b:clap_current_symbol.scope
      return printf('%s %s > %s %s', scope.scope_kind_icon, scope.name, b:clap_current_symbol.kind_icon, b:clap_current_symbol.name)
    endif
  elseif get(g:, 'coc_enabled', 0) && !empty(get(b:,'coc_current_function',''))
    let l:function = b:coc_current_function
  elseif !empty(get(b:, 'vista_nearest_method_or_function', ''))
    let l:function = b:vista_nearest_method_or_function
  elseif has('nvim-0.5') && !s:is_tmp_file() && luaeval('pcall(require, "lsp-status")') && luaeval('#vim.lsp.buf_get_clients() > 0')
    let l:function = luaeval("require('lsp-status').status()")
  elseif exists(':Tagbar')
    let l:function = tagbar#currenttag('%s', '')
  else
    let l:funcline = getline(search("^[^ \t#/]\\{2}.*[^:]\s*$", 'bnW'))
    let l:function = strpart(l:funcline,0,match(l:funcline,'('))
  endif
  return !empty(l:function) ? s:fn_icon.l:function : ''
endfunction

function! ElelineCoc() abort
  if s:is_tmp_file()
    return ''
  endif
  if get(g:, 'coc_enabled', 0)
    return coc#status().' '
  endif
  return ''
endfunction

function! CodeiumStatus() abort
  if s:is_tmp_file()
    return ''
  endif
  if exists('g:loaded_codeium')
    return s:codeium_symbol.':'.codeium#GetStatusString()
  endif
  return ''
endfunction

function! GutentagsStatus() abort
  if s:is_tmp_file()
    return ''
  endif
  if exists('b:gutentags_files')
    return gutentags#statusline()
  endif
  if exists('g:leaderf_loaded')
    return leaderf#Gtags#statusline()
  endif
  return ''
endfunction

function! s:def(fn) abort
  return printf('%%#%s#%%{%s()}%%*', a:fn, a:fn)
endfunction

" https://github.com/liuchengxu/eleline.vim/wiki
function! s:StatusLine() abort
  let l:bufnr_winnr = s:def('ElelineBufnrWinnr')
  let l:paste = s:def('ElelinePaste')
  let l:curfname = s:def('ElelineCurFname')
  let l:branch = s:def('ElelineGitBranch')
  let l:status = s:def('ElelineGitStatus')
  let l:error = s:def('ElelineError')
  let l:warning = s:def('ElelineWarning')
  let l:tags = ' %{GutentagsStatus()} '
  let l:coc = '%{ElelineCoc()}'
  let l:codeium = '%{CodeiumStatus()}'
  let l:func = '%#ElelineFunction#%{ElelineFunction()}%*'
  let l:prefix = l:bufnr_winnr.l:paste
  let l:common = l:curfname.'%='.l:func.'%='.l:branch.l:error.l:warning.l:tags.l:coc.l:codeium
  if &buftype == "quickfix"
	return l:bufnr_winnr.'%='.'%l/%L'
  endif
  if get(g:, 'eleline_slim', 0) || win_gettype() == "preview"
    return l:prefix.'%<'.l:common
  endif
  let l:tot = s:def('ElelineTotalBuf')
  "let l:fsize = '%#ElelineFsize#%{ElelineFsize(@%)}%*'
  let l:m_r_f = '%#Eleline7# %m%r%y %*'
  let l:pos = '%#Eleline8# '.(s:font?"\ue0a1":'').'%l/%L:%03c '
  let l:enc = '%#Eleline7#| %{&fenc != "" ? &fenc : &enc} | %{&bomb ? ",BOM " : ""}'
  let l:ff = '%#Eleline7#%{&ff} %*'
  let l:pct = '%#Eleline9# %P %*'
  return l:prefix.'%<'.l:common.l:m_r_f.l:enc.l:ff.l:pos.l:pct.l:tot
endfunction

let s:mode_map = {
		    \ 'n' : 'NORMAL',
		    \ 'i' : 'INSERT',
		    \ 'R' : 'REPLACE',
		    \ 'v' : 'VISUAL',
		    \ 'V' : 'V-LINE',
		    \ "\<C-v>": 'V-BLOCK',
		    \ 'c' : 'COMMAND',
		    \ 's' : 'SELECT',
		    \ 'S' : 'S-LINE',
		    \ "\<C-s>": 'S-BLOCK',
		    \ 't': 'TERMINAL',
		    \ }

let s:colors = {
            \   140 : '#af87d7', 149 : '#99cc66', 160 : '#d70000',
            \   171 : '#d75fd7', 178 : '#ffbb7d', 184 : '#ffe920',
            \   208 : '#ff8700', 232 : '#333300', 197 : '#cc0033',
            \   214 : '#ffff66', 124 : '#af3a03', 172 : '#b57614',
            \   32  : '#3a81c3', 89  : '#6c3163',
            \
            \   235 : '#262626', 236 : '#303030', 237 : '#3a3a3a',
            \   238 : '#444444', 239 : '#4e4e4e', 240 : '#585858',
            \   241 : '#606060', 242 : '#666666', 243 : '#767676',
            \   244 : '#808080', 245 : '#8a8a8a', 246 : '#949494',
            \   247 : '#9e9e9e', 248 : '#a8a8a8', 249 : '#b2b2b2',
            \   250 : '#bcbcbc', 251 : '#c6c6c6', 252 : '#d0d0d0',
            \   253 : '#dadada', 254 : '#e4e4e4', 255 : '#eeeeee',
            \ }

function! s:extract(group, what, ...) abort
  if a:0 == 1
    return synIDattr(synIDtrans(hlID(a:group)), a:what, a:1)
  else
    return synIDattr(synIDtrans(hlID(a:group)), a:what)
  endif
endfunction

if !exists('g:eleline_background')
  let s:normal_bg = s:extract('Normal', 'bg', 'cterm')
  if s:normal_bg >= 233 && s:normal_bg <= 243
    let s:bg = s:normal_bg
  else
    let s:bg = 235
  endif
else
  let s:bg = g:eleline_background
endif

" Don't change in gui mode
if has('termguicolors') && &termguicolors
  let s:bg = 235
endif

function! s:hi(group, dark, light, ...) abort
  let [fg, bg] = &background ==# 'dark' ? a:dark : a:light

  if empty(bg)
    if &background ==# 'light'
      let reverse = s:extract('StatusLine', 'reverse')
      let ctermbg = s:extract('StatusLine', reverse ? 'fg' : 'bg', 'cterm')
      let ctermbg = empty(ctermbg) ? 237 : ctermbg
      let guibg = s:extract('StatusLine', reverse ? 'fg': 'bg' , 'gui')
      let guibg = empty(guibg) ? s:colors[237] : guibg
    else
      let ctermbg = bg
      let guibg = s:colors[bg]
    endif
  else
    let ctermbg = bg
    let guibg = s:colors[bg]
  endif
  execute printf('hi %s ctermfg=%d guifg=%s ctermbg=%d guibg=%s',
                \ a:group, fg, s:colors[fg], ctermbg, guibg)
  if a:0 == 1
    execute printf('hi %s cterm=%s gui=%s', a:group, a:1, a:1)
  endif
endfunction

function! s:hi_statusline() abort
  call s:hi('ElelineBufnrWinnr' , [232 , 178]    , [89 , '']  )
  call s:hi('ElelineTotalBuf'   , [178 , s:bg+8] , [240 , ''] )
  call s:hi('ElelinePaste'      , [232 , 178]    , [232 , 178]    , 'bold')
  call s:hi('ElelineFsize'      , [250 , s:bg+6] , [235 , ''] )
  call s:hi('ElelineCurFname'   , [171 , s:bg+4] , [171 , '']     , 'bold' )
  call s:hi('ElelineGitBranch'  , [208 , s:bg+2] , [89  , '']     , 'bold' )
  call s:hi('ElelineGitStatus'  , [184 , s:bg+2] , [89  , ''])
  call s:hi('ElelineError'      , [197 , s:bg+2] , [197 , ''])
  call s:hi('ElelineWarning'    , [214 , s:bg+2] , [214 , ''])
  call s:hi('ElelineFunction'   , [149 , s:bg+2] , [149 , ''])

  if &background ==# 'dark'
    call s:hi('StatusLine' , [140 , s:bg+2], [140, ''] , 'none')
  endif

  call s:hi('Eleline7'      , [249 , s:bg+3], [237, ''] )
  call s:hi('Eleline8'      , [250 , s:bg+4], [238, ''] )
  call s:hi('Eleline9'      , [251 , s:bg+5], [239, ''] )
endfunction

function! s:InsertStatuslineColor(mode) abort
  if a:mode ==# 'i'
    call s:hi('ElelineBufnrWinnr' , [251, s:bg+8] , [251, s:bg+8])
  elseif a:mode ==# 'r'
    call s:hi('ElelineBufnrWinnr' , [232, 160], [232, 160])
  else
    call s:hi('ElelineBufnrWinnr' , [232, 178], [89, ''])
  endif
endfunction

function! s:SpecificWinLine() abort
  let l:bufnr_winnr = s:def('ElelineBufnrWinnr')
  if &filetype == "qf"
	let &l:statusline = l:bufnr_winnr."%{exists('w:quickfix_title')? '  '.w:quickfix_title : ''} %=%l/%L"
  endif
  if &filetype == "tagbar"
	let &l:statusline = l:bufnr_winnr.'%=%l/%L'
  endif
  if &filetype == "nerdtree" || &filetype == "netrw" || &filetype == "defx"
	let l:curfname = s:def('ElelineCurFname')
	let &l:statusline = l:bufnr_winnr.l:curfname
  endif
endfunction

" Note that the "%!" expression is evaluated in the context of the
" current window and buffer, while %{} items are evaluated in the
" context of the window that the statusline belongs to.
function! s:SetStatusLine(...) abort
  call ElelineGitBranch(1)
  let &l:statusline = s:StatusLine()
  " User-defined highlightings should be put after colorscheme command.
  call s:hi_statusline()
endfunction

function! eleline#setup() abort
  if exists('*timer_start')
    call timer_start(100, function('s:SetStatusLine'))
  else
    call s:SetStatusLine()
  endif
endfunction

augroup eleline
  autocmd!
  autocmd User GitGutter,Startified,LanguageClientStarted call s:SetStatusLine()
  " Change colors for insert mode
  autocmd InsertLeave * call s:hi('ElelineBufnrWinnr', [232, 178], [89, ''])
  autocmd InsertEnter,InsertChange * call s:InsertStatuslineColor(v:insertmode)
  autocmd BufWinEnter,ShellCmdPost,BufWritePost * call s:SetStatusLine()
  autocmd FileChangedShellPost,ColorScheme * call s:SetStatusLine()
  autocmd FileReadPre,ShellCmdPost,FileWritePost * call s:SetStatusLine()
  autocmd FileType qf,netrw,nerdtree,defx,tagbar call s:SpecificWinLine()
  autocmd WinEnter,BufEnter * call s:GetGitBranchName()
augroup END

let &cpoptions = s:save_cpo
unlet s:save_cpo
