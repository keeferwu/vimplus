基于源码 https://github.com/chxuan/vimplus.git 修改，适用于 c/c++ 开发语言

#### 安装vimplus

    cd ~
    git clone https://gitee.com/keeferwu/vimplus.git .vimplus
    cd ~/.vimplus
    ./install.sh //不加sudo

#### 更新插件

    ./update_plugged.sh

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

* Codeium 是一款AI智能插件，需要登录到官方生成token，由于官网国内无法访问，所以需要科学上网来注册账户。

        :Codeium Auth

#### gtags 支持更多语言

gtags 原生支持 C/C++/Java ,  如想要更多语言， gtags  可以借助  pygments 支持 50+ 种语言。因此我们要安装 pygments 

* 保证你的 $PATH 里面有 python

        pip install pygments

* 保证 Vim 里要设置过两个环境变量才能正常工作：

        vim-gutentags:      let $GTAGSLABEL = 'native-pygments'
        LeaderF:            let g:Lf_Gtagslabel = 'native-pygments'

    GTAGSLABEL 告诉 gtags 默认 C/C++/Java 等六种原生支持的代码直接使用 gtags 本地分析器，而其他语言使用 pygments 模块。
    实际使用 pygments 时，gtags 会启动 python 运行名为 pygments_parser.py 的脚本，通过管道和它通信，完成源代码分析，故需保证 gtags 能在 $PATH 里调用 python，且这个 python 安装了 pygments 模块。

* 搜索 gtags.conf or gtags.conf.gz(gunzip) 拷贝到家目录.globalrc

        cp /usr/share/doc/global/examples/gtags.conf ~/.globalrc

* 如果项目中添加了一些特殊后缀的文件，可通过编辑 .globalrc 来让gtags生成索引

        例如：.hbc和.hbh 生成c索引
        修改 .globalrc
        :langmap=c\:.c.h,yacc\:.y,asm\:.s.S,java\:.java,cpp\:.c++.cc.cpp.cxx.hxx.hpp.C.H,php\:.php.php3.phtml:
        为
        :langmap=c\:.c.h.hbc.hbh,yacc\:.y,asm\:.s.S,java\:.java,cpp\:.c++.cc.cpp.cxx.hxx.hpp.C.H,php\:.php.php3.phtml:
