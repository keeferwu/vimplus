" Vim 内置语法文件里"默认关闭"的高亮开关(opt-in)。
" 变量必须在语法文件加载之前 set → 由 vimrc 里的 call highlight#setup() 在启动时调用。
" 只列布尔开关：c_minlines / lua_version / docbk_ver 这类是数值,不能设成 1。

function! highlight#setup() abort

" C / C++
let g:c_functions           = 1   " 函数名(声明+调用)
let g:c_function_pointers   = 1   " 函数指针
let g:c_comment_strings     = 1   " 注释里的字符串和数字

" Go：默认只有关键字/内建亮，下面这些全靠手动开
let g:go_highlight_functions                = 1
let g:go_highlight_function_calls           = 1
let g:go_highlight_function_parameters      = 1
let g:go_highlight_fields                   = 1
let g:go_highlight_types                    = 1
let g:go_highlight_operators                = 1
let g:go_highlight_extra_types              = 1
let g:go_highlight_build_constraints        = 1
let g:go_highlight_variable_declarations    = 1
let g:go_highlight_variable_assignments     = 1

" Haskell
let g:hs_highlight_types      = 1   " 类型名
let g:hs_highlight_more_types = 1
let g:hs_highlight_boolean    = 1   " True / False
let g:hs_highlight_debug      = 1   " undefined / error / trace

" Groovy
let g:groovy_highlight_functions = 1
let g:groovy_comment_strings     = 1

" D
let g:d_hl_object_types      = 1
let g:d_hl_operator_overload = 1

" Ruby
let g:ruby_operators = 1           " + - == 等运算符

endfunction
