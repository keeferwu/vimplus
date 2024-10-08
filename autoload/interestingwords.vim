" --------------------------------------------------------------------
" This plugin was inspired and based on lfv89/vim-interestingwords
" highlights the occurrences of the word under the cursor throughout the buffer.
" Different words can be highlighted at the same time.
" The plugin also enables one to navigate through the highlighted words in the buffer just like one would through the results of a search.
" --------------------------------------------------------------------

let s:interestingWordsGUIColors = ['#aeee00', '#ff0000', '#0000ff', '#b88823', '#ffa724', '#ff2c4b']
let s:interestingWordsTermColors = ['121', '154', '139', '203', '212', '222']

let g:interestingWordsGUIColors = exists('g:interestingWordsGUIColors') ? g:interestingWordsGUIColors : s:interestingWordsGUIColors
let g:interestingWordsTermColors = exists('g:interestingWordsTermColors') ? g:interestingWordsTermColors : s:interestingWordsTermColors
let g:interestingWordsCycleColors = get(g:, 'interestingWordsCycleColors', 1)
let g:interestingWordsCaseSensitive = get(g:, 'interestingWordsCaseSensitive', 1)
let g:interestingWordsRandomiseColors = get(g:, 'interestingWordsRandomiseColors', 0)

let s:hasBuiltColors = 0
let s:interestingWords = []
let s:interestingModes = []
let s:mids = {}
let s:recentlyUsed = []

function! s:ColorWord(word, mode)
  if !(s:hasBuiltColors)
    call s:BuildColors()
  endif

  " gets the lowest unused index
  let n = index(s:interestingWords, 0)
  if (n == -1)
    if !g:interestingWordsCycleColors
      echom "InterestingWords: max number of highlight groups reached " . len(s:interestingWords)
      return
    else
      let n = s:recentlyUsed[0]
      call s:UncolorWord(s:interestingWords[n])
    endif
  endif

  let mid = 595129 + n
  let s:interestingWords[n] = a:word
  let s:interestingModes[n] = a:mode
  let s:mids[a:word] = mid

  call s:ApplyColorToWord(n, a:word, a:mode, mid)

  call s:MarkRecentlyUsed(n)

endfunction

function! s:ApplyColorToWord(n, word, mode, mid)
  let case = s:CheckIgnoreCase(a:word) ? '\c' : '\C'
  if a:mode == 'v'
    let pat = case . '\V\zs' . escape(a:word, '\') . '\ze'
  else
    let pat = case . '\V\<' . escape(a:word, '\') . '\>'
  endif

  try
    call matchadd("InterestingWord" . (a:n + 1), pat, 1, a:mid)
  catch /E801/      " match id already taken.
  endtry
endfunction

function! s:NearestGroupAtCursor()
  let l:matches = {}
  for l:match_item in getmatches()
    let l:mids = filter(items(s:mids), 'v:val[1] == l:match_item.id')
    if len(l:mids) == 0
      continue
    endif
    let l:word = l:mids[0][0]
    let l:position = match(getline('.'), l:match_item.pattern)
    if l:position > -1
      if col('.') > l:position && col('.') <= l:position + len(l:word)
        return l:word
      endif
    endif
  endfor
  return ''
endfunction

function! s:UncolorWord(word)
  let index = index(s:interestingWords, a:word)

  if (index > -1)
    let mid = s:mids[a:word]

    silent! call matchdelete(mid)
    let s:interestingWords[index] = 0
    unlet s:mids[a:word]
  endif
endfunction

function! s:getmatch(mid)
  return filter(getmatches(), 'v:val.id==a:mid')[0]
endfunction

function! interestingwords#navigation(direction) abort
  let currentWord = s:NearestGroupAtCursor()

  if (s:CheckIgnoreCase(currentWord))
    let currentWord = tolower(currentWord)
  endif

  if (index(s:interestingWords, currentWord) > -1)
    let l:index = index(s:interestingWords, currentWord)
    let l:mode = s:interestingModes[index]
    let case = s:CheckIgnoreCase(currentWord) ? '\c' : '\C'
    if l:mode == 'v'
      let pat = case . '\V\zs' . escape(currentWord, '\') . '\ze'
    else
      let pat = case . '\V\<' . escape(currentWord, '\') . '\>'
    endif
    let searchFlag = ''
    if !(a:direction)
      let searchFlag = 'b'
    endif
    call search(pat, searchFlag)
  else
    try
      if (a:direction)
        normal! n
      else
        normal! N
      endif
    catch /E486/
      echohl WarningMsg | echomsg "E486: Pattern not found: " . @/
    endtry
  endif
endfunction

function! interestingwords#color(mode) range
  if a:mode == 'v'
    let currentWord = s:GetVisualSelection()
  else
    let currentWord = expand('<cword>') . ''
  endif
  if !(len(currentWord))
    return
  endif
  if (s:CheckIgnoreCase(currentWord))
    let currentWord = tolower(currentWord)
  endif
  if (index(s:interestingWords, currentWord) == -1)
    call s:ColorWord(currentWord, a:mode)
  else
    call s:UncolorWord(currentWord)
  endif
endfunction

function! s:GetVisualSelection()
  " Why is this not a built-in Vim script function?!
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  let lines = getline(lnum1, lnum2)
  let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][col1 - 1:]
  return join(lines, "\n")
endfunction

function! interestingwords#clear() abort
  for word in s:interestingWords
    " check that word is actually a String since '0' is falsy
    if (type(word) == 1)
      call s:UncolorWord(word)
    endif
  endfor
endfunction

" returns true if the ignorecase flag needs to be used
function! s:CheckIgnoreCase(word)
  " return false if case sensitive is used
  if g:interestingWordsCaseSensitive
    return v:false
  endif
  " checks ignorecase
  " and then if smartcase is on, check if the word contains an uppercase char
  return &ignorecase && (!&smartcase || (match(a:word, '\u') == -1))
endfunction

" moves the index to the back of the s:recentlyUsed list
function! s:MarkRecentlyUsed(n)
  let index = index(s:recentlyUsed, a:n)
  call remove(s:recentlyUsed, index)
  call add(s:recentlyUsed, a:n)
endfunction

function! s:uiMode()
  " Stolen from airline's airline#init#gui_mode()
  return ((has('nvim') && exists('$NVIM_TUI_ENABLE_TRUE_COLOR') && !exists("+termguicolors"))
     \ || has('gui_running') || (has("termtruecolor") && &guicolors == 1) || (has("termguicolors") && &termguicolors == 1)) ?
      \ 'gui' : 'cterm'
endfunction

" initialise highlight colors from list of GUIColors
" initialise length of s:interestingWord list
" initialise s:recentlyUsed list
function! s:BuildColors()
  if (s:hasBuiltColors)
    return
  endif
  let ui = s:uiMode()
  let wordColors = (ui == 'gui') ? g:interestingWordsGUIColors : g:interestingWordsTermColors
  if g:interestingWordsRandomiseColors
    " fisher-yates shuffle
    let i = len(wordColors)-1
    while i > 0
      let j = s:Random(i)
      let temp = wordColors[i]
      let wordColors[i] = wordColors[j]
      let wordColors[j] = temp
      let i -= 1
    endwhile
  endif
  " select ui type
  " highlight group indexed from 1
  let currentIndex = 1
  for wordColor in wordColors
    execute 'hi! def InterestingWord' . currentIndex . ' ' . ui . 'bg=' . wordColor . ' ' . ui . 'fg=Black'
    call add(s:interestingWords, 0)
    call add(s:interestingModes, 'n')
    call add(s:recentlyUsed, currentIndex-1)
    let currentIndex += 1
  endfor
  let s:hasBuiltColors = 1
endfunc

" helper function to get random number between 0 and n-1 inclusive
function! s:Random(n)
  let timestamp = reltimestr(reltime())[-2:]
  return float2nr(floor(a:n * timestamp/100))
endfunction

