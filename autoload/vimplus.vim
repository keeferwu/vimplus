"=============================================================================
" vimplus.vim --- highlight white space and limit buffer conter
"=============================================================================
if exists('g:loaded_vimplus')
  finish
endif
let g:loaded_vimplus = 1

function! vimplus#confirm(title, cb)
  if has('nvim')
    let text = ' '. a:title . ' (y/n)? '
    let width = min([&columns - 4, strdisplaywidth(text) + 2])
    let height = 3
    let top = ((&lines - height) / 2) - 1
    let left = (&columns - width) / 2
    let opts = {
      \ 'relative': 'editor',
      \ 'row': top,
      \ 'col': left,
      \ 'width': width,
      \ 'height': height,
      \ 'style': 'minimal',
      \ 'focusable': v:false
      \ }

    let top = "┌" . repeat("─", width - 2) . "┐"
    let mid = "│" . repeat(" ", width - 2) . "│"
    let bot = "└" . repeat("─", width - 2) . "┘"

    let lines = [top] + repeat([mid], height - 2) + [bot]
    let border_bufnr = nvim_create_buf(v:false, v:true)
    call nvim_buf_set_lines(border_bufnr, 0, -1, v:true, lines)
    call setbufvar(border_bufnr, '&buftype', "nofile")
    call setbufvar(border_bufnr, '&modifiable', 0)
    call setbufvar(border_bufnr, '&buflisted', 0)
    let s:border_winid = nvim_open_win(border_bufnr, v:true, opts)
    let opts.row += 1
    let opts.height -= 2
    let opts.col += 2
    let opts.width -= 4
    let opts.focusable = v:true
    let text_bufnr = nvim_create_buf(v:false, v:true)
    call nvim_buf_set_lines(text_bufnr, 0, -1, v:true, [text])
    call setbufvar(text_bufnr, '&buftype', "nofile")
    call setbufvar(text_bufnr, '&modifiable', 0)
    call setbufvar(text_bufnr, '&buflisted', 0)
    let text_winid = nvim_open_win(text_bufnr, v:true, opts)
    let winhl = "Normal:Pmenu"
    call setwinvar(s:border_winid, '&winhl', winhl)
    call setwinvar(text_winid, '&winhl', winhl)
    call setwinvar(s:border_winid, '&list', 0)
    call setwinvar(s:border_winid, '&number', 0)
    call setwinvar(s:border_winid, '&relativenumber', 0)
    call setwinvar(s:border_winid, '&cursorcolumn', 0)
    call setwinvar(s:border_winid, '&colorcolumn', 0)
    call setwinvar(s:border_winid, '&wrap', 1)
    au WinClosed * ++once :q | call nvim_win_close(s:border_winid, v:true)
    redraw
    while 1
      let key = nr2char(getchar())
      if key == "\<C-c>"
        let res = -1
        break
      elseif key == "\<esc>" || key == 'n' || key == 'N'
        let res = 0
        break
      elseif key == 'y' || key == 'Y' || key == "\<CR>"
        let res = 1
        break
      endif
    endw
    call nvim_win_close(text_winid, v:true)
    call timer_start(40, { -> a:cb(v:null, res) })
  elseif exists('*popup_dialog')
    try
      call popup_dialog(a:title. ' (y/n)?', {
                    \ 'highlight': 'Pmenu',
                    \ 'filter': 'popup_filter_yesno',
                    \ 'callback': {id, res -> a:cb(v:null, res)},
                    \ 'borderchars': ['─', '│', '─', '│', '┌', '┐', '┘', '└'],
                    \ 'borderhighlight': ['Pmenu']
                    \ })
    catch /.*/
      call a:cb(v:exception, 0)
    endtry
  elseif exists('*confirm')
    let choice = confirm(a:title, "&Yes\n&No")
    call a:cb(v:null, choice == 1)
  else
    echohl MoreMsg
    echom a:title.' (y/n)'
    echohl None
    let confirm = nr2char(getchar())
    redraw!
    if !(confirm ==? "y" || confirm ==? "\r")
      echohl Moremsg | echo 'Cancelled.' | echohl None
      call a:cb(v:null, 0)
    end
    call a:cb(v:null, 1)
  endif
endfunction

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
  if a:num == 0 || s:BufferReadonly()
    return
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

augroup whitespace
    autocmd!
    autocmd ColorScheme * highlight default ExtraWhitespace ctermbg=darkred guibg=darkred
    " The above flashes annoyingly while typing, be calmer in insert mode
    autocmd InsertLeave * if s:MatchWhitespace() | match none /\\\@<![\u3000[:space:]]\+$/ | endif
    autocmd InsertEnter * if s:MatchWhitespace() | match ExtraWhitespace /\\\@<![\u3000[:space:]]\+\%#\@<!$/ | endif
augroup END
