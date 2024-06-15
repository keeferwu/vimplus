"=============================================================================
" vimplus.vim --- highlight white space and limit buffer conter
"=============================================================================
if exists('g:loaded_vimplus')
  finish
endif
let g:loaded_vimplus = 1

" 仅当光标处于搜索内容时高亮搜索结果
function! vimplus#hlsearch() abort
  let search_text = @/
  if search_text == ' '
    silent! call matchdelete(1219)
    return
  endif
  " 搜索内容是否能在当前buffer中搜索到结果
  if search(search_text, 'nw')
    let line_text = getline('.')
    " 清除高亮匹配项
    silent! call matchdelete(1219)
    " 当前行中第一个匹配项
    let [search_text, start_col, end_col] = matchstrpos(line_text, search_text)
    while(search_text != "")
      " 光标如果处于匹配项中，高亮匹配项
      if col('.') >= start_col && col('.') <= end_col
        silent! call matchadd('Search', search_text, 0, 1219)
        nohlsearch
      endif
      " 当前行的下一个匹配项
      let [search_text, start_col, end_col] = matchstrpos(line_text, search_text, end_col)
    endwhile
  endif
endfunction

function! s:BufferReadonly()
  if &modifiable == 0 && &filetype !=# 'startify'
    let bufname = len(bufname('%')) ? bufname('%') : &filetype 
    echohl WarningMsg
    echom bufname . " is readonly!"
    echohl None
    return 1
  endif
  return 0
endfunction

" 控制打开的buffer数量
function! vimplus#buflimit(num) abort
  if s:BufferReadonly()
    return
  endif
  if empty(a:num) || a:num == 0
    a:num = 100
  endif
  let curr_buf = bufnr("%")
  let oldest_buf = curr_buf
  let oldest_time = localtime()
  let buf_info = filter(getbufinfo(), 'buflisted(v:val.bufnr)')
  if len(buf_info) <= a:num
    return
  endif
  for buf in buf_info
    "查询最早打开的buffer
    if buf.lastused < oldest_time
      let oldest_buf = buf.bufnr
      let oldest_time = buf.lastused
    endif
  endfor
  if oldest_buf != curr_buf
    execute 'bdelete ' . oldest_buf
  endif
endfunction

" 关闭当前的buffer
function! vimplus#bufclose() abort
  if s:BufferReadonly()
    return
  endif
  if winnr('$') > 1
    execute ":only"
  endif
  execute ":bd"
endfunction

"关闭vim所有窗口并退出
function! vimplus#close() abort
  if s:BufferReadonly()
    return
  endif
  execute ":only | q"
endfunction

" Highlight EOL whitespace, https://github.com/bronson/vim-trailing-whitespace.git
if !exists('g:vimplus_whitespace_ignored_filetypes')
    let g:vimplus_whitespace_ignored_filetypes = ['startify', 'qf']
endif

function! s:MatchWhitespace()
    for ft in g:vimplus_whitespace_ignored_filetypes
        if ft ==# &filetype | return 0 | endif
    endfor
    if &buftype ==# 'terminal' | return 0 | endif
    return 1
endfunction

highlight default ExtraWhitespace ctermbg=darkred guibg=darkred
let term_open_event = (has('nvim') ? 'TermOpen' : 'TerminalOpen')

augroup whitespace
    autocmd!
    autocmd ColorScheme * highlight default ExtraWhitespace ctermbg=darkred guibg=darkred
    exe 'autocmd BufRead,BufNew,FileType,' term_open_event '* if s:MatchWhitespace() | match ExtraWhitespace /\\\@<![\u3000[:space:]]\+$/ | else | match ExtraWhitespace /^^/ | endif'
    " The above flashes annoyingly while typing, be calmer in insert mode
    autocmd InsertLeave * if s:MatchWhitespace() | match ExtraWhitespace /\\\@<![\u3000[:space:]]\+$/ | endif
    autocmd InsertEnter * if s:MatchWhitespace() | match ExtraWhitespace /\\\@<![\u3000[:space:]]\+\%#\@<!$/ | endif
augroup END
