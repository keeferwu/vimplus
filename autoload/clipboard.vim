"=============================================================================
" clipboard.vim --- clipboard for neovim and vim8
"=============================================================================
" This script is based on kamilkrz (Kamil Krześ)'s idea about using clipboard.

if exists('g:loaded_clipboard')
  finish
endif
let g:loaded_clipboard = 1

let s:yank_cmd = ''
let s:paste_cmd = ''

function! s:clipboard_health_check()
  let result = []
  call add(result, 'Checking +clipboard:')
  if has('nvim')
    if has('clipboard')
      call add(result, 'SUCCEED!')
    else
      call add(result, 'Failed : to support +clipboard, you need has one of following clipboard tools in your $PATH:')
      call add(result, ' 1. xclip')
      call add(result, ' 2. xsel')
      call add(result, ' 3. pbcopy/pbpaste (Mac OS X)')
      call add(result, ' 4. lemonade (for SSH) https://github.com/pocke/lemonade')
      call add(result, ' 5. doitclient (for SSH) http://www.chiark.greenend.org.uk/~sgtatham/doit/')
    endif
  else
    if has('clipboard')
      call add(result, 'SUCCEED!')
    else
      call add(result, 'Failed : to support +clipboard, you need recompile your vim with +clipboard support.')
    endif
  endif
  echohl WarningMsg
  echom result
  echohl None
endfunction

function! clipboard#set() abort
  " the logic is based on nvim's clipboard provider
  " in vim8, system() do not support list argv
  call s:clipboard_health_check()
  if has('mac')
    let s:yank_cmd  = 'pbcopy'
    let s:paste_cmd = 'pbpaste'
  elseif !empty($WAYLAND_DISPLAY) && executable('wl-copy') && executable('wl-paste')
    let s:yank_cmd = 'wl-copy --foreground --type text/plain'
    let s:paste_cmd = 'wl-paste --no-newline'
  elseif !empty($DISPLAY) && executable('xclip')
    let s:yank_cmd = 'xclip -i -selection clipboard'
    let s:paste_cmd = 'xclip -o -selection clipboard'
  elseif !empty($DISPLAY) && executable('xsel')
    let s:yank_cmd = 'xsel -i -b'
    let s:paste_cmd = 'xsel -o -b'
  elseif executable('lemonade')
    let s:yank_cmd = 'lemonade copy'
    let s:paste_cmd = 'lemonade paste'
  elseif executable('doitclient')
    let s:yank_cmd = 'doitclient wclip'
    let s:paste_cmd = 'doitclient wclip -r'
  elseif executable('win32yank.exe')
    if has('wsl') && getftype(exepath('win32yank.exe')) == 'link'
      let win32yank = resolve(exepath('win32yank.exe'))
    else
      let win32yank = 'win32yank.exe'
    endif
    let s:yank_cmd = shellescape(win32yank) . ' -i --crlf'
    let s:paste_cmd = shellescape(win32yank) .  ' -o --lf'
  elseif executable('termux-clipboard-set')
    let s:yank_cmd = 'termux-clipboard-set'
    let s:paste_cmd = 'termux-clipboard-get'
  elseif !empty($TMUX) && executable('tmux')
    let s:yank_cmd = 'tmux load-buffer -'
    let s:paste_cmd = 'tmux save-buffer -'
  endif
  echohl WarningMsg
  echom '[YANK:'.string(s:yank_cmd).']'
  echom '[PASTE:'.string(s:paste_cmd).']'
  echohl None
endfunction

function! s:get_selection_text()
  let [begin, end] = [getpos("'<"), getpos("'>")]
  let lastchar = matchstr(getline(end[1])[end[2]-1 :], '.')
  if begin[1] ==# end[1]
    let lines = [getline(begin[1])[begin[2]-1 : end[2]-2]]
  else
    let lines = [getline(begin[1])[begin[2]-1 :]]
          \         + (end[1] - begin[1] <# 2 ? [] : getline(begin[1]+1, end[1]-1))
          \         + [getline(end[1])[: end[2]-2]]
  endif
  return join(lines, "\n") . lastchar . (visualmode() ==# 'V' ? "\n" : '')
endfunction

" yank to system clipboard
function! clipboard#yank() abort
  if !empty(s:yank_cmd)
    call system(s:yank_cmd, s:get_selection_text())
  else
    if has('clipboard')
      let @+ = s:get_selection_text()
    else
    endif
  endif
endfunction

" paste from system clipboard
function! clipboard#paste() abort
  if !empty(s:paste_cmd)
    let @" = system(s:paste_cmd)
  else
    if has('clipboard')
      let @" = @+
    else
    endif
  endif
endfunction
