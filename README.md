#### 版本要求

    vim >= v9.1 or nvim >= v0.11.0

#### 安装vimplus

    如有需要请在clone前备份好原有的.vimrc 和.vim目录

    git clone https://gitee.com/keeferwu/vimplus.git ~/.vim
    cd ~/.vim
    ./install.sh -h                 # install help

    已经验证过的系统有 Ubuntu/LinuxMint/ArchLinux/ManjaroLinux
    其他系统未经验证，可能会存在软件依赖或过时的问题,如果不想解决可以在docker中使用vimplus

#### 在docker中安装vimplus

    1. docker pull ubuntu    #拉取ubuntu镜像
    2. docker run --name <container_name> --network=host -it ubuntu:latest /bin/bash   #创建ubuntu容器
    3. 容器中做如下操作：
        apt update
        apt install -y sudo bash-completion net-tools inetutils-ping
        apt install -y git wget curl tar vim
        useradd -m <user_name>  # 新建用户
        passwd <user_name>      # 设置密码
        usermod -aG sudo <user_name>   #将用户加入到sudo组
        exit #退出容器
    4. docker start <container_name> #再次启动容器
    5. docker exec -u <user_name> -w /home/<user_name> -it <container_name> /bin/bash  #以新用户身份进入容器中的用户家目录
    6. 在容器中执行vimplus的安装步骤

#### 使用vimplus

    1. 查看帮助文档:h vimplus
    2. 空格呼出快捷键导航，使用方法参考wiki页

https://gitee.com/keeferwu/vimplus/wikis/pages

#### 设置Nerd Font

    为防止statusline显示乱码，需设置linux终端字体为`Droid Sans Mono Nerd Font`，
    不同的终端有不同的设置方法。

#### 配置ssh 远程复制粘贴

    通过快捷键ctrl+c,ctrl+v 实现了vim/nvim 对系统剪切板的复制和粘贴。
    当系统剪切板在本地可以正常使用，但通过ssh远程连接时无法使用时，
    查看DISPLAY环境变量是否为空，如何为空解决办法如下：
    ssh server 端：修改 /etc/ssh/sshd_config  ---> X11Forwarding yes
    ssh client 端：ssh 连接时使用-Y 或 -X 选项， 并启动Xserver

参考：https://zhuanlan.zhihu.com/p/579860830

#### 插件列表

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

注：所有使用的插件已打包到 Release 版本中，其中部分插件根据需求做过优化

#### 插件的特殊要求

OmniCppComplete插件补全标准C需要在/usr/include/ 目录生成tag文件

    cd /usr/include/
    sudo ctags -I __THROW -I __THROWNL -I __nonnull -R --c-kinds=+p  --fields=+iaS --extra=+q

leaderF 插件对c进行更快速的搜索可以Install the C extension

    :LeaderfInstallCExtension

Codeium 是一款智能补全插件，需要登录到官网生成token，注意，访问官网需要代理

    :Codeium Auth

vim-gutentags 由于leaderF不支持ctags数据生成，因此使用vim-gutentags生成索引数据到leaderf 缓存目录

    1. 当项目过大时gtags生成数据量比较大，生成的过程也比较长，解决方法：
        将不需要生成索引数据的目录和文件追加到项目根目录下.fdignore 或.ignore(同时对rg,ag 生效) 文件中

    2. 在项目的子目录下通过新建.root 文件让vim-gutentags 给项目创建多个索引数据,实现数据的分割
        例: 将os 所在路径添加到.fdignore文件，在os目录下新建一个.root文件,
        当在vim中访问到 os 下的文件时，会自动生成os下独立的数据索引,与主项目的数据索引分离

    3. gtags 数据生成失败调试方法：
        开启调试信息：let g:gutentags_trace = 1
        手动调试：gtags --gtagslabel native-pygments --skip-unreadable --skip-symlink=a --debug

vimspector 是一个调试插件，需要安装Debug Adapter

    1. :VimspectorInstall <language debug adapter>     #安装adapter

    2. :VimspectorCreateConfig <language template>     #构建.vimspector.json 保存到项目根目录

    3. vimspector.Console 窗口的输出会受dashboard 的.gdbinit配置影响, 需在.vimspector.json中配置"miDebuggerArgs": "--nx" 忽略.gdbinit

配置和使用参考：https://kongjun18.github.io/archives/vimspector-the-best-debug-plugin-for-vim.pdf

coc.nvim 是一个使用LSP补全的插件，需要安装对应语言的LSP server

    1. 将扩展名配置到 g:coc_global_extensions 中，vim/nvim 启动时会自动安装这些扩展对应的语言服务器

    2. 插件使用 clangd 补全C/C++ 需要在项目根目录生成compile_commands.json or compile_flags.txt，生成方法：
        Makefile架构：通过工具bear or compiledb 构建compile_commands.json
        Cmake架构：cmake (SOURCE_DIR) -DCMAKE_EXPORT_COMPILE_COMMANDS=ON

codecompanion.nvim 是一种生产力工具，可简化您在 Neovim 中使用 LLM 进行开发的方式。

    1. 配置文件config.lua 中可以自行扩展模型，目前主要配置的是deepseek。

    2. 将模型对应的API key添加到环境变量中，例如：export DEEPSEEK_API_KEY=<your key>

配置和使用参考：https://codecompanion.olimorris.dev/

#### 配置gtags支持更多语言

gtags 原生支持 C/C++/Java ,  如想要更多语言， gtags  可以借助  pygments 支持 50+ 种语言。因此我们要安装 pygments

    1. 保证你的 $PATH 里面有 python

        pip install pygments 或 sudo apt install python-pygments

    2. 在vimrc中配置环境变量：

        vim-gutentags:      let $GTAGSLABEL = 'native-pygments'
        LeaderF:            let g:Lf_Gtagslabel = 'native-pygments'

        GTAGSLABEL 告诉 gtags 默认 C/C++/Java 等六种原生支持的代码直接使用 gtags 本地分析器，而其他语言使用 pygments 模块。
        实际使用 pygments 时，gtags 会启动 python 运行名为 pygments_parser.py 的脚本，通过管道和它通信，完成源代码分析，
        故需保证 gtags 能在 $PATH 里调用 python，且这个 python 安装了 pygments 模块,
        否则会出错：ImportError: No module named pygments.lexers。
        如果生成gtags的过程中卡住，通过gtags --gtagslabel native-pygments --debug 开启debug手动去生成gtags数据，可观察到
        在哪个文件处被卡住，多数情况是某种类型的文件无法被pygments解析，可通过将pygments降级或升级后再尝试

gtags 添加自定义配置

    1. 搜索 gtags.conf or gtags.conf.gz(gunzip) 拷贝到家目录.globalrc

        cp /usr/share/doc/global/examples/gtags.conf ~/.globalrc

    2. 如果项目中添加了一些特殊后缀的文件，可通过编辑 .globalrc 来让gtags生成索引

        例如：.hbc和.hbh 生成c索引
        修改 .globalrc
        :langmap=c\:.c.h,yacc\:.y,asm\:.s.S,java\:.java,cpp\:.c++.cc.cpp.cxx.hxx.hpp.C.H,php\:.php.php3.phtml:
        ---->
        :langmap=c\:.c.h.hbc.hbh,yacc\:.y,asm\:.s.S,java\:.java,cpp\:.c++.cc.cpp.cxx.hxx.hpp.C.H,php\:.php.php3.phtml:

    3. 在vimrc中配置环境变量：

        vim-gutentags:      let $GTAGSCONF = expand("~/.globalrc")
        LeaderF:            let g:Lf_Gtagsconf = expand("~/.globalrc")

