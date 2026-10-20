"=============================================================================
" errorlog.vim --- 退出时报错日志：把一闪而过的错误信息记录到文件
"=============================================================================
" 由 vimrc 中一行 `call errorlog#start_errmsg_watch()` 触发加载（autoload
" 文件不会自我加载；同 vimplus.vim 等文件一样靠函数调用加载）。该调用启动
" v:errmsg 轮询，本文件顶层同时注册退出阶段的 autocmd：
"   1) VimLeavePre 时先记录一次快照；
"   2) 再在 VimLeavePre 期间"追加注册" VimLeave 回调，使它排在所有插件
"      的 VimLeave 回调之后执行，从而捕获整个退出阶段产生的报错；
"   3) 内容重复时只记录一次，避免 VimLeavePre/VimLeave 重复写入。
augroup vimplus_exit_log
  autocmd!
  autocmd VimLeavePre * call errorlog#log_exit_errors()
  autocmd VimLeavePre * ++once autocmd vimplus_exit_log VimLeave * call errorlog#log_exit_errors()
augroup END

" 判断某行是否为错误信息的首行
function! s:IsExitErrorLine(line) abort
  return a:line =~# '^\s*E\d\+[: ]'
        \ || a:line =~# '^\s*[NW]\d\+[: ]'
        \ || a:line =~# '^line\s\+\d\+:'
        \ || a:line =~# '\c\<error\>'
        \ || a:line =~# '\c\<exception\>'
        \ || a:line =~# '\c\<traceback\>'
        \ || a:line =~# '\c\<fail\(ed\|ing\|s\)\?\>'
        \ || a:line =~# '\v\.(lua|vim|py):\d+:'
        \ || a:line =~# '\c\<no such file\>'
        \ || a:line =~# '\c\<cannot\>'
endfunction

" 判断某行是否为错误信息的延续行（缩进的堆栈、"line N:" 上下文等）
function! s:IsExitErrorContinuation(line) abort
  return a:line =~# '^\s\+\S'
        \ || a:line =~# '^line\s\+\d\+:'
endfunction

" 从 :messages 输出中提取错误行及其上下文（含 stack traceback）
function! s:ExtractExitErrors(text) abort
  let l:result = []
  let l:capture = 0
  for l:line in split(a:text, "\n", 1)
    if s:IsExitErrorLine(l:line)
      let l:capture = 1
      call add(l:result, l:line)
    elseif l:capture && s:IsExitErrorContinuation(l:line)
      call add(l:result, l:line)
    else
      let l:capture = 0
    endif
  endfor
  return l:result
endfunction

" 会话内"全量"静默错误采集：v:errmsg 是粘滞变量，只保留最后一次错误（silent!/silent
" 吞掉显示的也会写进去），只在退出时读它只会看到最后一条。这里用定时器周期性地
" 读取并收集中途出现过的每条不同错误，退出时一并落盘。只读取、不清空、不过滤。
let s:seen_errmsgs = []
let s:errmsg_timer = -1
let s:last_exit_errors = ''

" 采集一次当前 v:errmsg（定时器回调）
function! errorlog#poll_errmsg(...) abort
  if empty(v:errmsg)
    return
  endif
  if index(s:seen_errmsgs, v:errmsg) < 0
    call add(s:seen_errmsgs, v:errmsg)
  endif
endfunction

" 启动轮询（vimrc 加载时调用，顺带加载本文件；退出阶段不停止，以捕获退出过程中的报错）
function! errorlog#start_errmsg_watch() abort
  if !exists('*timer_start')
    return
  endif
  if s:errmsg_timer != -1 && !empty(timer_info(s:errmsg_timer))
    return
  endif
  let s:errmsg_timer = timer_start(200, function('errorlog#poll_errmsg'), {'repeat': -1})
endfunction

" 返回本次会话采集到的全部 v:errmsg（按出现顺序）
function! errorlog#seen_errmsgs() abort
  return copy(s:seen_errmsgs)
endfunction

" 返回日志文件路径，可通过 g:vimplus_error_log 覆盖
function! errorlog#exit_error_log() abort
  return get(g:, 'vimplus_error_log', expand('~/.vim/.cache/exit-errors.log'))
endfunction

" 退出阶段调用：把当前会话捕获到的错误追加写入日志
function! errorlog#log_exit_errors() abort
  try
    " 1. 抓取整个消息历史，过滤出错误行及其上下文
    let l:errors = []
    try
      let l:messages = execute('messages')
    catch
      let l:messages = ''
    endtry
    if !empty(l:messages)
      let l:errors = s:ExtractExitErrors(l:messages)
    endif

    " 2. 追加本会话轮询到的所有静默错误（可能已被后到的错误覆盖，只有轮询留得下来），
    "    按出现顺序、去重、不过滤。l:blob 增量维护，避免循环内反复 join 整个列表
    let l:blob = join(l:errors, "\n")
    for l:msg in s:seen_errmsgs
      if stridx(l:blob, l:msg) < 0
        let l:line = 'v:errmsg: ' . l:msg
        call add(l:errors, l:line)
        let l:blob .= "\n" . l:line
      endif
    endfor

    " 3. 补充最后一次错误信息 v:errmsg（可能出现在最后一次轮询之后）
    if !empty(v:errmsg) && stridx(l:blob, v:errmsg) < 0
      call add(l:errors, 'v:errmsg: ' . v:errmsg)
    endif
    if empty(l:errors)
      return
    endif

    " 4. VimLeavePre 与 VimLeave 内容相同时只记录一次
    let l:content = join(l:errors, "\n")
    if s:last_exit_errors ==# l:content
      return
    endif
    let s:last_exit_errors = l:content

    " 5. 写入日志
    let l:log = errorlog#exit_error_log()
    let l:dir = fnamemodify(l:log, ':h')
    if !isdirectory(l:dir)
      call mkdir(l:dir, 'p')
    endif
    " 超过 1MB 时滚动备份，避免日志无限增长
    if getfsize(l:log) > 1024 * 1024
      call rename(l:log, l:log . '.old')
    endif

    let l:head = get(filter(split(execute('version'), "\n", 1), 'v:val !=# ""'), 0, 'vim/nvim')
    let l:lines = [repeat('=', 78)]
    call add(l:lines, printf('[%s] %s  pid=%d  cwd=%s',
          \ strftime('%Y-%m-%d %H:%M:%S'), l:head, getpid(), getcwd()))
    call extend(l:lines, l:errors)
    call add(l:lines, '')
    call writefile(l:lines, l:log, 'a')
  catch
    " 退出阶段的日志记录失败不应影响正常退出
  endtry
endfunction
