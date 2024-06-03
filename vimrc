"   .  . .  .  . .  . S@t.. .  .  . .  .  . .  .  . .  .  . .  .  . .  .  . .  .  . .  .  . .  .  . .  .  . .  .  . .  ..
"    .     ..t%SXSS%:;t.X8S% .   .      .       .       .       .       .       .       .       .       .       .       .
"      . %St8;8:X;8:8:8%8;%%:@S:    . .    . .    ....    .  .    .  .    .  .    .  .    .  .    .  .    .  .    .  ....
"  .    8: %.;t;S;%@88:X.8X8%;8S t@@%   .  %@@t  .X88X .      .       .   %@@@@@@@@@X:  .     .       .       .       .  
"    ..X.;X%8t8%8ttX.88;8.8%:;% ;8:SX%.   SX.8S.  St88:  .  .   .  .    ..XS.@%SSS88S@:. X@@%  . . .    .  .    .  ......
"   . X;:;8SS888;8tt;8:8:8; t:t8S 8:Xt.  :8888: .%888:.  .SSSSSSSSSSS%:  .S888t   @@8X: .%.88  .SSt  .:SS;  .%SSSSSSSS%. 
"    :t8 :;X8S;8.8S;8S.8.t8:%8XS.. S8.8:.S8;8;  :@;@88 . S:88 X.88@88:@t..%S.  .. X;8@: :%:;8. X%:X;. 8;.;  %S8@XXSXSS8..
"  .t88; X;8S8888;8S8t 8S88SSStt:. @.%8St;@8X  . t .8S   S:88:%888%;8t8:..S.S@%SSS8S88t .% @;  X:.X.  88t :.t@t8@ .......
"  8; :888XSStS;88;88X%;;tt::;;8@ ..%X88:88Xt    .S@.::. S@8% X8.@;S888X .%;88SSSS.SX.:. 8S88: @;88t. 8.S8  t;@8@88@88S..
"  S. :tX: ;%8S8 : .::. %8t  %S 8.  @88t8 8t.  . . .@8;  8888 @@%S;t8.8S .:SX8; .:.... . S8; ..8888:..8:8@: ;St@@888.@@..
"    :8:;888888 .; .     8%8@       .8X.@8X  .    X%8@  .t@8S X88X:%888X .@8@8t  ..  .   SX%X .X;;S@%tS8; ;..SttSXS8888S.
"    t.8XX;;8X% XX.  .    %8X8;   . :tX8@t     .  t8X8:  %@@S X8@@:t8tXt...:%t..       . X:8X  X8@@88@888t. %88t888 888t.
"  .    :8;S: . S@.       t8;8:: .   .;:;. . .   .%@%:   t%%; .%%;..: t. .;  :  . . .    %;8.  ;X;X%.:.: t  ;t  ;:: :t;..
"     :%@t%8   88.  .  .  :: . ..   .   .          .   . ..  .      ..   .    .       . . ... .   . .   .        ..      
"      .. 8888   ..      ...   . .    .   .  . .     .   ..    .  .    .        .   .   . ..    .  .  .   .  . .     ....
"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 通用设置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = ","      " 定义<leader>键
set nocompatible         " 设置不兼容原始vi模式
filetype on              " 设置开启文件类型侦测
filetype plugin on       " 设置加载对应文件类型的插件
set noeb                 " 关闭错误的提示
syntax enable            " 开启语法高亮功能
syntax on                " 自动语法高亮
set t_Co=256             " 开启256色支持
set cmdheight=1          " 设置命令行的高度
set showcmd              " select模式下显示选中的行数
set ruler                " 总是显示光标位置
set laststatus=2         " 总是显示状态栏
set number               " 开启行号显示
"set relativenumber      " 开启相对行号
set cursorline           " 高亮显示当前行
"set cursorcolumn        " 高亮光标所在列
set colorcolumn =121     " 高亮指定列
set whichwrap+=<,>,h,l   " 设置光标键跨行
set ttimeoutlen=0        " 设置<ESC>键响应时间
set virtualedit=block,onemore   " 允许光标出现在最后一个字符的后面
set bsdir=buffer         " 设定文件浏览器目录为当前目录
" 开启鼠标
set mouse=a
set selection=exclusive
set selectmode=mouse,key

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 缓存设置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nobackup            " 设置不备份
set noswapfile          " 禁止生成临时文件
set autoread            " 文件在vim之外修改过，自动重新读入
set autowrite           " 设置自动保存
set confirm             " 在处理未保存或只读文件的时候，弹出确认

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 编码设置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set langmenu=zh_CN.UTF-8
set helplang=cn
set termencoding=utf-8
set encoding=utf8
set fileencodings=utf8,ucs-bom,gbk,cp936,gb2312,gb18030

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 代码缩进和排版
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set autoindent           " 设置自动缩进
set cindent              " 设置使用C/C++语言的自动缩进方式
set cinoptions=g0,:0,N-s,(0    " 设置C/C++语言的具体缩进方式
set smartindent          " 智能的选择对其方式
filetype indent on       " 自适应不同语言的智能缩进
set expandtab            " 将制表符扩展为空格
set tabstop=4            " 设置编辑时制表符占用空格数
set shiftwidth=4         " 设置格式化时制表符占用空格数
set softtabstop=4        " 设置4个空格为制表符
set smarttab             " 在行和段开始处使用制表符
set nowrap               " 禁止折行
set backspace=2          " 使用回车键正常处理indent,eol,start等
set sidescroll=10        " 设置向右滚动字符数
set list  				 " 将tab显示为可见字符
set listchars=tab:>-,trail:-     " tab将被显示为>—-,行尾多余的空白字符显示成-
set showmatch            " 高亮显示匹配括号

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 代码折叠
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"set nofoldenable        " 禁用折叠代码
set foldmethod=syntax    " 折叠方式
set foldcolumn=0         " 设置折叠区域的宽度
set foldlevelstart=99    " 打开文件是默认不折叠代码
setlocal foldlevel=1     " 设置折叠层数
"autocmd BufWinEnter * silent! :%foldopen! "打开文件是默认不折叠代码
nnoremap <silent> <F2> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
"注：<space> 不可以随便映射，因为ctrl+] 会应用<space> 映射的命令

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 代码补全
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set wildmenu             " vim自身命名行模式智能补全
set completeopt-=preview " 补全时不显示窗口，只显示补全列表

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 搜索设置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set incsearch           " 开启实时搜索功能
set ignorecase          " 搜索时大小写不敏感
set smartcase           " 搜索大写字母不敏感
set nohlsearch          " 取消高亮搜索结果
" 仅当光标处于搜索内容时高亮搜索结果
function! HighlightSearch()
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
autocmd CursorMoved,CursorMovedI * call HighlightSearch()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 自定义设置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("nvim")
" unnamedplus:所有的操作都会自动被粘贴进 system clipboard 中
" unnamed:必须手动执行 +y 或 +p 等操作,才能复制粘贴到system clipboard 中
set clipboard+=unnamed
let g:python3_host_prog = '/usr/bin/python3'
endif

" 复制粘贴到系统剪切板
" visual block re-mapping
noremap  <silent> <m-v> <c-v>
noremap  <silent> <c-v> "+p
vnoremap <silent> <c-c> "+y
" 保存
noremap <silent> <c-s> :w<cr>
inoremap <silent> <c-s> <Esc>:w<cr>
" 重新映射d 为仅删除不剪切
nnoremap <silent> d   "_d
vnoremap <silent> d   "_d
" 分屏窗口移动
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" 打开文件自动定位到最后编辑的位置
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g'\"" | endif
" 以十六进制显示 vim -b 打开的二进制文件
autocmd BufReadPost * if &bin | execute "%!xxd" | endif

" 主题设置
set background=dark
let g:material_terminal_italics = 1
let g:material_theme_style = 'palenight'
colorscheme material
" 背景透明
"hi Normal  ctermfg=252 ctermbg=none

" 查看vimplus的help文件
command! VimplusHelp :sview +let\ &l:modifiable=0 ~/.vim/help.md

" 使用tmux attach已存在的session时,如果vim中系统剪切版无法使用，需要更新$DISPLAY环境变量
if exists("$TMUX")
colorscheme onedark
command! ClipBoard :let $DISPLAY=substitute(system("tmux show-env | sed -n 's/^DISPLAY=//p'"), '\n', '', '') | echo $DISPLAY
autocmd VimEnter * ClipBoard
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 卸载默认插件UnPlug
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:deregister(repo)
  let repo = substitute(a:repo, '[\/]\+$', '', '')
  let name = fnamemodify(repo, ':t:s?\.git$??')
  call remove(g:plugs, name)
endfunction
command! -nargs=1 -bar UnPlug call s:deregister(<args>)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 插件列表
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')

Plug 'chxuan/vimplus-startify'           "vimplus开始页面
if has("nvim")
Plug 'Shougo/defx.nvim', {'do': ':UpdateRemotePlugins'}
else
Plug 'Shougo/defx.nvim'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'rhysd/vim-healthcheck'
endif
Plug 'preservim/tagbar'
Plug 'easymotion/vim-easymotion'         "强大的光标快速移动工具，强大到颠覆你的插件观
Plug 'terryma/vim-smooth-scroll'         "让翻页更顺畅
Plug 'vim-scripts/indentpython.vim'      "python自动对齐
Plug 'Yggdroot/indentLine'               "显示对齐标线
Plug 'liuchengxu/eleline.vim'            "功能同 airline，比较精简
Plug 'preservim/nerdcommenter'           "添加注释
Plug 'luochen1990/rainbow'               "彩虹括号
Plug 'octol/vim-cpp-enhanced-highlight'  "cpp语法扩展高亮
Plug 'rust-lang/rust.vim'                "rust代码格式化，语法高亮
Plug 'chrisbra/changesPlugin'            "修改显示
Plug 'lfv89/vim-interestingwords'        "单词高亮
Plug 'vim-autoformat/vim-autoformat'     "代码格式化
Plug 'camspiers/lens.vim'                "自动调整当前窗口
Plug 'ludovicchabant/vim-gutentags'      "自动更新tags文件
Plug 'Yggdroot/LeaderF'                  "比ctrlp更强大的文件的模糊搜索工具
Plug 'keeferwu/LeaderF-gtags-history'    "显示leaderf gtags 搜索历史
Plug 'Exafunction/codeium.vim'           "AI智能插件，需要登录获取token才能使用
Plug 'SirVer/ultisnips'                  "需要和vim-snippets or vim-easycomplete 配合使用
Plug 'honza/vim-snippets'                "代码块补全
if empty(findfile("compile_commands.json", '.;'))
Plug 'ervandew/supertab'                 "与vim-easycomplete 冲突
Plug 'vim-scripts/OmniCppComplete'       "c/cpp代码补全 可配合supertab一起使用 缺点：tag 中如果有相同名称的结构体，可能会补全出错
else
Plug 'jayli/vim-easycomplete'            "代码补全 缺点：依赖一些语言端，例如 c/c++ 需要安装 clangd, 注: 由于<c+]>会被重新映射，插件加载需要靠后
let g:gutentags_ctags_module = 0         "不让vim-gutentags支持ctags
endif
Plug 'skywind3000/asyncrun.vim'          "异步运行命令
"Plug 'puremourning/vimspector'           "代码调试

call plug#end()

" load vim default plugin
runtime macros/matchit.vim

" 重新加载vimrc文件
"nnoremap <leader><leader>l :source $MYVIMRC<cr>

" 安装、更新、删除插件
nnoremap <leader><leader>i :PlugInstall<cr>
nnoremap <leader><leader>u :PlugUpdate<cr>
nnoremap <leader><leader>c :PlugClean<cr>


" vimplus-startify
let g:startify_session_persistence = 1
" 相对于默认配置把sessions放在第一个
let g:startify_list_order = [
		\ ['   Sessions'],       'sessions',
        \ ['   MRU '. getcwd()], 'dir',
        \ ['   Bookmarks'],      'bookmarks',
        \ ['   Commands'],       'commands',
        \ ]
let g:startify_session_root_mark = '.root'
"配置项目工作目录到path,通过gf实现头文件跳转
"打开session时调整vim为实时调度，避免cpu繁忙啊卡顿: 'exe system("sudo chrt -r -a -p 50 ".getpid())'
let g:startify_session_savecmds = [
           \ 'let &path=&path.getcwd()."/**"',
           \ 'clearjumps'
           \ ]


"defx.nvim
call defx#custom#option('_', {
            \ 'winwidth': 30,
            \ 'split': 'vertical',
            \ 'direction': 'topleft',
            \ 'show_ignored_files': 0,
            \ 'buffer_name': '',
            \ 'toggle': 1,
            \ 'resume': 1,
            \ })
call defx#custom#column('icon', {
      \ 'directory_icon': '▸',
      \ 'opened_icon': '▾',
      \ 'root_icon': ' ',
      \ })
nnoremap <silent> <F4> :Defx `escape(expand('%:p:h'), ' :')` -search=`expand('%:p')`<CR>
autocmd BufWritePost * call defx#redraw()
autocmd FileType defx call s:defx_mappings()
function! s:defx_mappings() abort
    setl nonu                            " 勿在 defx 栏显示行号
    nnoremap <silent><buffer><expr> <CR>
                \ defx#is_directory() ?
                \ defx#do_action('open_or_close_tree') :
                \ defx#do_action('drop',) " 点击 enter 键打开
    nnoremap <silent><buffer><expr> yy        defx#do_action('copy')
    nnoremap <silent><buffer><expr> dd        defx#do_action('move')
    nnoremap <silent><buffer><expr> pp        defx#do_action('paste')
    nnoremap <silent><buffer><expr> c         defx#do_action('new_file')
    nnoremap <silent><buffer><expr> r         defx#do_action('rename')
    nnoremap <silent><buffer><expr> v         defx#do_action('open', 'vsplit')
    nnoremap <silent><buffer><expr> .         defx#do_action('toggle_ignored_files')
    nnoremap <silent><buffer><expr> h         defx#do_action('cd', getcwd())
    nnoremap <silent><buffer><expr> u         defx#do_action('cd', ['..'])
    nnoremap <silent><buffer><expr> q         defx#do_action('quit')
    nnoremap <silent><buffer><expr> s         defx#do_action('toggle_select') . 'j'
    nnoremap <silent><buffer><expr> *         defx#do_action('toggle_select_all')
    nnoremap <silent><buffer><expr> #         defx#do_action('clear_select_all')
    nnoremap <silent><buffer><expr> <         defx#do_action('resize',  defx#get_context().winwidth - 10)
    nnoremap <silent><buffer><expr> >         defx#do_action('resize',  defx#get_context().winwidth + 10)
endfunction
autocmd FileType defx let s:short_help = 0 | nnoremap <silent><buffer> ? :call DefxHelp()<cr>
function! DefxHelp()
    setlocal modifiable
    silent %delete _
    if s:short_help == 0
        let s:short_help = 1
        let help_cmds = [
                \ ['h ',              'Jump to home directory'],
                \ ['u ',              'Jump to up directory'],
                \ ['v ',              'Open file at vsplit buffer'],
                \ ['r ',              'Rename cursor file'],
                \ ['c ',              'Create a new file'],
                \ ['q ',              'Close defx window'],
                \ ['< ',              'Increase defx window width'],
                \ ['> ',              'Decrease defx window width'],
                \ ['. ',              'Show ignore file'],
                \ ['s ',              'Select cursor file'],
                \ ['* ',              'Select all files'],
                \ ['# ',              'Clear selected files'],
                \ ['dd',              'Move cursor or selected file'],
                \ ['yy',              'Copy cursor or selected file'],
                \ ['pp',              'Paste chip board files'],
            \ ]
        silent 0put ='\" defx keybindings'
        silent  put ='\"'
        for [cmd, desc] in help_cmds
            silent put ='\" ' . cmd . ': ' . desc
        endfor
        silent  put _
    else
        let s:short_help = 0
        call defx#redraw()
    endif
    setlocal nomodifiable
endfunction


" netrw
let g:netrw_banner = 1               "Netrw顶端的横幅
let g:netrw_liststyle = 3            "显示模式为树形
let g:netrw_winsize = 20             "netrw窗口的宽度
if isdirectory(expand("%"))
let g:netrw_browse_split = 0         "Netrw打开文件的方式为覆盖当前窗口
else
let g:netrw_browse_split = 4         "Netrw打开文件的方式为覆盖前一窗口（右边窗口）
endif
let g:netrw_sort_options = 'i'       "排序忽略大小写
let g:netrw_hide = 1                 "忽略隐藏文件
"在 netrw 里隐藏特定文件: ^\..* ->以.开头，^.*\.o$ ->.o结尾
"let g:netrw_list_hide = '^\..*,^.*\.o$,^.*\.swp$,^.*\.bin$'
"nnoremap <silent> <F4> :call ToggleLexplorer()<CR>
function! ToggleLexplorer()
  if exists("t:expl_buf")
    Lexplore
    unlet t:expl_buf
  else
    let g:lens#disabled = 1
    Lexplore %:p:h
    let g:lens#disabled = 0
    let t:expl_buf = bufnr("%")
  endif
endfunction
autocmd FileType netrw nnoremap <silent><buffer> h :call ChangeToHome()<cr>
function! ChangeToHome()
    close
    let g:lens#disabled = 1
    Lexplore
    let g:lens#disabled = 0
endfunction


" tagbar
nnoremap <silent> <F5> :TagbarToggle<cr>
let g:tagbar_width = 40    " 设置 tagbar 的宽度为 40 列
let g:tagbar_ctags_bin = 'ctags' " tagbar 依赖 ctags 插件
let g:tagbar_autofocus = 1   " 打开 tagbar 时光标在 tagbar 页面内，默认在 vim 打开的文件内
let g:tagbar_sort = 0        " 标签不排序，默认排序
"let g:tagbar_left = 1        " 让 tagbar 在页面左侧显示，默认右边
" 在某些情况下自动打开tagbar
"autocmd BufReadPost *.cpp,*.c,*.lua,*.hpp,*.cc,*.cxx call tagbar#autoopen()


" eleline
let g:relative_path_file = 1
let g:eleline_slim = 0


" nerdcommenter
" default delims to /**/ for cpp or c  file
let g:NERDAltDelims_cpp = 1
let g:NERDAltDelims_c = 1


" lens
let g:lens#animate = 0  "取消动画
let g:lens#disabled_filetypes = ['defx', 'netrw', 'tagbar', 'leaderf']
let g:lens#height_resize_max = 40
let g:lens#height_resize_min = 5
let g:lens#width_resize_max = 120
let g:lens#width_resize_min = 20


" indentLine 开启代码对齐线
let g:indentLine_enabled = 1


" vim-interestingwords
let g:interestingWordsCycleColors = 1


" vim-easymotion
let g:EasyMotion_smartcase = 1
map <leader>w <Plug>(easymotion-bd-w)
nmap <leader>w <Plug>(easymotion-overwin-w)


" vim-autoformat
"autocmd BufWrite * :Autoformat
let g:autoformat_remove_trailing_spaces = 1
let g:autoformat_verbosemode = 1
let g:formatdef_google = '"clang-format -style=google"'              " google 风格的代码
let g:formatdef_allman = '"astyle --style=allman --pad-oper"'        " allman风格的代码：{}读占一行
let g:formatters_cpp = ['allman']
let g:formatters_c = ['allman']
let g:autoformat_whitespace_ignored_filetypes = ['startify', 'qf', 'leaderf']
vnoremap <silent><leader><space> : RemoveWhiteSpace<cr>
vnoremap <silent><leader><Tab>   : MoveSpaceToTab<cr>
vnoremap <silent><leader><S-Tab> : MoveTabToSpace<cr>


" vim-smooth-scroll
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 2)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 0, 4)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 0, 4)<CR>


" rainbow
 let g:rainbow_active = 1
 let g:rainbow_conf = {
    \   'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
    \   'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
    \   'operators': '_,_',
    \   'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
    \   'separately': {
    \       '*': {},
    \       'tex': {
    \           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
    \       },
    \       'lisp': {
    \           'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
    \       },
    \       'vim': {
    \           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
    \       },
    \       'html': {
    \           'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ > ])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
    \       },
    \       'css': 0,
    \   }
    \}


" vim-cpp-enhanced-highlight
let g:cpp_class_scope_highlight = 1                    " 高亮显示类的范围
let g:cpp_member_variable_highlight = 1                " 高亮显示成员变量
let g:cpp_class_decl_highlight = 1                     " 高亮显示声明中的类名
let g:cpp_posix_standard = 1                           " 高亮显示POSIX函数
let g:cpp_experimental_simple_template_highlight = 1   " 高亮显示模板函数, 在大文件上可能会有点慢
let g:cpp_experimental_template_highlight = 1          " 高亮显示模板函数, 解决了大文件上慢的问题，但有时会不工作
let g:cpp_concepts_highlight = 1                       " 高亮显示关键字 "concept "和 "requires" 以及标准库名


" changesPlugin  显示修改的代码
let g:changes_autocmd=1
let g:changes_use_icons = 1
let g:changes_linehi_diff = 0
let g:changes_fast=0
let g:changes_vcs_check=1
let g:changes_vcs_system='git'
hi ChangesSignTextAdd ctermbg=green ctermfg=black guibg=green
hi ChangesSignTextDel ctermbg=red  ctermfg=black guibg=red
hi ChangesSignTextCh  ctermbg=blue  ctermfg=black guibg=blue
hi ChangesSignTextDummyCh  ctermfg=NONE ctermbg=blue guifg=NONE guibg=blue
hi ChangesSignTextDummyAdd ctermfg=NONE ctermbg=green guifg=NONE guibg=green


" LeaderF
let g:Lf_ShortcutF = ''
let g:Lf_ShortcutB = ''
nnoremap <leader>lf :LeaderfFile<space>
nnoremap <leader>lb :LeaderfBuffer<cr>
nnoremap <leader>lt :LeaderfBufTag<cr>
nnoremap <leader>ll :LeaderfLine<cr>
nnoremap <leader>lm :LeaderfMru<cr>
let g:Lf_CommandMap = {'<C-K>': ['<Up>'], '<C-J>': ['<Down>']}
let g:Lf_IgnoreCurrentBufferName = 1
"优先级： Lf_ExternalCommand > Lf_UseVersionControlTool > Lf_DefaultExternalTool
"let g:Lf_ExternalCommand = 'find "%s" -type f'  "Lf_WildIgnore 对此选项不起作用
let g:Lf_DefaultExternalTool = 'find'            "rg 默认会自动过滤.ignore .rgignore .gitignore中的文件
let g:Lf_UseVersionControlTool = 0               "0: 使用 Lf_DefaultExternalTool 定义的工具搜索文件, 1: 使用当前项目所使用的版本控制工具
let g:Lf_RecurseSubmodules = 1                   "当g:Lf_UseVersionControlTool = 1 时，通过git ls-files --recurse-submodules 来搜索子项目中的文件
let g:Lf_DefaultMode = 'Fuzzy'
let g:Lf_RootMarkers = ['.root']
let g:Lf_WorkingDirectoryMode = 'Aa'
let g:Lf_UseCache = 1
let g:Lf_NeedCacheTime = 1
let g:Lf_NumberOfCache = 10
let g:Lf_ShowHidden = 0
let g:Lf_WildIgnore = {
            \ 'dir': ['.svn','.git','.hg','.vscode','.wine','.deepinwine','.oh-my-zsh','.clangd','.cache','obj','target'],
            \ 'file': ['*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.py[co]','*.tgt','*.x86']
            \}
let g:Lf_MruWildIgnore = {
            \ 'dir': ['.svn','.git','.hg','.vscode','.wine','.deepinwine','.oh-my-zsh','.clangd','.cache','obj'],
            \ 'file': ['*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.py[co]','*.tgt','*.x86']
            \}
let g:Lf_WindowHeight = 0.40
let g:Lf_PreviewInPopup = 1           "启用预览这个功能 P 弹出窗口
let g:Lf_PreviewPopupWidth = 0        "设置预览窗口大小
let g:Lf_PreviewPosition = 'topright' "设置预览窗口位置
let g:Lf_PreviewResult = {
            \ 'File': 0,
            \ 'Buffer': 0,
            \ 'Mru': 0,
            \ 'Tag': 0,
            \ 'BufTag': 1,
            \ 'Function': 1,
            \ 'Line': 0,
            \ 'Colorscheme': 0,
            \ 'Rg': 1,
            \ 'Gtags': 1
            \}

" 默认rg自动忽略.gitignore指定的文件，链接文件，隐藏文件和二进制文件，可通过g:Lf_RgConfig 进行定制
" 忽略当前及子目录下的.git目录的内容，排除当前目录下x86_run,target 目录的内容，
" 排除.map结尾的文件，排除gtags.files，compile_commands.json 文件,可搜索隐藏文件。
" -t: 指定文件类型，-i: 忽略大小写, -g:可指定特定后缀的文件
" -u: 搜索.gitignore 里的文件, -uu: 搜索隐藏文件 , -uuu: 搜索二进制文件
" --unrestricted:当主项目中的.gitignore 文件忽略掉了子项目目录，该选项可以使搜索不受.gitignore 文件的限制，
" --no-ignore: 禁用所有与忽略相关的过滤(.igrore .rgignore .gitignore)
" 在当前仓库搜索子仓库里的内容, 但搜索过程比较慢
let g:Lf_RgConfig = [
        \ "--max-columns=150",
        \ "--glob=!**/.git/**",
		\ "--glob=!x86_run/*",
		\ "--glob=!target/*",
		\ "--glob=!*.{map,map2,o,tgt,x86}",
		\ "--glob=!gtags.files",
		\ "--glob=!compile_commands.json",
        \ "--hidden",
		\ "--unrestricted"
    \ ]

"Leaderf rg -e<Space>
nmap <leader>rg <Plug>LeaderfRgPrompt
nmap <silent> <leader>rw :LeaderfRgInteractive<cr>
"上次 rg 搜索结果
noremap <silent> <leader>R :LeaderfRgRecall<cr>

" 搜索当前文件选中内容输出到quickfix
vnoremap <silent> <leader>gq y :vimgrep <c-r>" % \| LeaderfQuickFix<cr>
nnoremap <silent> <leader>gq :execute 'vimgrep '.expand("<cword>").' % \| LeaderfQuickFix'<cr>
noremap <silent> <leader>Q :LeaderfQuickFix<cr>
noremap <silent> <leader>F :Leaderf file --recall<cr>

" Leaderf git
nnoremap <leader>lg :LeaderfGit<cr>
let g:Lf_GitCommands = [
                    \ {"Leaderf git log":                                "fuzzy search and view the log"},
                    \ {"Leaderf git log --current-file":                 "fuzzy search and view the log of current file"},
                    \ {"Leaderf git diff":                               "fuzzy search and view the diffs"},
                    \ {"Leaderf git diff --side-by-side --current-file": "view the side-by-side diffs of the current file"},
                    \ {"Leaderf git blame":                              "git blame current file"},
                    \ {"Leaderf git blame --date relative":              "show relative date when git blame current file"},
                    \ ]

" 项目根目录存在gtags.file文件，gtags 会以该文件为基础生成数据，生成gtags.file的方式参考 g:gutentags_file_list_command
" 0 - gtags search the target files by itself. 1 - the target files come from FileExplorer. 2 - the target files come from |g:Lf_GtagsfilesCmd.
let g:Lf_GtagsSource = 0
let g:Lf_GtagsfilesCmd = {
            \ '.git': 'git ls-files --recurse-submodules',
            \ '.hg': 'hg files',
            \ 'default': 'rg --no-messages --files'
            \}
let g:Lf_CtagsFuncOpts = {
            \ 'c': '-I __THROW -I __THROWNL -I __nonnull --fields=+niazS --extras=+q --c-kinds=fp',
            \ 'rust': '--rust-kinds=f',
            \ }

let g:Lf_GtagsAutoGenerate = 0           " auto create gtags
let g:Lf_GtagsAutoUpdate = 0             " auto update when buffer write
let g:Lf_GtagsGutentags = 1              " use vim-gutentags to generate gtags,should make g:Lf_GtagsAutoGenerate = 0 and g:Lf_GtagsAutoUpdate = 0
let g:Lf_GtagsSkipUnreadable = 1         " skip unreadable files
let g:Lf_GtagsAcceptDotfiles = 0         " not accept hidden files
let g:Lf_GtagsSkipSymlink = 'a'          " f - skip file link, d - skip directorie link, a - skip all link
let g:Lf_Gtagslabel = 'native-pygments'  " gtags 默认 C/C++/Java 等六种原生支持的代码直接使用 gtags 本地分析器，而其他语言使用 pygments 模块。
nmap <silent><leader>G :Leaderf! gtags --recall<cr>
nmap <silent><leader>gh :Leaderf gtags_history<cr>
if g:Lf_GtagsAutoGenerate == 1
    autocmd FileType startify let g:Lf_GtagsAutoUpdate = 1
    nmap <silent><leader>gu :Leaderf gtags --update<cr>
    if g:Lf_GtagsAutoUpdate == 1
        " 光标1小时没有发生移动，自动更新gtags文件
        autocmd CursorHold * if !exists('s:update_timer')|let s:update_timer = timer_start(3600*1000, { -> execute('Leaderf gtags --update')})|endif
        autocmd CursorMoved,CursorMovedI * if exists('s:update_timer')|call timer_stop(s:update_timer)|unlet s:update_timer|endif
    endif
endif


" vim-gutentags
" gutentags 搜索工程目录的标志，当前文件路径向上递归直到碰到这些文件/目录名
let g:gutentags_project_root = ['.root']
let g:gutentags_add_default_project_roots = 0  "不匹配默认的标志
let s:gutentags_path_exclude = '\( -path "*.git*" -o -path "*clangd*" -o -path "*obj*" -o -path "*htmlpages*" -o -path "./boot*" -o -path "./os*" -o -path "./image*" -o -path "./x86_run*" -o -path "./target*" \)'
" -name: 匹配文件名，-iname: 匹配文件名时忽略大小写， -wholename: 匹配文件名及其路径
let s:gutentags_file_exclude = '\( -type f -not -iname "*makefile*" -not -iname "*.txt" -not -name "*.map" -not -name "*.o" -not -name "*.tgt" -not -name "*.x86" -not -wholename ".gitignore" \)'
let g:gutentags_file_list_command = 'find . ' . s:gutentags_path_exclude . ' -a -prune -o ' . s:gutentags_file_exclude . ' -print'
let g:gutentags_ctags_exclude = ['*/.git/*', '*/.clangd/*', '*/configs/*', '*.json', '*.mib', '*.db', '*.css', '*.js', '*.html']
let g:gutentags_ctags_extra_args = ['-I __THROW', '-I __THROWNL', '-I __nonnull']
" i 表示如果有继承, 则标识出父类; a 表示类成员调用权限 (public or private); S 表示如果是函数, 则标识函数的signature.
let g:gutentags_ctags_extra_args += ['--fields=+niazS', '--language-force=c']
" 记录函数声明和各种外部和前向声明
"let g:gutentags_ctags_extra_args += ['--c++-kinds=+px', '--c-kinds=+px']
" 如果使用 universal ctags 需要增加下面一行，老的 Exuberant-ctags 不能加下一行
let g:gutentags_ctags_extra_args += ['--extras=+q', '--output-format=e-ctags']
" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile = 'tags'
" 将自动生成的 ctags/gtags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
let g:gutentags_cache_dir = expand('~/.cache/tags')
let g:gutentags_trace = 0
"打开一些特殊的命令GutentagsToggleEnabled,GutentagsToggleTrace
"let g:gutentags_define_advanced_commands = 1
let g:gutentags_generate_on_write = 1
let g:gutentags_generate_on_new = 0
"仅有通过startify session 打开文件，gtags数据才进行更新
autocmd FileType startify let g:gutentags_generate_on_new = 1
" 同时开启 ctags 和 gtags 支持：
let g:gutentags_modules = []
if get(g:, 'gutentags_ctags_module', 1) && executable('ctags')
    let g:gutentags_modules += ['ctags']
    " 默认情况下crl+] 只会跳到tags中的第一个匹配项，添加该功能，显示tags中多个匹配项, 此项与插件 vim-easycomplete 冲突
    map <c-]> g<c-]>
endif
if get(g:, 'Lf_GtagsGutentags', 1) && executable('gtags-cscope')
    let g:gutentags_modules += ['gtags_cscope']
    " gtags 默认 C/C++/Java 等六种原生支持的代码直接使用 gtags 本地分析器，而其他语言使用 pygments 模块。
    let $GTAGSLABEL = 'native-pygments'
    " 禁用 gutentags 自动加载 gtags 数据库到cscope,避免多个项目生成数据文件在cosope相互影响。
    let g:gutentags_auto_add_gtags_cscope = 0
    " generate gtags data to leaderF
    let g:gutentags_cache_dir = expand('~/.cache/LeaderF/gtags')
    nmap <silent><leader>gu :GutentagsUpdate!<cr>
    if g:gutentags_generate_on_new == 1
        " 光标10min内没有发生移动，自动更新gtags文件
        autocmd CursorHold * if !exists('s:update_timer')|let s:update_timer = timer_start(600*1000, { -> execute('GutentagsUpdate!')})|endif
        autocmd CursorMoved,CursorMovedI * if exists('s:update_timer')|call timer_stop(s:update_timer)|unlet s:update_timer|endif
    endif
endif


" OmniCppComplete
set tags+=/usr/include/tags        "补全标准C
let OmniCpp_GlobalScopeSearch = 1  "全局查找控制。0:禁止；1:允许(缺省)
let OmniCpp_NamespaceSearch = 1    "命名空间查找控制0 : 禁止查找命名空间1 : 查找当前文件缓冲区内的命名空间(缺省) 2 : 查找当前文件缓冲区和包含文件中的命名空间
let OmniCpp_DisplayMode = 1        "类成员显示控制(是否显示全部公有(public)私有(private)保护(protected)成员)  0 : 自动 1 : 显示所有成员
let OmniCpp_ShowScopeInAbbr = 0    "选项用来控制匹配项所在域的显示位置。缺省情况下，omni显示的补全提示菜单中总是将匹配项所在域信息显示在缩略信息最后一列。0 : 信息缩略中不显示匹配项所在域(缺省)1 : 显示匹配项所在域，并移除缩略信息中最后一列
let OmniCpp_ShowAccess = 1         "是否显示访问控制信息('+', '-', '#')。0/1, 缺省为1(显示)
let OmniCpp_ShowPrototypeInAbbr = 1  "是否是补全提示缩略信息中显示函数原型。0 : 不显示(缺省) 1 : 显示原型
let OmniCpp_MayCompleteDot = 1       "在'.'号后是否自动运行omnicppcomplete给出提示信息。0/1, 缺省为1
let OmniCpp_MayCompleteArrow = 1     "在"->"后是否自动运行omnicppcomplete给出提示信息。0/1, 缺省为1
let OmniCpp_MayCompleteScope = 0     "在域标识符"::"后是否自动运行omnicppcomplete给出提示信息。0/1, 缺省为0
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]  "默认命名空间列表，项目间使用','隔开。
let OmniCpp_SelectFirstItem = 2      "是否自动选择第一个匹配项。仅当"completeopt"不为"longest"时有效。0 : 不选择第一项(缺省) 1 : 选择第一项并插入到光标位置 2 : 选择第一项但不插入光标位置
autocmd CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif  "自动关闭补全窗口
set completeopt=menuone,menu,longest


" supertab
let g:SuperTabRetainCompletionType = 2 " 0 不记录上次的补全方式 1 记住上次的补全方式,直到用其他的补全命令改变它 2 记住上次的补全方式,直到按ESC退出插入模式为止
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = "<c-x><c-n>"
let g:SuperTabCompleteCase = 'match'


" vim-easycomplete
let g:easycomplete_scheme="dark"
let g:easycomplete_lsp_checking = 1           " check LSP server 是否安装
let g:easycomplete_signature_enable = 1       " lsp signature checking
let g:easycomplete_tabnine_enable = 0         " disable TabNine
let g:easycomplete_diagnostics_enable = 1     " 语法检测
let g:easycomplete_diagnostics_prev = "<c-p>"
let g:easycomplete_diagnostics_next = "<c-n>"
let g:easycomplete_cursor_word_hl = 0         " Highlight the symbol when holding the cursor
let g:easycomplete_nerd_font = 0              " Using nerdfont is highly recommended
if get(g:, 'easycomplete_enable', 0)
" GoTo code navigation
noremap gr :EasyCompleteReference<CR>
noremap gd :EasyCompleteGotoDefinition<CR>
noremap gb :BackToOriginalBuffer<CR>
noremap rn :EasyCompleteRename<CR>
endif


" codeium.vim
let g:codeium_enabled = 0               " enable codeium need token
let g:codeium_disable_bindings = 1      " disable default keybindings
let g:codeium_no_map_tab = 1            " disabled Codeium use tab keybindings
imap <script><silent><nowait><expr> <M-=> codeium#Accept()
imap <M-->   <Cmd>call codeium#Clear()<CR>
imap <M-,>   <Cmd>call codeium#CycleCompletions(-1)<CR>
imap <M-.>   <Cmd>call codeium#CycleCompletions(1)<CR>


" asyncrun.vim
noremap <F9> :AsyncRun -mode=term -pos=tab<space>
noremap <silent> <leader>tn :tabnext<cr>
noremap <silent> <leader>tc :tabclose<cr>


" vim-buffer
noremap <silent> <leader>qa :call CloseBuffer(0)<cr>
nnoremap <silent> <leader>bd :call CloseBuffer(1)<cr>
autocmd BufAdd * let b:max_buffer_num = 100 | call CloseBuffer(2)
function! CloseBuffer(action)
  if &filetype == "defx" || &filetype == "tagbar" || &filetype == "qf"
    echo "Window not support close buffer!"
    return
  endif
  if a:action == 0
    execute ":only | q"
  endif
  if a:action == 1
    if winnr('$') > 1
        execute ":only"
    endif
    "关闭当前的buffer
    execute ":bd"
  endif
  if a:action == 2
    let curr_buf = bufnr("%")
    let oldest_buf = curr_buf
    let oldest_time = localtime()
    let buf_info = filter(getbufinfo(), 'buflisted(v:val.bufnr)')
    if len(buf_info) <= b:max_buffer_num
      return
    endif
    for buf in buf_info
      "关闭最早打开的buffer
      if buf.lastused < oldest_time
        let oldest_buf = buf.bufnr
        let oldest_time = buf.lastused
      endif
    endfor
    if oldest_buf != curr_buf
      execute 'bdelete ' . oldest_buf
    endif
  endif
endfunction

