"=============================================================================
" vimplus.vim --- highlight white space and limit buffer conter
"=============================================================================
if exists('g:loaded_vimplus')
  finish
endif
let g:loaded_vimplus = 1

function! vimplus#confirm(title, cb) abort
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

function! vimplus#ignoredbuffer(bufnr) abort
  let file_type = getbufvar(a:bufnr, '&filetype')
  let buf_type = getbufvar(a:bufnr, '&buftype')
  if buf_type ==# 'terminal' || buf_type ==# 'nofile'
    return v:true
  endif
  for ft in get(g:, 'vimplus_ignored_filetypes', 'qf')
    if ft ==# file_type | return v:true | endif
  endfor
  return v:false
endfunction

function! vimplus#holdtimer(time, cmd) abort
  " 定义一个字典来存储定时器ID，键为定时器的触发时间
  if !exists("s:vimplus_timer")
    let s:vimplus_timer = {}
  endif
  " 检查是否已经有一个定时器与这个时间关联
  if has_key(s:vimplus_timer, a:time)
    " 如果存在，停止该定时器
    call timer_stop(s:vimplus_timer[a:time])
    " 从字典中删除该定时器的键
    unlet s:vimplus_timer[a:time]
  endif
  if !vimplus#ignoredbuffer('%')
    " 启动一个新的定时器，并将其ID存储在字典中
    let s:vimplus_timer[a:time] = timer_start(a:time, { -> execute(a:cmd)})
  endif
endfunction

function! s:VisualPattern()
  try
    let x_save = getreg("x", 1)
    let type = getregtype("x")
    norm! gv"xy
    return escape(@x, '\"')
  finally
    call setreg("x", x_save, type)
  endtry
endfunction

function! vimplus#vimgrep(mode) abort
  if a:mode == 'n'
      let pattern = expand('<cword>')
  endif
  if a:mode == 'v'
      let pattern = s:VisualPattern()
  endif
  execute 'silent! vimgrep ' . pattern . ' % | bot copen'
  hi QuickFixLine ctermbg=NONE guibg=NONE
  silent! call matchdelete(1223)
  call matchadd('MatchParen', pattern, 0, 1223)
endfunction

" 仅当光标处于搜索内容时高亮搜索结果
function! vimplus#hlsearch() abort
  let search_text = @/
 "文件超过10000行不生效
  if empty(search_text) || line("$") > 10000
    return
  endif
  if search_text == ' '
    let @/ = ''
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
        silent! call matchadd('CurSearch', search_text, 0, 1219)
        nohlsearch
      endif
      " 当前行的下一个匹配项
      let [search_text, start_col, end_col] = matchstrpos(line_text, search_text, end_col)
    endwhile
  endif
endfunction

"expand("%")     ---- 相对路径文件
"expand("%:h")   ---- 相对路径
"expand("%:p")   ---- 绝对路径文件
"expand("%:p:h") ---- 绝对路径
"expand("%:r")   ---- 相对路径文件（不含后缀）
"expand("%:e")   ---- 文件后缀
function! s:GetInputFile()
  try
    echohl Question
    call inputsave()
    let filename = input("Input file: ", "", "file")
    call inputrestore()
    redraw!
  catch /^Vim:Interrupt$/
    echo "Command interrupted"
  finally
    echohl None
    " interrupt will cause filename unlet
    if !exists("filename")
      return
    endif
    " remove spaces
    return substitute(filename, ' ', '', 'g')
  endtry
endfunction

function! vimplus#differ() abort
  let filename = s:GetInputFile()
  if empty(fnamemodify(filename, ':t'))
    echo "Empty file name!"
    return
  endif
  if !filereadable(filename)
    echo filename . " not exists!"
    return
  endif
  execute 'vertical diffsplit' filename
endfunction

function! vimplus#write() abort
  try
    " 如果不是普通模式，则切换到普通模式
    if mode() != 'n'
       call feedkeys("\<Esc>")
    endif
    " 尝试正常写入文件
    execute 'write'
  catch /^Vim\%((\a\+)\)\=:E212/
    " 如果捕获到 E212 错误，使用 sudo 写入文件
    execute 'write !sudo tee -i %'
  endtry
endfunction

" 控制打开的buffer数量
function! vimplus#buflimit(num) abort
  if &modifiable == 0 || a:num == 0
    return
  endif
  let last_buf = bufnr("%")
  let first_buf = last_buf
  let first_used = localtime()
  let buf_info = filter(getbufinfo(), 'buflisted(v:val.bufnr)')
  if len(buf_info) <= a:num
    return
  endif
  for buf in buf_info
    "查询最早打开的buffer
    if buf.lastused < first_used
      let first_buf = buf.bufnr
      let first_used = buf.lastused
    endif
  endfor
  if first_buf != last_buf
    execute 'bdelete ' . first_buf
  endif
endfunction

" 关闭quickfix
function! vimplus#qfclose() abort
  lclose
  cclose
  call setqflist([], 'f')
  return
endfunction

" 关闭当前显示的buffer
function! vimplus#bufclose() abort
  let last_win = winnr('$')
  execute last_win . 'wincmd w'
  if &filetype ==# 'VimspectorPrompt'
    " lasted window is vimspectorPrompt do nothing
    echo "vimspector can not be deleted by bufclose"
    return
  endif
  let buf_list = uniq(sort(tabpagebuflist()))
  for buf in buf_list
    execute "bdelete! " . buf
  endfor
endfunction

" 关闭当前的tab
function! vimplus#tabclose() abort
  let curr_tab = tabpagenr()
  if curr_tab > 1
    let last_win = winnr('$')
    execute last_win . 'wincmd w'
    if &filetype ==# 'VimspectorPrompt'
      " lasted window is vimspectorPrompt do nothing
      echo "vimspector can not be deleted by tabclose"
      return
    endif
    let buf_list = uniq(sort(tabpagebuflist()))
    for buf in buf_list
      if vimplus#ignoredbuffer(buf)
        execute "bdelete! " . buf
      endif
    endfor
    if curr_tab == tabpagenr()
      execute "tabclose"
    endif
  endif
endfunction

"关闭vim所有窗口并退出
function! vimplus#vimclose() abort
  " tab counter
  if tabpagenr('$') > 1
    execute "tabfirst"
    execute "tabonly"
  endif
  let buf_list = uniq(sort(tabpagebuflist()))
  for buf in buf_list
    if vimplus#ignoredbuffer(buf)
      execute "bdelete! " . buf
    endif
  endfor
  execute "qall"
endfunction

augroup bufferkey
  autocmd!
  " 在 quickfix 窗口中按回车跳转，但保持光标在 quickfix 窗口
  autocmd FileType qf nnoremap <silent> <buffer> <cr> <cr>:wincmd p<cr>
  autocmd FileType qf,netrw nnoremap <silent> <buffer> q :close<cr>
augroup END

" Highlight EOL whitespace, https://github.com/bronson/vim-trailing-whitespace.git
augroup whitespace
  autocmd!
  highlight default ExtraWhitespace ctermbg=darkred guibg=darkred
  " The above flashes annoyingly while typing, be calmer in insert mode
  autocmd InsertLeave * if !vimplus#ignoredbuffer('%') | match none /\\\@<![\u3000[:space:]]\+$/ | endif
  autocmd InsertEnter * if !vimplus#ignoredbuffer('%') | match ExtraWhitespace /\\\@<![\u3000[:space:]]\+\%#\@<!$/ | endif
augroup END

function! s:IndentChange(line1,line2,type)
  let indenttype = &expandtab
  " 0:tab, 1:space,
  if indenttype && a:type == "Tab"
    execute "set noexpandtab"
  endif
  if !indenttype && a:type == "Space"
    execute "set expandtab"
  endif
  execute a:line1.",".a:line2."%retab!"
  execute indenttype ? "set expandtab" : "set noexpandtab"
endfunction
" 在选中模式下使用快捷键映射TabIndent和SpaceIndent，会导致选中的每一行都会调用命令，影响性能
command! -range=% TabIndent call <SID>IndentChange(<line1>,<line2>,"Tab")
command! -range=% SpaceIndent call <SID>IndentChange(<line1>,<line2>,"Space")
