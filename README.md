#### 安装vimplus

    cd ~
    git clone https://gitee.com/keeferwu/vimplus.git .vimplus
    cd ~/.vimplus
    ./install.sh                    #当前用户安装
    ./install.sh -p                 #更新插件
    sudo ./install.sh -u <用户名>   #其他用户安装

#### 使用vimplus

    1.进入项目根目录
    2.使用vim打开项目根目录下的任意一个文件
    3.命令行下使用:Ssave 把项目保存为一个session，此时项目根目录会自动创建一个.root文件，作为vim-gutentags,LeaderF等插件生成索引数据的锚
    4.退出VIM，之后每次只需要在家目录下，使用命令vim （不带参数） 进入start 页，通过选择session 进入对应的项目，进入项目后会自动更新索引数据。
    5.索引数据的更新状态会显示在状态栏，等待索引数据生成完毕后，才可进行索引搜索，注：数据更新过程中不可退出VIM，否则可能会破坏索引数据
    6.更多常用快捷操作可参考vimplus的帮助文档，打开方式：命令行输入 VimplusHelp

#### 设置Nerd Font

为防止Airline等插件显示乱码，需设置linux终端字体为`Droid Sans Mono Nerd Font`。

#### 配置vim 支持系统剪切板

当使用 "+y","+p" 无法将vim的内容复制到终端时
通过命令 vim --version | grep "clipboard" 查看vim 是否支持系统剪切板
clipboard 前边是 - 号，即为不支持，需要安装vim-gnome

    sudo apt install vim-gnome

#### update vim-plug

    curl -fLo ~/.vimplus/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

#### VIM 添加自定义插件

    mkdir -p ~/.vim/pack/自定义名称/start          #插件会自动加载
    mkdir -p ~/.vim/pack/自定义名称/opt
    :packadd 插件脚本                              #加载opt目录下的脚本
    :helptags ~/.vim/pack/自定义名称/opt/插件/doc  #为插件生成帮助文档

#### 把 vim 的配置 应用到 neovim

vim .confg/nvim/init.vim

    set runtimepath^=~/.vim runtimepath+=~/.vim/
    let &packpath = &runtimepath
    source ~/.vimrc


#### 插件特殊需求
* vim-easycomplete 插件使用 clangd 补全C/C++ 需要在项目根目录生成compile_commands.json or compile_flags.txt，可借助 bear工具，

        bear make
        cmake (SOURCE_DIR) -DCMAKE_EXPORT_COMPILE_COMMANDS=ON

* OmniCppComplete插件补全标准C需要在/usr/include/ 目录生成tag文件：

        cd /usr/include/
        sudo ctags -I __THROW -I __THROWNL -I __nonnull -R --c-kinds=+p  --fields=+iaS --extra=+q

* leaderF 插件对c进行更快速的搜索可以Install the C extension

        :LeaderfInstallCExtension
        检查是否安装成功：
        echo g:Lf_fuzzyEngine_C, if the value is 1, it means the C extension is loaded sucessfully.

* Codeium 是一款AI智能插件，需要登录到官方生成token，注意，国内用户需要代理才能访问官网，注册账户

        :Codeium Auth

* vim-gutentags 过滤生成的数据

        1. 当项目过大时gtags生成数据量比较大，生成的过程也比较长，可通过如下变量过滤掉跟项目中不需要生成索引数据的目录和文件
            let s:gutentags_path_exclude = '\( -path "./boot*" -o -path "./os*" -o -path "*.git*" -o -path "*obj*" \)'
            let s:gutentags_file_exclude = '\( -type f -not -iname "*makefile" -not -wholename "*.o" -not -wholename ".gitignore" \)'

        2. 在项目的子文件夹下通过新建.root 文件让vim-gutentags 给项目创建多个索引数据
            例如：项目的子文件夹 os 已在根目录索引中过滤，因此不会在根目录的索引数据中生成os相关的索引，
            可在os目录下新建一个.root文件, 当在vim中访问到 os 下的文件时，会自动生成os下独立的数据索引。

* gtags 支持更多语言

        gtags 原生支持 C/C++/Java ,  如想要更多语言， gtags  可以借助  pygments 支持 50+ 种语言。因此我们要安装 pygments 

        1. 保证你的 $PATH 里面有 python

            pip install pygments

        2. 在vimrc中配置环境变量：

            vim-gutentags:      let $GTAGSLABEL = 'native-pygments'
            LeaderF:            let g:Lf_Gtagslabel = 'native-pygments'

            GTAGSLABEL 告诉 gtags 默认 C/C++/Java 等六种原生支持的代码直接使用 gtags 本地分析器，而其他语言使用 pygments 模块。
            实际使用 pygments 时，gtags 会启动 python 运行名为 pygments_parser.py 的脚本，通过管道和它通信，完成源代码分析，
            故需保证 gtags 能在 $PATH 里调用 python，且这个 python 安装了 pygments 模块。

* gtags 使用自定义配置

        1. 搜索 gtags.conf or gtags.conf.gz(gunzip) 拷贝到家目录.globalrc

            cp /usr/share/doc/global/examples/gtags.conf ~/.globalrc

        2. 如果项目中添加了一些特殊后缀的文件，可通过编辑 .globalrc 来让gtags生成索引

            例如：.hbc和.hbh 生成c索引
            修改 .globalrc
            :langmap=c\:.c.h,yacc\:.y,asm\:.s.S,java\:.java,cpp\:.c++.cc.cpp.cxx.hxx.hpp.C.H,php\:.php.php3.phtml:
            为
            :langmap=c\:.c.h.hbc.hbh,yacc\:.y,asm\:.s.S,java\:.java,cpp\:.c++.cc.cpp.cxx.hxx.hpp.C.H,php\:.php.php3.phtml:

        3. 在vimrc中配置环境变量：

            vim-gutentags:      let $GTAGSCONF = "$HOME/.globalrc"
            LeaderF:            let g:Lf_Gtagsconf = "$HOME/.globalrc"
