#### 如何安装vimplus?

    cd ~
    git clone https://gitee.com/keeferwu/vimplus.git .vimplus
    cd ~/.vimplus
    ./install.sh -i                 # 当前用户安装
    ./install.sh -p                 # 更新所有插件
    sudo ./install.sh -u <用户名>   # 为同一系统中的其他用户安装

#### 如何设置Nerd Font?

    为防止statusline显示乱码，需设置linux终端字体为`Droid Sans Mono Nerd Font`，
    不同的终端有不同的设置方法。

#### 如何配置vim 支持系统剪切板?

    当使用 "+y","+p" 无法将vim的内容复制到终端时
    通过命令 vim --version | grep "clipboard" 查看vim 是否支持系统剪切板
    clipboard 前边是 - 号，即为不支持，ubuntu下可以安装vim-gnome 或其他类型的系统剪切板

    当使用ssh远程连接server，系统剪切版无法使用，查看DISPLAY环境变量为空
    解决办法：
    ssh server 端：修改 /etc/ssh/sshd_config  ---> X11Forwarding yes
    ssh client 端：ssh 连接时使用-Y 或 -X 选项， 并启动Xserver

参考：https://zhuanlan.zhihu.com/p/579860830

#### 如何把vim的配置应用到neovim?

vim .confg/nvim/init.vim

    set runtimepath^=~/.vim runtimepath+=~/.vim/
    let &packpath = &runtimepath
    source ~/.vimrc

#### 如何更新vim-plug?

    curl -fLo ~/.vimplus/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

#### 哪些插件有特殊要求?

defx.nvim 插件需要pynvim的支持,可以选择安装到系统目录或用户目录

    pip3 install pynvim            #普通用户会默认会安装到用户目录，如果要安装到系统目录请使用sudo
    pip3 install --upgrade pynvim  #更新pynvim

OmniCppComplete插件补全标准C需要在/usr/include/ 目录生成tag文件

    cd /usr/include/
    sudo ctags -I __THROW -I __THROWNL -I __nonnull -R --c-kinds=+p  --fields=+iaS --extra=+q

leaderF 插件对c进行更快速的搜索可以Install the C extension

    :LeaderfInstallCExtension
    :echo g:Lf_fuzzyEngine_C   --> if the value is 1, it means the C extension is loaded sucessfully.

Codeium 是一款智能补全插件，需要登录到官网生成token，注意，访问官网需要代理

    :Codeium Auth

vim-gutentags 由于leaderF不支持ctags数据生成，因此使用vim-gutentags生成索引数据到leaderf 缓存目录

    1. 当项目过大时gtags生成数据量比较大，生成的过程也比较长，可通过如下变量过滤掉跟项目中不需要生成索引数据的目录和文件
        let s:gutentags_path_exclude = '\( -path "*.git*" -o -path "*clangd*" -o -path "*obj*" -o -path "*htmlpages*" -o -path "./boot*" -o -path "./os*" -o -path "./image*" -o -path "./x86_run*" -o -path "./target*" \)'
        " -name: 匹配文件名，-iname: 匹配文件名时忽略大小写， -wholename: 匹配文件名及其路径
        let s:gutentags_file_exclude = '\( -type f -not -iname "*makefile*" -not -iname "*.txt" -not -name "*.map" -not -name "*.o" -not -name "*.tgt" -not -name "*.x86" -not -wholename ".gitignore" \)'
        let g:gutentags_ctags_exclude = ['*/.git/*', '*/.clangd/*', '*/configs/*', '*.json', '*.mib', '*.db', '*.css', '*.js', '*.html']

    2. 在项目的子目录下通过新建.root 文件让vim-gutentags 给项目创建多个索引数据
        例：如上在s:gutentags_path_exclude 中已过滤掉了项目的子目录os，因此不会在根目录的索引数据中生成os相关的索引，
        可通过在os目录下新建一个.root文件, 当在vim中访问到 os 下的文件时，会自动生成os下独立的数据索引。

vim-easycomplete 是一个使用LSP补全的插件，需要安装对应语言的LSP server，安装命令：InstallLspServer，安装路径：.config/vim-easycomplete/servers

    1. 插件使用 clangd 补全C/C++ 需要在项目根目录生成compile_commands.json or compile_flags.txt
        Makefile：bear make
        Cmake：cmake (SOURCE_DIR) -DCMAKE_EXPORT_COMPILE_COMMANDS=ON

    2. 如果lua文件中诊断信息过多，会导致lua文件第一次打开时出现短暂卡顿，可在server端关闭一些不重要的诊断类型
        vim .config/vim-easycomplete/servers/lua/extension/server/script/proto/define.lua
        ['unused-local']            = 'Opened',     ---->   'None'
        ['undefined-global']        = 'Any',        ---->   'None'
        ['trailing-space']          = 'Opened',     ---->   'None'

#### 如何让gtags支持更多语言?

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

#### runtimepath包含哪些目录?

runtimepath默认包含以下目录。并非所有这些都必须出现在文件系统中，但如果存在就会被使用。

    ~/.vim   主目录，保存个人偏好的文件。
    /usr/local/share/vim/vimfiles  系统范围的Vim目录，保存由系统管理员决定的文件。
    /usr/local/share/vim/vim81   即$VIMRUNTIME，保存与Vim一起分发的文件。
    /usr/local/share/vim/vimfiles/after     系统范围Vim目录中的“after”目录。系统管理员可以利用该目录来覆盖默认设置，或添加新的设置。
    ~/.vim/after     主目录中的“after”目录。可以利用该目录用个人偏好覆盖默认设置或系统设置，或添加新的设置。

#### 如何高效的使用vimplus?

参考: https://gitee.com/keeferwu/vimplus/wikis/pages
