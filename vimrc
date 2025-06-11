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
set nocompatible                " 设置不兼容原始vi模式
filetype on                     " 设置开启文件类型侦测
filetype plugin on              " 设置加载对应文件类型的插件
set noeb                        " 关闭错误的提示
syntax enable                   " 开启语法高亮功能
syntax on                       " 自动语法高亮
set t_Co=256                    " 开启256色支持
set cmdheight=1                 " 设置命令行的高度
set noshowcmd                   " 不在状态行显示正在执行的命令
set ruler                       " 总是显示光标位置
set laststatus=2                " 总是显示状态栏
set number                      " 开启行号显示
"set relativenumber             " 开启相对行号
set cursorline                  " 高亮显示当前行
"set cursorcolumn               " 高亮光标所在列
set colorcolumn =121            " 高亮指定列
set whichwrap+=<,>,h,l          " 设置光标键跨行
set ttimeoutlen=0               " 设置<ESC>键响应时间
set timeoutlen=500              " 默认超时是1000 ms
"set updatetime=300              " 更新时间默认是4s
set signcolumn=yes              " 总是显示侧边栏标识
set virtualedit=block,onemore   " 允许光标出现在最后一个字符的后面
set splitright                  " 设置分割窗口位置为右侧
set mouse=a                     " 开启鼠标
set selection=exclusive
set selectmode=mouse,key

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 缓存设置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nobackup                    " 设置不备份
set noswapfile                  " 禁止生成临时文件
set autoread                    " 文件在vim之外修改过，自动重新读入
set autowrite                   " 设置自动保存
set confirm                     " 在处理未保存或只读文件的时候，弹出确认

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 编码设置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set langmenu=zh_CN.UTF-8
set helplang=cn
if !has('nvim-0.11.0')
set termencoding=utf-8
endif
set encoding=utf8
set fileencodings=utf8,ucs-bom,gbk,cp936,gb2312,gb18030

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 代码缩进和排版
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set autoindent                   " 设置自动缩进
set cindent                      " 设置使用C/C++语言的自动缩进方式
set cinoptions=g0,:0,N-s,(0      " 设置C/C++语言的具体缩进方式
set smartindent                  " 智能的选择对其方式
filetype indent on               " 自适应不同语言的智能缩进
set expandtab                    " 将制表符扩展为空格
set tabstop=4                    " 设置编辑时制表符占用空格数
set shiftwidth=4                 " 设置格式化时制表符占用空格数
set softtabstop=4                " 设置4个空格为制表符
set smarttab                     " 在行和段开始处使用制表符
set nowrap                       " 禁止折行
set backspace=2                  " 使用回车键正常处理indent,eol,start等
set sidescroll=10                " 设置向右滚动字符数
set list                         " 将tab显示为可见字符
set listchars=tab:>-,trail:-     " tab将被显示为>—-,行尾多余的空白字符显示成-
set showmatch                    " 高亮显示匹配括号

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 代码折叠
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"set nofoldenable                " 禁用折叠代码
set foldmethod=indent            " 折叠方式,syntax会导致大文件卡顿
set foldcolumn=0                 " 设置折叠区域的宽度
set foldlevelstart=99            " 打开文件是默认不折叠代码
nnoremap <silent> <F2> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 代码补全
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set wildmenu                     " vim自身命名行模式智能补全
set completeopt-=preview         " 补全时不显示窗口，只显示补全列表

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 搜索设置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set incsearch                    " 开启实时搜索功能
set ignorecase                   " 搜索时大小写不敏感
set smartcase                    " 搜索大写字母不敏感
set nohlsearch                   " 取消高亮搜索结果
autocmd CursorMoved,CursorMovedI * call vimplus#hlsearch()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 主题设置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set background=dark
let g:onedark_terminal_italics = get(g:, 'terminal_italics', 1)
"colorscheme onedark
let g:material_terminal_italics = get(g:, 'terminal_italics', 1)
let g:material_theme_style = 'palenight'
colorscheme material
" 背景透明
"hi Normal  ctermfg=252 ctermbg=none

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 自定义设置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let $PROJECT_ROOT = '.root'    " 定义环境变量标识项目根目录
" 打开文件自动定位到最后编辑的位置
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g'\"" | endif
" 以十六进制显示 vim -b 打开的二进制文件
autocmd BufReadPost * if &bin | execute "%!xxd" | endif
" 重新映射d 为仅删除不剪切
nnoremap <silent> d   "_d
vnoremap <silent> d   "_d
" visual block re-mapping
noremap <silent> <m-v> <c-v>
" C+z默认会退到后台，重映射为展开所有折叠
nnoremap <silent> <C-z> zR
"终端下映射ESC退出到normal模式
tnoremap <silent> <Esc> <C-\><C-n>
" 保存
nnoremap <silent> <C-s> :<C-u>call vimplus#write()<cr>
" 分屏窗口移动
nnoremap <silent> <C-j> :wincmd j<cr>
nnoremap <silent> <C-k> :wincmd k<cr>
nnoremap <silent> <C-h> :wincmd h<cr>
nnoremap <silent> <C-l> :wincmd l<cr>
" 调整窗口高度和宽度
nnoremap <silent> <C-Up>    :resize +5<cr>
nnoremap <silent> <C-Down>  :resize -5<cr>
nnoremap <silent> <C-Right> :vertical resize +5<cr>
nnoremap <silent> <C-Left>  :vertical resize -5<cr>

if has("nvim")
  " unnamedplus:所有的操作都会自动被粘贴进 system clipboard 中
  " unnamed:必须手动执行 +y 或 +p 等操作,才能复制粘贴到system clipboard 中
  set clipboard+=unnamed
  let g:python3_host_prog = '/usr/bin/python3'
  autocmd TermOpen * startinsert
  nnoremap <silent> <s-t> :tabnew \| terminal<cr>
  command! CheckHealth :checkhealth
else
  "fix some plugin use BufWitePost cause vim crash when use command wq
  cabbrev wq w<bar>sleep 200m<bar>q
  cabbrev wqa w<bar>sleep 200m<bar>qall
  cabbrev wqal w<bar>sleep 200m<bar>qall
  cabbrev wqall w<bar>sleep 200m<bar>qall
  nnoremap <silent> <s-t> :tabnew \| term ++curwin<cr>
endif
" 复制粘贴到系统剪切板
autocmd VimEnter * call clipboard#check()
if !has('clipboard') || exists('$TMUX')
  noremap  <silent> <c-v> :<c-u>call clipboard#paste()<cr>
  vnoremap <silent> <c-c> :<c-u>call clipboard#yank()<cr>
else
  noremap  <silent> <c-v> "+p
  vnoremap <silent> <c-c> "+y
endif
if exists("$TMUX")
  let g:terminal_italics = 0    " tmux 默认不支持斜体
  " 使用tmux attach已存在的session时,如果vim中系统剪切版无法使用，需要更新$DISPLAY环境变量
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

" 启动页面
Plug 'mhinz/vim-startify'
" 快捷键提示
Plug 'liuchengxu/vim-which-key'
" 精简的statusline
Plug 'liuchengxu/eleline.vim'
" vim 插件环境检测
Plug 'rhysd/vim-healthcheck', has('nvim') ? {'on': []} : {'on': 'CheckHealth'}
" 函数显示列表
Plug 'preservim/tagbar'
" 光标快速移动
Plug 'easymotion/vim-easymotion'
" 显示缩进标线
Plug 'Yggdroot/indentLine'
" 代码快速注释
Plug 'preservim/nerdcommenter'
" 彩虹括号
Plug 'luochen1990/rainbow'
" cpp扩展高亮
Plug 'octol/vim-cpp-enhanced-highlight', has('nvim') ? {'on': []} : {'for': ['c','cpp']}
" rust代码格式化，语法高亮
Plug 'rust-lang/rust.vim', has('nvim') ? {'on': []} : {'for': 'rust'}
" 修改显示
Plug 'chrisbra/changesPlugin'
" 代码格式化
Plug 'vim-autoformat/vim-autoformat', {'on': ['Autoformat','AutoformatLine','RemoveTrailingSpaces']}
" 使用global工具自动更新tags文件
Plug 'ludovicchabant/vim-gutentags'
" 文件模糊搜索工具
Plug 'Yggdroot/LeaderF', {'do': ':LeaderfInstallCExtension'}
" 显示leaderf gtags 搜索历史
Plug 'keeferwu/LeaderF-gtags-history'
" AI智能插件，需要登录获取token
Plug 'Exafunction/codeium.vim', {'branch': 'main'}
" 代码块补全，配合ultisnips使用
Plug 'honza/vim-snippets'
" 代码块模板
Plug 'SirVer/ultisnips', exists('$VIMLSP') ? {'on': []} : {}
" tab触发补全
Plug 'ervandew/supertab', exists('$VIMLSP') ? {'on': []} : {}
" c/cpp代码补全 可配合supertab一起使用 缺点：tag 中如果有相同名称的结构体，可能会补全出错
Plug 'vim-scripts/OmniCppComplete', exists('$VIMLSP') ? {'on': []} : {'for': ['c','cpp']}
" lsp代码补全,需要安装语言服务器
Plug 'neoclide/coc.nvim', exists('$VIMLSP') ? {'branch': 'release'} : {'on': []}
" 代码调试
Plug 'puremourning/vimspector'

" nvim插件库
Plug 'nvim-lua/plenary.nvim', has('nvim') ? {'branch': 'master'} : {'on': []}
" nvim代码语法高亮
Plug 'nvim-treesitter/nvim-treesitter', has('nvim') ? {'do': ':TSUpdate'} : {'on': []}
" ai编程助手
Plug 'olimorris/codecompanion.nvim', has('nvim') ? {} : {'on': []}
" 渲染 markdown 和 codecompanion 文件
Plug 'MeanderingProgrammer/render-markdown.nvim', has('nvim') ? {} : {'on': []}
" nvim 消息提示, use for codecompanion
Plug 'j-hui/fidget.nvim', has('nvim') ? {} : {'on': []}

call plug#end()

" load vim default plugin
runtime macros/matchit.vim

" vim-startify
let g:startify_session_dir = '~/.vim/session'
let g:startify_session_sort = 1          " sort by last open time
let g:startify_session_persistence = 1
let g:startify_bookmarks = []
let g:startify_commands = [
            \ {'h': ['check health', 'CheckHealth']},
            \ {'c': ['gtags cache', 'Leaderf gtags_history --cache']},
            \ ]
" 相对于默认配置把sessions放在第一个
let g:startify_lists = [
            \ { 'header': ['   Sessions [d]->SDelete'], 'type': 'sessions' },
            \ { 'header': ['   MRU ' . getcwd()],       'type': 'dir' },
            \ { 'header': ['   Bookmarks'],             'type': 'bookmarks' },
            \ { 'header': ['   Commands'],              'type': 'commands' },
            \ ]
let g:startify_session_root_mark = $PROJECT_ROOT
" session 退出时自动切换工作目录到主目录
let g:startify_session_before_save = [
            \ "exec 'cd' fnamemodify(finddir('.git', ';'), ':h')",
            \ "exec 'cd' fnamemodify(findfile(g:startify_session_root_mark, ';'), ':h')",
            \ "normal! zR"
            \ ]
let g:startify_session_savevars = [
            \ 'g:colors_name',
            \ 'g:gutentags_ignore_list',
            \ ]
"清除terminal的buffer
let g:startify_session_remove_lines = ['term:\/', 'NetrwTreeListing', 'CodeCompanion']
"配置项目工作目录到path,通过gf实现头文件跳转
"打开session时调整vim为实时调度，避免cpu繁忙啊卡顿: 'exe system("sudo chrt -r -a -p 50 ".getpid())'
let g:startify_session_savecmds = [
            \   'let &path=&path.getcwd()."/**"',
            \   'clearjumps',
            \   'exe "colorscheme " . g:colors_name',
            \   'if !get(g:, "changes_sign_text_utf8", 0)',
            \   '  hi ChangesSignTextAdd ctermbg=green ctermfg=black guibg=green',
            \   '  hi ChangesSignTextDel ctermbg=red  ctermfg=black guibg=red',
            \   '  hi ChangesSignTextCh  ctermbg=blue  ctermfg=black guibg=blue',
            \   '  hi ChangesSignTextDummyCh  ctermfg=NONE ctermbg=blue guifg=NONE guibg=blue',
            \   '  hi ChangesSignTextDummyAdd ctermfg=NONE ctermbg=green guifg=NONE guibg=green',
            \   'endif',
            \   'if g:gutentags_file_list_command[:1] == "fd"',
            \   '  if empty(findfile(g:startify_session_root_mark, ";"))',
            \   '    let g:Lf_UseVersionControlTool = 1',
            \   '    let g:Lf_RootMarkers += [''.git'', ''.hg'']',
            \   '    let g:gutentags_project_root += [''.git'', ''.hg'']',
            \   '    let g:gutentags_file_list_command = substitute(g:gutentags_file_list_command, ''--no-ignore-vcs'', '''', ''g'')',
            \   '    let g:Lf_RgConfig = filter(copy(g:Lf_RgConfig), ''v:val !=# "--no-ignore-vcs"'')',
            \   '  endif',
            \   '  if !empty(g:gutentags_ignore_list)',
            \   '    let s:gutentags_exclude = map(g:gutentags_ignore_list, ''v:val =~ ''''^".*"$'''' ? v:val : ''''"''''.v:val.''''"'''''')',
            \   '    let g:gutentags_file_list_command .= " --exclude " . join(s:gutentags_exclude, " --exclude ")',
            \   '    let g:Lf_RgExGlob += g:gutentags_ignore_list',
            \   '  endif',
            \   'endif',
            \ ]
"delete session in starify
function! SessionDelete()
  let session = split(getline('.'))[-1]
  exec 'SDelete ' . session
  exec 'Leaderf gtags_history --cache'
  exec 'Startify'
endfunction
autocmd FileType startify nnoremap <silent><buffer> d :call SessionDelete()<cr>

" vim-which-key
let g:which_key_hspace = 10
let g:which_key_sort_horizontal = 0
let g:which_key_align_by_seperator = 1
let g:mapleader = "\<Space>"      " 定义<leader>键
nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual '<Space>'<CR>
" key map中的key必须为半角字符，否则会报错，有些输入法会将shift+space作为半全角切换快捷键
let g:which_key_map = {}
let g:which_key_map[' '] = {'name' : '+plugin',
                    \   'l': "plugin LSP complete",
                    \   'i': "plugin install",
                    \   'u': "plugin update",
                    \   'c': "plugin clean",
                    \   'h': "vimplus help",
                    \   }
let g:which_key_map.w = 'easy motion to word'
let g:which_key_map.k = 'color/uncolor cword'
let g:which_key_map.K = 'uncolor all worlds'
let g:which_key_map.d = {'name' : '+different',
                    \    'f' : 'differ input file',
                    \    'm' : 'toggle diff mode',
                    \    's' : 'change diff stype',
                    \    'r' : 'revert current change',
                    \    'h' : 'stage hunk current change',
                    \    'H' : 'stage hunk current change revert',
                    \   }
let g:which_key_map.c = {'name' : '+commenter'}
let g:which_key_map.f = {'name' : '+leaderf',
                    \    'f' : 'leaderf file',
                    \    'b' : 'leaderf buffer',
                    \    'm' : 'leaderf mru',
                    \    't' : 'leaderf buftag',
                    \    'l' : 'leaderf line',
                    \    'g' : 'leaderf git',
                    \    'c' : 'leaderf command',
                    \    's' : 'leaderf colorscheme',
                    \    'h' : 'leaderf help',
                    \   }
let g:which_key_map.l = {'name' : '+list',
                    \    'f' : 'leaderf file list',
                    \    'g' : 'leaderf gtags list',
                    \    'r' : 'leaderf ripgrep list',
                    \    'q' : 'leaderf qickfix list',
                    \    'l' : 'leaderf location list',
                    \   }
let g:which_key_map.r = {'name' : '+grep',
                    \    'g' : 'ripgrep content with prompt',
                    \    's' : 'ripgrep word with interactive',
                    \    'c' : 'vimgrep cword in current buffer',
                    \   }
let g:which_key_map.g = {'name' : '+gtags',
                    \    'a' : 'querytype for pattern',
                    \    'd' : 'goto definition',
                    \    'r' : 'reference symbol with definition',
                    \    's' : 'reference symbol with no definition',
                    \    'g' : 'grep cword by gtags',
                    \    'h' : 'gtags search history',
                    \    'u' : 'gtags update',
                    \   }
let g:which_key_map.q = {'name' : '+quit',
                    \    'a' : 'quit vim/nvim',
                    \    'b' : 'quit buffer',
                    \    't' : 'quit tab',
                    \    'q' : 'quit quickfix',
                    \   }
if exists('$VIMLSP')
let g:which_key_map.j = {'name' : '+jump',
                    \    'd' : 'jumpDefinition',
                    \    'r' : 'jumpReferences',
                    \    'c' : 'jumpDeclaration',
                    \    'i' : 'jumpImplementation',
                    \    't' : 'jumpTypeDefinition',
                    \   }
endif
call which_key#register('<Space>', "g:which_key_map", 'n')
let g:which_key_map_visual = {}
let g:which_key_map_visual.c = {'name' : '+commenter'}
let g:which_key_map_visual.r = {'name' : '+grep',
                    \    'c' : 'vimgrep select in current buffer',
                    \   }
let g:which_key_map_visual.k = 'color select pattern'
call which_key#register('<Space>', "g:which_key_map_visual", 'v')

" plugin
function! UseLSPComplete(error, res)
  if !empty(a:error)
    echom a:error
    return
  endif
  if exists("$VIMLSP")
    echohl WarningMsg
    echom "LSP complete plugin has already been loaded!"
    echohl None
    return
  endif
  if a:res == 1   "yes
    "修改的环境变量只在vim下生效，需要在bash下手动export VIMLSP才会在终端中生效
    "call setenv('VIMLSP', 'yes')
    call vimplus#vimclose()
  endif
endfunction
let lsp_confirm = "NOTE: vim/nvim will be closed, and you should export VIMLSP to env."
nnoremap <silent> <leader><leader>l :call vimplus#confirm(lsp_confirm,function("UseLSPComplete"))<cr>
nnoremap <silent> <leader><leader>h :vert help vimplus<cr>
" 安装、更新、删除插件
nnoremap <silent> <leader><leader>i :PlugInstall<cr>
nnoremap <silent> <leader><leader>u :PlugUpdate<cr>
nnoremap <silent> <leader><leader>c :PlugClean<cr>

" buffer,table and whitespace
let g:vimplus_ignored_filetypes = ['startify', 'qf', 'netrw', 'tagbar', 'leaderf', 'codecompanion']
autocmd BufAdd * call vimplus#buflimit(100)
nnoremap <silent> <leader>qb :call vimplus#bufclose()<cr>
nnoremap <silent> <leader>qa :call vimplus#vimclose()<cr>
nnoremap <silent> <leader>qq :call vimplus#qfclose()<cr>
nnoremap <silent> <leader>qt :call vimplus#tabclose()<cr>
nnoremap <silent> <leader>df :call vimplus#differ()<cr>
nnoremap <silent> <leader>rc :<c-u>call vimplus#vimgrep('n')<cr>
vnoremap <silent> <leader>rc :<c-u>call vimplus#vimgrep('v')<cr>

" highlight word
nnoremap <silent> <leader>k :call interestingwords#color('n')<cr>
vnoremap <silent> <leader>k :call interestingwords#color('v')<cr>
nnoremap <silent> <leader>K :call interestingwords#clear()<cr>
nnoremap <silent> n :call interestingwords#navigation(1)<cr>
nnoremap <silent> N :call interestingwords#navigation(0)<cr>

" netrw
let g:netrw_banner = 1               "Netrw顶端的横幅
let g:netrw_liststyle = 3            "显示模式为树形
let g:netrw_winsize = 0              "通过netrw分割的窗口宽度,0:自适应
"let g:netrw_altv = 0                 "在左侧纵向分割的窗口,默认为右侧
let g:netrw_preview = 1              "在纵向分割的窗口中显示预览窗口
let g:netrw_dirhistmax = 0           "不记录目录跳转历史
if isdirectory(expand("%"))
  let g:netrw_browse_split = 0         "Netrw打开文件的方式为覆盖当前窗口
else
  let g:netrw_browse_split = 4         "Netrw打开文件的方式为覆盖前一窗口（右边窗口）
endif
let g:netrw_sort_options = 'i'       "排序忽略大小写
let g:netrw_hide = 1                 "忽略隐藏文件
"在 netrw 里隐藏特定文件: ^\..* ->以.开头，^.*\.o$ ->.o结尾
"let g:netrw_list_hide = '^\..*,^.*\.o$,^.*\.swp$,^.*\.bin$'
nnoremap <silent> <F3> :call ToggleExplorer()<CR>
function! ToggleExplorer()
  if &buftype ==# 'terminal' || &buftype ==# 'nofile'
    return
  endif
  let winid = get(t:, 'netrw_winid', 0)
  if win_gotoid(winid)
    let t:netrw_winid = 0
    close
    return
  endif
  let bufname = expand('%:t')
  " open current file's dir at left
  execute 'Vexplore'
  " corsor to current file
  call search('\V'.bufname, 'w')
  let t:netrw_winid = bufwinid("%")
  wincmd H | vertical resize 40
  setlocal winfixwidth
endfunction
autocmd FileType netrw nnoremap <silent><buffer> h :call ChangeToCwd()<cr>
function! ChangeToCwd()
  if t:netrw_winid == bufwinid("%")
    close
    " open current dir
    execute 'Vexplore ' . getcwd()
    let t:netrw_winid = bufwinid("%")
    wincmd H | vertical resize 40
    setlocal winfixwidth
  endif
endfunction

" tagbar
nnoremap <silent> <F4> :TagbarToggle<cr>
let g:tagbar_width = 40    " 设置 tagbar 的宽度为 40 列
let g:tagbar_ctags_bin = 'ctags' " tagbar 依赖 ctags 插件
let g:tagbar_autofocus = 1   " 打开 tagbar 时光标在 tagbar 页面内，默认在 vim 打开的文件内
let g:tagbar_sort = 0        " 标签不排序，默认排序
"let g:tagbar_left = 1        " 让 tagbar 在页面左侧显示，默认右边
let g:tagbar_show_tag_linenumbers = 1 "显示tag行号
" 在某些情况下自动打开tagbar
"autocmd BufReadPost *.cpp,*.c,*.lua,*.hpp,*.cc,*.cxx call tagbar#autoopen()

" eleline
let g:relative_path_file = 1
let g:eleline_slim = 0
let g:eleline_powerline_fonts = 1
let g:eleline_function_icon = ''

" nerdcommenter
" default delims to /**/ for cpp or c  file
let g:NERDAltDelims_cpp = 1
let g:NERDAltDelims_c = 1

" indentLine 开启代码对齐线
let g:indentLine_enabled = 1
let g:indentLine_leadingSpaceEnabled = 0
let g:indentLine_concealcursor = 'ic'

" vim-easymotion
let g:EasyMotion_smartcase = 1
nmap <silent> <leader>w <Plug>(easymotion-overwin-w)

" vim-autoformat
"autocmd BufWrite * :Autoformat
let g:autoformat_remove_trailing_spaces = 1
let g:autoformat_verbosemode = 1
let g:formatdef_google = '"clang-format -style=google"'              " google 风格的代码
let g:formatdef_allman = '"astyle --style=allman --pad-oper"'        " allman风格的代码：{}读占一行
let g:formatters_cpp = ['allman']
let g:formatters_c = ['allman']

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
let g:changes_autocmd = 1
let g:changes_use_icons = 1
let g:changes_sign_text_utf8 = 1
let g:changes_utf8_add_sign = '✚'
let g:changes_utf8_delete_sign = '✖'
let g:changes_utf8_modified_sign = '✱'
let g:changes_linehi_diff = 0
let g:changes_sign_hi_style = 0
let g:changes_fast = 0
let g:changes_vcs_check = 1
nnoremap <silent> <leader>dm : ChangesDiffMode<cr>
nnoremap <silent> <leader>ds : ChangesStyleToggle<cr>
if !get(g:, 'changes_sign_text_utf8', 0)
  hi ChangesSignTextAdd ctermbg=green ctermfg=black guibg=green
  hi ChangesSignTextDel ctermbg=red  ctermfg=black guibg=red
  hi ChangesSignTextCh  ctermbg=blue  ctermfg=black guibg=blue
  hi ChangesSignTextDummyCh  ctermfg=NONE ctermbg=blue guifg=NONE guibg=blue
  hi ChangesSignTextDummyAdd ctermfg=NONE ctermbg=green guifg=NONE guibg=green
endif

" LeaderF
let g:Lf_ShortcutF = ''
let g:Lf_ShortcutB = ''
nnoremap <silent> <leader>ff :execute "LeaderfFile " . input("Search directory: ", "", 'dir')<cr>
nnoremap <silent> <leader>fb :LeaderfBuffer<cr>
nnoremap <silent> <leader>ft :LeaderfBufTag<cr>
nnoremap <silent> <leader>fl :LeaderfLine<cr>
nnoremap <silent> <leader>fm :LeaderfMruCwd<cr>
nnoremap <silent> <leader>fh :LeaderfHelp<cr>
nnoremap <silent> <leader>fc :LeaderfCommand<cr>
nnoremap <silent> <leader>fs :LeaderfColorscheme<cr>
nnoremap <silent> <leader>fg :LeaderfGit<cr>
nnoremap <silent> <leader>lq :cclose<bar> LeaderfQuickFix<cr>
nnoremap <silent> <leader>ll :lclose<bar> LeaderfLocList<cr>
nnoremap <silent> <leader>lf :Leaderf file --recall<cr>
nnoremap <silent> <leader>lg :Leaderf gtags --recall<cr>
nnoremap <silent> <leader>lr :Leaderf rg --recall<cr>
let g:Lf_ShowDevIcons = 0
let g:Lf_IgnoreCurrentBufferName = 1
let g:Lf_CommandMap = {'<C-K>': ['<Up>'], '<C-J>': ['<Down>']}
"优先级： Lf_ExternalCommand > Lf_UseVersionControlTool > Lf_DefaultExternalTool
"let g:Lf_ExternalCommand = 'fd --full-path "%s" --type f -I'  "Lf_WildIgnore 对此选项不起作用
let g:Lf_DefaultExternalTool = 'find'            "rg 默认会自动过滤.ignore .rgignore .gitignore中的文件
let g:Lf_UseVersionControlTool = 0               "0: 使用 Lf_DefaultExternalTool 定义的工具搜索文件, 1: 使用当前项目所使用的版本控制工具
let g:Lf_RecurseSubmodules = 1                   "当g:Lf_UseVersionControlTool = 1 时，通过git ls-files --recurse-submodules 来搜索子项目中的文件
let g:Lf_DefaultMode = 'Fuzzy'
let g:Lf_RootMarkers = [$PROJECT_ROOT]
let g:Lf_WorkingDirectoryMode = 'Aa'
let g:Lf_CacheDirectory = expand($HOME.'/.vim/cache')
let g:Lf_UseCache = 1
let g:Lf_NeedCacheTime = 1
let g:Lf_NumberOfCache = 10
let g:Lf_ShowHidden = 0
let g:Lf_WildIgnore = {
            \   'dir': ['.svn','.git','.hg','.vscode','.wine','.deepinwine','.oh-my-zsh','.clangd','.cache'],
            \   'file': ['*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.py[co]','*.tgt','*.x86']
            \}
let g:Lf_MruWildIgnore = {
            \   'dir': ['.svn','.git','.hg','.vscode','.wine','.deepinwine','.oh-my-zsh','.clangd','.cache'],
            \   'file': ['*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.py[co]','*.tgt','*.x86']
            \}
"let g:Lf_WindowPosition = 'popup'
let g:Lf_WindowHeight = 0.40
let g:Lf_PreviewInPopup = 1           "启用预览这个功能 P 弹出窗口
let g:Lf_PreviewPopupWidth = 0        "设置预览窗口大小
let g:Lf_PreviewPosition = 'topright' "设置预览窗口位置
let g:Lf_PreviewResult = {
            \   'File': 0,
            \   'Buffer': 0,
            \   'Mru': 0,
            \   'Tag': 0,
            \   'BufTag': 1,
            \   'Function': 1,
            \   'Line': 0,
            \   'Colorscheme': 0,
            \   'Rg': 1,
            \   'Gtags': 1
            \}
" 默认rg自动忽略.gitignore指定的文件，链接文件，隐藏文件和二进制文件，可通过g:Lf_RgConfig 进行定制
" 忽略当前及子目录下的.git目录的内容，排除当前目录下x86_run,target 目录的内容，
" 排除.map结尾的文件，排除gtags.files，compile_commands.json 文件,可搜索隐藏文件。
" -t: 指定文件类型，-i: 忽略大小写, -g:可指定特定后缀的文件
" -u: 搜索.gitignore 里的文件, -uu: 搜索隐藏文件 , -uuu: 搜索二进制文件
" --unrestricted:当主项目中的.gitignore 文件忽略掉了子项目目录，该选项可以使搜索不受.gitignore 文件的限制，
" --no-ignore: 禁用所有与忽略相关的过滤(.igrore .rgignore .gitignore)
" 在当前仓库搜索子仓库里的内容, 但搜索过程比较慢
let g:Lf_RgConfig = ["--max-columns=150", "--hidden" , "--no-ignore-vcs"]
let g:Lf_RgExGlob = ["**/.git/**", ".clangd/*", "target/*", "*.{map,map2,o,tgt,x86}", "compile_commands.json"]
"Leaderf rg -e<Space>
nnoremap <leader>rg <Plug>LeaderfRgPrompt
nnoremap <leader>rs :LeaderfRgInteractive<cr>
let g:Lf_GitInlineBlameEnable = 0  " show inline blame
" Leaderf git
let g:Lf_GitCommands = [
            \   {"Leaderf git status":                             "show git status"},
            \   {"Leaderf git blame --date relative":              "show relative date when git blame current file"},
            \   {"Leaderf git log --explorer":                     "fuzzy search and view the log in an explorer tabpage"},
            \   {"Leaderf git log --current-file --explorer":      "fuzzy search and view the log of current file in explorer tabpage"},
            \   {"Leaderf git diff --side-by-side":                "fuzzy search and view the side-by-side diffs"},
            \   {"Leaderf git diff HEAD --side-by-side":           "fuzzy search and view the side-by-side diffs of `git diff HEAD`"},
            \ ]
" 项目根目录存在gtags.file文件，gtags 会以该文件为基础生成数据，生成gtags.file的方式参考 g:gutentags_file_list_command
" 或者将要过滤的类型添加到 ~/.globalrc 中的:skip
" 0 - gtags search the target files by itself. 1 - the target files come from FileExplorer. 2 - the target files come from |g:Lf_GtagsfilesCmd.
let g:Lf_GtagsSource = 0
let g:Lf_GtagsfilesCmd = {
            \   '.git': 'git ls-files --recurse-submodules',
            \   '.hg': 'hg files',
            \   'default': 'rg --no-messages --files'
            \}
let g:Lf_CtagsFuncOpts = {
            \   'c': '-I __THROW -I __THROWNL -I __nonnull --fields=+niazS --extras=+q --c-kinds=fp',
            \   'rust': '--rust-kinds=f',
            \ }
let g:Lf_GtagsAutoGenerate = 0           " auto create gtags
let g:Lf_GtagsGutentags = 1              " use vim-gutentags to generate gtags,should make g:Lf_GtagsAutoGenerate = 0
let g:Lf_GtagsAutoUpdate = 1             " auto update when buffer write
let g:Lf_GtagsSkipUnreadable = 1         " skip unreadable files
let g:Lf_GtagsAcceptDotfiles = 0         " not accept hidden files
let g:Lf_GtagsSkipSymlink = 'a'          " f - skip file link, d - skip directorie link, a - skip all link
let g:Lf_Gtagslabel = 'native-pygments'  " gtags 默认 C/C++/Java 等六种原生支持的代码直接使用 gtags 本地分析器，而其他语言使用 pygments 模块。
nnoremap <silent> <leader>gh :Leaderf gtags_history<cr>
"nnoremap <silent> <leader>gc :Leaderf gtags_history --cache<cr>
if get(g:, 'Lf_GtagsAutoGenerate', 0)
  nnoremap <silent> <leader>gu :Leaderf gtags --update<cr>
  " 光标15min内没有发生移动，自动更新gtags文件
  autocmd CursorHold,CursorHoldI * if get(g:, 'autoloaded_startify', 0) | call vimplus#holdtimer(600*1000, 'Leaderf gtags --update') | endif
  " 当文件在外部改变时，自动更新gtags
  autocmd FileChangedShellPost * if get(g:, 'autoloaded_startify', 0) && !vimplus#ignoredbuffer('%') | execute 'Leaderf gtags --update' | endif
endif
if exists('$VIMLSP')
nnoremap <silent> <leader>jd :Leaderf coc definitions --auto-jump<cr>
nnoremap <silent> <leader>jr :Leaderf coc references --auto-jump<cr>
nnoremap <silent> <leader>jc :Leaderf coc declarations --auto-jump<cr>
nnoremap <silent> <leader>ji :Leaderf coc implementations --auto-jump<cr>
nnoremap <silent> <leader>jt :Leaderf coc typeDefinitions --auto-jump<cr>
endif

" vim-gutentags
" gutentags 搜索工程目录的标志，当前文件路径向上递归直到碰到这些文件/目录名
let g:gutentags_project_root = [$PROJECT_ROOT]
let g:gutentags_add_default_project_roots = 0  "不匹配默认的标志
" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile = 'tags'
if executable('fd')
  let g:gutentags_ignore_list = []  " 配置项目需要忽略的目录和文件
  " 在单引号字符串中，单引号 ' 需要用两个单引号 '' 来表示。因此需要将内部的单引号全部替换为两个单引号。
  let s:gutentags_exclude = map(g:Lf_RgExGlob, 'v:val =~ ''^".*"$'' ? v:val : ''"''.v:val.''"''')
  let g:gutentags_file_list_command = "fd --type f --no-ignore-vcs --exclude " . join(s:gutentags_exclude, " --exclude ")
else
  let g:gutentags_ignore_list = {
        \   'dir': ["*.git*", "*clangd*", "*obj*", "./build*", "./target*"],
        \   'file': ["*makefile*", "*.txt", "*.o", ".gitignore"]
        \}
  " -name: 匹配文件名，-iname: 匹配文件名时忽略大小写， -wholename: 匹配文件名及其路径
  let s:gutentags_exclude = map(g:gutentags_ignore_list.dir, 'v:val =~ ''^".*"$'' ? v:val : ''"''.v:val.''"''')
  let g:gutentags_file_list_command = 'find . \( -path ' . join(s:gutentags_exclude, " -o -path ") . '\) -a -prune -o'
  let s:gutentags_exclude = map(g:gutentags_ignore_list.file, 'v:val =~ ''^".*"$'' ? v:val : ''"''.v:val.''"''')
  let g:gutentags_file_list_command .= ' \( -type f -not -iname ' . join(s:gutentags_exclude, " -not -iname ") . '\) -print'
endif
let g:gutentags_ctags_exclude = ['*/.git/*', '*/.clangd/*', '*/configs/*', '*.json', '*.mib', '*.db', '*.css', '*.js', '*.html']
let g:gutentags_ctags_extra_args = ['-I __THROW', '-I __THROWNL', '-I __nonnull']
" i 表示如果有继承, 则标识出父类; a 表示类成员调用权限 (public or private); S 表示如果是函数, 则标识函数的signature.
" --languages:只检索指定类型的语言
let g:gutentags_ctags_extra_args += ['--fields=+niazS', '--languages=c,c++,asm,lua']
" 记录函数声明和各种外部和前向声明
"let g:gutentags_ctags_extra_args += ['--c++-kinds=+px', '--c-kinds=+px']
" 如果使用 universal ctags 需要增加下面一行，老的 Exuberant-ctags 不能加下一行
let g:gutentags_ctags_extra_args += ['--extras=+q', '--output-format=e-ctags']
let g:gutentags_trace = 0
"打开一些特殊的命令GutentagsToggleEnabled,GutentagsToggleTrace
"let g:gutentags_define_advanced_commands = 1
"写更新有时会导致gtags数据丢失部分内容
let g:gutentags_generate_on_missing = 1
let g:gutentags_generate_on_new = 0
autocmd FileType startify let g:gutentags_generate_on_new  = 1
let g:gutentags_generate_on_write = 0
" 同时开启 ctags 和 gtags 支持：
let g:gutentags_modules = []
" generate gtags data to leaderF
let g:gutentags_cache_dir = expand(g:Lf_CacheDirectory.'/LeaderF/gtags/')
if get(g:, 'Lf_GtagsGutentags', 1) && executable('ctags')
  let g:gutentags_modules += ['ctags']
  " 定时器回调执行tjump是同步的，时间过长仍然会卡住vim
  function! TjumpList(...) abort
    execute('tjump '.expand('<cword>'))
  endfunction
  " 默认情况下crl+] 只会跳到tags中的第一个匹配项，通过tjump显示tags中多个匹配项
  noremap <silent> <c-]> :call timer_start(1, function('TjumpList'))<cr>
endif
if get(g:, 'Lf_GtagsGutentags', 1) && executable('gtags-cscope')
  let g:gutentags_modules += ['gtags_cscope']
  " gtags 默认 C/C++/Java 等六种原生支持的代码直接使用 gtags 本地分析器，而其他语言使用 pygments 模块。
  let $GTAGSLABEL = 'native-pygments'
  " 禁用 gutentags 自动加载 gtags 数据库到cscope,避免多个项目生成数据文件在cosope相互影响。
  let g:gutentags_auto_add_gtags_cscope = 0
  nnoremap <silent> <leader>gu :GutentagsUpdate!<cr>
  " 光标10min内没有发生移动，自动更新gtags文件
  autocmd CursorHold,CursorHoldI * if get(g:, 'autoloaded_startify', 0) | call vimplus#holdtimer(600*1000, 'GutentagsUpdate!') | endif
  " 当文件在外部改变时，自动更新gtags
  autocmd FileChangedShellPost * if get(g:, 'autoloaded_startify', 0) && !vimplus#ignoredbuffer('%') | execute 'GutentagsUpdate!' | endif
endif

" OmniCppComplete
set tags=/usr/include/tags         "指定tags搜索路径，补全标准C库
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

" codeium.vim
let g:codeium_enabled = 0               " enable codeium need token
let g:codeium_disable_bindings = 1      " disable default keybindings
let g:codeium_no_map_tab = 1            " disabled Codeium use tab keybindings
imap <script><silent><nowait><expr> <M-=> codeium#Accept()
imap <M--> <Cmd>call codeium#Clear()<CR>
imap <M-,> <Cmd>call codeium#CycleCompletions(-1)<CR>
imap <M-.> <Cmd>call codeium#CycleCompletions(1)<CR>

" vimspector
let g:vimspector_base_dir=expand('$HOME/.config/vimspector')
"let g:vimspector_enable_mappings = 'VISUAL_STUDIO'
nmap <F5>         <Plug>VimspectorContinue
nmap <S-F5>       <Plug>VimspectorStop
nmap <C-F5>       <Plug>VimspectorPause
nmap <F6>         <Plug>VimspectorRestart
nmap <S-F6>       <Plug>VimspectorDisassemble
nmap <F7>         <Plug>VimspectorUpFrame
nmap <S-F7>       <Plug>VimspectorDownFrame
nmap <F8>         <Plug>VimspectorBreakpoints
nmap <S-F8>       <Plug>VimspectorJumpToNextBreakpoint
nmap <C-F8>       <Plug>VimspectorJumpToPreviousBreakpoint
nmap <F9>         <Plug>VimspectorToggleBreakpoint
nmap <S-F9>       <Plug>VimspectorToggleConditionalBreakpoint
nmap <C-F9>       <Plug>VimspectorAddFunctionBreakpoint
nmap <F10>        <Plug>VimspectorStepOver
nmap <S-F10>      <Plug>VimspectorRunToCursor
nmap <C-F10>      <Plug>VimspectorGoToCurrentLine
nmap <F11>        <Plug>VimspectorStepInto
nmap <S-F11>      <Plug>VimspectorStepOut

" coc.nvim
if exists('$VIMLSP')
" 设置 coc.nvim 的配置文件路径
let g:coc_config_home = '~/.vim'
" 自动安装 coc.nvim 扩展
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-json',
  \ 'coc-sh',
  \ 'coc-clangd',
  \ 'coc-rust-analyzer',
  \ 'coc-pyright',
  \ 'coc-lua',
  \ 'coc-marketplace'
  \ ]
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR>
      \ vimplus#ignoredbuffer('%') ? "\<CR>" :
      \ coc#pum#visible() ? coc#pum#confirm()
      \ : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent><nowait> [g <Plug>(coc-diagnostic-prev)
nmap <silent><nowait> ]g <Plug>(coc-diagnostic-next)
" Remap <C-f> and <C-b> to scroll float windows/popups
nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

