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
set cmdheight=2          " 设置命令行的高度
set showcmd              " select模式下显示选中的行数
set ruler                " 总是显示光标位置
set laststatus=2         " 总是显示状态栏
set number               " 开启行号显示
set cursorline           " 高亮显示当前行
set whichwrap+=<,>,h,l   " 设置光标键跨行
set ttimeoutlen=0        " 设置<ESC>键响应时间
set virtualedit=block,onemore   " 允许光标出现在最后一个字符的后面
set bsdir=buffer         " 设定文件浏览器目录为当前目录

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
set hlsearch            " 高亮显示搜索结果
set incsearch           " 开启实时搜索功能
set ignorecase          " 搜索时大小写不敏感

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

" 开启相对行号
" set relativenumber

" 开启鼠标
set mouse=a
set selection=exclusive
set selectmode=mouse,key

" 设置光标所在列高亮
" set cursorcolumn
set colorcolumn =101

if has("nvim")
    " unnamedplus:所有的操作都会自动被粘贴进 system clipboard 中
    " unnamed:必须手动执行 +y 或 +p 等操作,才能复制粘贴到system clipboard 中
    set clipboard+=unnamed
endif

" 复制当前选中到系统剪切板
vnoremap  <silent> <c-c> "+y
" 将系统剪切板内容粘贴到vim
noremap  <silent> <c-v> "+p
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

" 主题设置
set background=dark
let g:onedark_termcolors=256
colorscheme onedark
" 背景透明
"hi Normal  ctermfg=252 ctermbg=none

" 查看vimplus的help文件
nnoremap <leader>h :sview +let\ &l:modifiable=0 ~/.vim/help.md<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" gvim/macvim设置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("gui_running")
    let system = system('uname -s')
    if system == "Darwin\n"
        set guifont=Droid\ Sans\ Mono\ Nerd\ Font\ Complete:h18 " 设置字体
    else
        set guifont=DroidSansMono\ Nerd\ Font\ Regular\ 18      " 设置字体
    endif
    set guioptions-=m           " 隐藏菜单栏
    set guioptions-=T           " 隐藏工具栏
    set guioptions-=L           " 隐藏左侧滚动条
    set guioptions-=r           " 隐藏右侧滚动条
    set guioptions-=b           " 隐藏底部滚动条
    set showtabline=0           " 隐藏Tab栏
    set guicursor=n-v-c:ver5    " 设置光标为竖线
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
Plug 'troydm/easytree.vim'
endif
Plug 'preservim/tagbar'
Plug 'easymotion/vim-easymotion'         "强大的光标快速移动工具，强大到颠覆你的插件观
Plug 'terryma/vim-smooth-scroll'         "让翻页更顺畅
Plug 'vim-autoformat/vim-autoformat'     "代码格式化
Plug 'vim-scripts/indentpython.vim'      "python自动对齐
Plug 'Yggdroot/indentLine'               "显示对齐标线
Plug 'liuchengxu/eleline.vim'            "功能同 airline，比较精简
Plug 'preservim/nerdcommenter'           " 添加注释
Plug 'luochen1990/rainbow'               "彩虹括号
Plug 'justinmk/vim-syntax-extra'         "增强语法高亮
Plug 'octol/vim-cpp-enhanced-highlight'  "cpp扩展高亮
Plug 'chrisbra/changesPlugin'            "修改显示
Plug 'lfv89/vim-interestingwords'        "单词高亮
Plug 'bronson/vim-trailing-whitespace'   "行尾空格
Plug 'camspiers/lens.vim'                "自动调整当前窗口
Plug 'Yggdroot/LeaderF'                  "比ctrlp更强大的文件的模糊搜索工具
Plug 'keeferwu/LeaderF-gtags-history'    "显示leaderf gtags 搜索历史
Plug 'SirVer/ultisnips'                  "需要和vim-snippets or vim-easycomplete 配合使用
Plug 'ludovicchabant/vim-gutentags'      "自动更新tags文件
"Plug 'jayli/vim-easycomplete'            "代码补全 缺点：依赖一些语言端，例如 c/c++ 需要安装 clangd, 注: 由于<c+]>会被重新映射，插件加载需要靠后
Plug 'vim-scripts/OmniCppComplete'       "与vim-easycomplete 冲突,代码补全 可配合supertab一起使用 缺点：tag 中如果有相同名称的结构体，可能会补全出错
Plug 'ervandew/supertab'                 "与vim-easycomplete 冲突
Plug 'honza/vim-snippets'                "与vim-easycomplete 冲突
Plug 'Exafunction/codeium.vim'           "AI智能插件，需要登录获取token才能使用
"Plug 'skywind3000/vim-terminal-help'     "在vim 中打开终端
"Plug 'skywind3000/asyncrun.vim'          "异步运行命令

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
           \ ]


if has("nvim")
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
    nnoremap <silent><buffer><expr> N         defx#do_action('new_file')
    nnoremap <silent><buffer><expr> M         defx#do_action('new_multiple_files')
    nnoremap <silent><buffer><expr> R         defx#do_action('rename')
    nnoremap <silent><buffer><expr> E         defx#do_action('open', 'vsplit')
    nnoremap <silent><buffer><expr> P         defx#do_action('preview')
    nnoremap <silent><buffer><expr> .         defx#do_action('toggle_ignored_files')
    nnoremap <silent><buffer><expr> h         defx#do_action('cd', getcwd())
    nnoremap <silent><buffer><expr> q         defx#do_action('quit')
    nnoremap <silent><buffer><expr> <Space>   defx#do_action('toggle_select') . 'j'
    nnoremap <silent><buffer><expr> *         defx#do_action('toggle_select_all')
    nnoremap <silent><buffer><expr> m         defx#do_action('clear_select_all')
    nnoremap <silent><buffer><expr> <         defx#do_action('resize',  defx#get_context().winwidth - 10)
    nnoremap <silent><buffer><expr> >         defx#do_action('resize',  defx#get_context().winwidth + 10)
endfunction

else
" easytree.vim
function! ToggleEasyTree()
  let g:lens#disabled = 1
    "silent EasyTreeToggle       "根目录
    silent EasyTreeBufferToggle  "当前buffer目录
  let g:lens#disabled = 0
endfunction
nnoremap <silent> <F4> :call ToggleEasyTree()<CR>
let g:easytree_width_auto_fit = 0
let g:easytree_ignore_files = ['*.x86','*.tgt','*.obj']
"let g:easytree_ignore_dirs = []
endif


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


" vim-trailing-whitespace
let g:extra_whitespace_ignored_filetypes = ['startify', 'qf', 'leaderf']
vnoremap <silent><leader><space> : FixWhitespace<cr>
vnoremap <silent><leader><Tab> : SpaceToTab<cr>
vnoremap <silent><leader><S-Tab> : TabToSpace<cr>


" lens
let g:lens#animate = 0  "取消动画
let g:lens#disabled_filetypes = ['easytree', 'defx', 'tagbar']
let g:lens#height_resize_max = 40
let g:lens#height_resize_min = 5
let g:lens#width_resize_max = 120
let g:lens#width_resize_min = 20


" echodoc.vim
let g:echodoc_enable_at_startup = 1


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
let g:autoformat_verbosemode = 1
let g:formatdef_google = '"clang-format -style=google"'              " google 风格的代码
let g:formatdef_allman = '"astyle --style=allman --pad-oper"'        " allman风格的代码：{}读占一行
let g:formatters_cpp = ['allman']
let g:formatters_c = ['allman']


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


" vim-gutentags
"let $GTAGSLABEL = 'native-pygments'   "gtags 默认 C/C++/Java 等六种原生支持的代码直接使用 gtags 本地分析器，而其他语言使用 pygments 模块。
map <c-]> g<c-]>        " 默认情况下crl+] 只会跳到tags中的第一个匹配项，添加该功能，显示tags中多个匹配项, 此项与插件 vim-easycomplete 冲突
" gutentags 搜索工程目录的标志，当前文件路径向上递归直到碰到这些文件/目录名
let g:gutentags_project_root = ['.root', '.project']
let g:gutentags_add_default_project_roots = 0  "不匹配默认的标志
let g:gutentags_file_list_command = 'find ./ \( -path "./os*" -o -path "*.git*" -o -path "./image*" -o -path "./x86_run*" -o -path "./target*" -o -path "*obj*" -o -path "*htmlpages*" \) -a -prune -o \( -type f -not -wholename "*.map" -not -wholename "*.o" -not -wholename "*.tgt" -not -wholename "*.x86" -not -wholename ".gitignore" \) -print'
let g:gutentags_ctags_exclude = ['*./sdk/*','*./boot/*','*./host/*','*./configs/*', '*.json','*.txt','*.mib','*.db','*.lua','*.def']
" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile = '.tags'
" 同时开启 ctags 和 gtags 支持：
let g:gutentags_modules = []
if executable('ctags')
    let g:gutentags_modules += ['ctags']
endif
if executable('gtags-cscope') && executable('gtags')
   let g:gutentags_modules += ['gtags_cscope']
endif
" 将自动生成的 ctags/gtags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags
let g:gutentags_ctags_extra_args = ['-I __THROW', '-I __THROWNL', '-I __nonnull']
let g:gutentags_ctags_extra_args += ['--fields=+niazS', '--extras=+q']
let g:gutentags_ctags_extra_args += ['--language-force=c']
" 为声明生成索引
"let g:gutentags_ctags_extra_args += ['--c++-kinds=+px', '--c-kinds=+px']
" 如果使用 universal ctags 需要增加下面一行，老的 Exuberant-ctags 不能加下一行
let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']
" 使用 gtags-cscope 代替 cscope 等同于 set cscopeprg = 'gtags-cscope'
let g:gutentags_gtags_cscope_executable = 'gtags-cscope'
" 禁用 gutentags 自动加载 gtags 数据库的行为,否则当多个项目生成数据文件后，会相互影响
let g:gutentags_auto_add_gtags_cscope = 0
" 检测 ~/.cache/tags 不存在就新建
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif
"let g:gutentags_trace = 1
"打开一些特殊的命令GutentagsToggleEnabled,GutentagsToggleTrace
"let g:gutentags_define_advanced_commands = 1
let g:gutentags_generate_on_write = 0
let g:gutentags_generate_on_new = 0
"仅有通过startify session 打开文件，gtags数据才进行更新
autocmd FileType startify let g:gutentags_generate_on_new = 1


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
let g:Lf_DefaultExternalTool = 'find'
let g:Lf_UseVersionControlTool = 1  "Lf_UseVersionControlTool = 0 时使用 Lf_DefaultExternalTool 定义的工具搜索文件
let g:Lf_RecurseSubmodules = 1      "当项目中存在子项目时配合g:Lf_UseVersionControlTool = 1 使用，通过git ls-files ----recurse-submodules 来搜索子项目中的文件
let g:Lf_DefaultMode = 'Fuzzy'
let g:Lf_RootMarkers = ['.root', '.project']
let g:Lf_WorkingDirectoryMode = 'Aa'
"let g:Lf_WorkingDirectory = finddir('.root') " 会忽略Lf_RootMarkers，Lf_WorkingDirectoryMode
let g:Lf_UseCache = 1
let g:Lf_NeedCacheTime = 1
let g:Lf_NumberOfCache = 10
let g:Lf_ShowHidden = 0
let g:Lf_WildIgnore = {
            \ 'dir': ['.svn','.git','.hg','.vscode','.wine','.deepinwine','.oh-my-zsh','obj','target'],
            \ 'file': ['*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.py[co]','*.tgt','*.x86']
            \}
let g:Lf_MruWildIgnore = {
            \ 'dir': ['.svn','.git','.hg','.vscode','.wine','.deepinwine','.oh-my-zsh','obj'],
            \ 'file': ['*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.py[co]','*.tgt','*.x86']
            \}
let g:Lf_WindowHeight = 0.40
let g:Lf_PreviewInPopup = 1 "启用预览这个功能 P 弹出窗口
let g:Lf_PreviewPopupWidth = 0  "设置预览窗口大小
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

" 使用leaderf 生成gtags 数据时不正常，考虑在项目跟目录添加gtags.file 文件，内容参考g:gutentags_file_list_command中命令去生成
let g:Lf_GtagsSource = 0     "0 - gtags search the target files by itself.  1 - the target files come from FileExplorer. 2 - the target files come from |g:Lf_GtagsfilesCmd|.
let g:Lf_GtagsfilesCmd = {
            \ '.git': 'git ls-files --recurse-submodules',
            \ '.hg': 'hg files',
            \ 'default': 'rg --no-messages --files'
            \}
let g:Lf_CtagsFuncOpts = {
            \ 'c': '-I __THROW -I __THROWNL -I __nonnull --fields=+niazS --extras=+q --c-kinds=fp',
            \ 'rust': '--rust-kinds=f',
            \ }
" gtags 默认 C/C++/Java 等六种原生支持的代码直接使用 gtags 本地分析器，而其他语言使用 pygments 模块。
let g:Lf_Gtagslabel = 'native-pygments'
let g:Lf_GtagsAutoGenerate = 0 "auto create gtags
let g:Lf_GtagsAutoUpdate = 0   "auto update
let g:Lf_GtagsGutentags = 1
let g:Lf_GtagsSkipUnreadable = 1
let g:Lf_GtagsAcceptDotfiles = 0
nmap <silent><leader>G :Leaderf! gtags --recall<cr>
map <silent> <leader>ga <Plug>LeaderfGtagsInternel
map <silent> <leader>gd <Plug>LeaderfGtagsDefinition
map <silent> <leader>gr <Plug>LeaderfGtagsReference
map <silent> <leader>gs <Plug>LeaderfGtagsSymbol
map <silent> <leader>gg <Plug>LeaderfGtagsGrep
let g:leader_gtags_nomap = 1
nmap <silent><leader>gh :Leaderf gtags_history<cr>

let g:gutentags_cache_dir = expand('~/.cache/LeaderF/gtags')
" Note: use vim-gutentags to generate gtags and use leaderf show result should do 
" g:gutentags_modules += ['gtags_cscope']
" g:gutentags_cache_dir = expand('~/.cache/LeaderF/gtags')
" g:Lf_GtagsAutoGenerate = 0
" g:Lf_GtagsAutoUpdate = 0
" g:Lf_GtagsGutentags = 1

" 默认rg自动忽略.gitignore指定的文件，链接文件，隐藏文件和二进制文件，可通过g:Lf_RgConfig 进行定制
" 忽略当前及子目录下的.git目录的内容，排除当前目录下x86_run,target 目录的内容，
" 排除.map结尾的文件，排除gtags.files，compile_commands.json 文件,可搜索隐藏文件。
" 另外 -t: 指定文件类型，-i: 忽略大小写	 -g:可指定特定后缀的文件
" --unrestricted:主项目中的.ignore 文件忽略掉了子项目目录，该选项可以不受.ignore 文件的限制，
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
vnoremap <silent> <leader>lg y :vimgrep <c-r>" % \| LeaderfQuickFix<cr>
nnoremap <silent> <leader>lg :execute 'vimgrep '.expand("<cword>").' % \| LeaderfQuickFix'<cr>
noremap <silent> <leader>Q :LeaderfQuickFix<cr>


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


" vim-cpp-enhanced-highlight
let g:cpp_class_scope_highlight = 1                    " 高亮显示类的范围
let g:cpp_member_variable_highlight = 0                " 高亮显示成员变量
let g:cpp_class_decl_highlight = 1                     " 高亮显示声明中的类名
let g:cpp_posix_standard = 1                           " 高亮显示POSIX函数
let g:cpp_experimental_simple_template_highlight = 1   " 高亮显示模板函数, 在大文件上可能会有点慢
let g:cpp_experimental_template_highlight = 0          " 高亮显示模板函数, 解决了大文件上慢的问题，但有时会不工作
let g:cpp_concepts_highlight = 1                       " 高亮显示关键字 "concept "和 "requires" 以及标准库名
let g:cpp_no_function_highlight = 0                    " 不高亮显示用户定义的函数


" vim-easycomplete
let g:easycomplete_scheme="dark"
let g:easycomplete_lsp_checking = 1           " check LSP server 是否安装
let g:easycomplete_signature_enable = 1       " lsp signature checking
let g:easycomplete_tabnine_enable = 0         " disable TabNine
let g:easycomplete_diagnostics_enable = 0     " 语法检测


" codeium.vim
let g:codeium_disable_bindings = 1      " disable default keybindings
let g:codeium_no_map_tab = 1            " disabled Codeium use tab keybindings
imap <script><silent><nowait><expr> <M-=> codeium#Accept()
imap <M-->   <Cmd>call codeium#Clear()<CR>
imap <M-[>   <Cmd>call codeium#CycleCompletions(-1)<CR>
imap <M-]>   <Cmd>call codeium#CycleCompletions(1)<CR>


" vim-terminal-help
let g:terminal_rootmarkers = ['.root']
let g:terminal_key = '<m-t>'            " which key will be used to toggle terminal window, default to .<m-=>
let g:terminal_cwd = 2                  " initialize working dir: for unchanged, for file path and for project root.012
let g:terminal_height = 10              " new terminal height, default to 10.
let g:terminal_list = 0                 " set to 0 to hide terminal buffer in the buffer list.
let g:terminal_close = 1                " set to 1 to close window if process finished.


" vim-buffer
noremap <silent> <c-q> :call CloseBuffer(0)<cr>
nnoremap <silent> <leader>d :call CloseBuffer(1)<cr>
autocmd BufAdd * let b:max_buffer_num = 100 | call CloseBuffer(2)
function! CloseBuffer(action)
  if &filetype == "easytree" ||&filetype == "defx" || &filetype == "tagbar" || &filetype == "qf"
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


"nnoremap <F5> :call CompileRunPython()<cr>
func! CompileRunPython()
  exec "w"
  if &filetype == 'python'
    if search("@profile")
        exec "AsyncRun kernprof -l -v %"
        exec "copen"
        exec "wincmd p"
    elseif search("set_trace()")
        exec "!python3 %"
    else
        exec "AsyncRun -raw python3 %"
        exec "copen"
        exec "wincmd p"
    endif
  endif
endfunc

