基于源码 https://github.com/chxuan/vimplus.git 修改，适用于 c/c++ 开发语言

#### 安装vimplus

    cd ~
    git clone https://gitee.com/keeferwu/vimplus.git .vimplus
    cd ~/.vimplus
    ./install.sh //不加sudo

#### 多用户支持

将vimplus在某个用户下安装好后，若需要在其他用户也能够使用vimplus，则执行

    sudo ./install_to_user.sh username1 username2 //替换为真实用户名

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

#### 一些插件的注意事项

gutentags，leaderF 插件需要在项目根目录创建.root 或.project
vim-easycomplete 插件需要安装 clangd，bear工具，在项目根目录生成compile_commands.json or compile_flags.txt 才能正常补全

    bear make
    cmake (SOURCE_DIR) -DCMAKE_EXPORT_COMPILE_COMMANDS=ON

OmniCppComplete插件补全标准C需要在/usr/include/ 目录生成tag文件：

    cd /usr/include/
    sudo ctags -I __THROW -I __THROWNL -I __nonnull -R --c-kinds=+p  --fields=+iaS --extra=+q

注：若vim-gutentags 插件生成db 文件时失败考虑添加如下内容：

	let l:file_list_cmd = gutentags#get_project_file_list_cmd(a:proj_dir)
	if !empty(l:file_list_cmd)
        exec 'silent !'.l:file_list_cmd.' > gtags.files'
    endif

leaderF 插件对c进行更快速的搜索可以Install the C extension

	:LeaderfInstallCExtension

检查是否安装成功：

    echo g:Lf_fuzzyEngine_C, if the value is 1, it means the C extension is loaded sucessfully.

Codeium 是一款AI智能插件，需要科学上网后登录到官方生成token 类似于：
	eyJhbGciOiJSUzI1NiIsImtpZCI6ImI2NzE1ZTJmZjcxZDIyMjQ5ODk1MDAyMzY2ODMwNDc3Mjg2Nzg0ZTMiLCJ0eXAiOiJKV1QifQ.eyJuYW1lIjoia2VlZmVyIHd1IiwicGljdHVyZSI6Imh0dHBzOi8vbGgzLmdvb2dsZXVzZXjltvA9bNUbX2B2-vDJtyq8WDlQYu2iA-QCatwvRpPbYfIXuPz39FO1S-6IRKnfOsH9mSU2E5M3nsqeDHvUlKMoFu91ELKqkEzdJSA0IC9xIsl12Zew7mGixPso3scce9ZUPAeVoX01tfapSM4sAtSe2hZ-eivvHo1UV53eCJ0cYxqMraGKK3b4HmbOpdt4wkyyspfpx3_mDjdGkQQ634AZ4rv0d4TiHKXe8hecB80rlrXXtK-pjw

#### gtags 支持更多语言

gtags 原生支持 C/C++/Java  如想要更多语言，那么 gtags 是支持使用 ctags/universal-ctags 或者 pygments 来作为分析前端支持 50+ 种语言。
使用 ctags/universal-ctags 作为前端只能生成定义索引不能生成引用索引，因此我们要安装 pygments ，
1 保证你的 $PATH 里面有 python

    pip install pygments

2 保证 Vim 里要设置过两个环境变量才能正常工作：

    vim-gutentags:      let $GTAGSLABEL = 'native-pygments'
    LeaderF:            let g:Lf_Gtagslabel = 'native-pygments'

GTAGSLABEL 告诉 gtags 默认 C/C++/Java 等六种原生支持的代码直接使用 gtags 本地分析器，而其他语言使用 pygments 模块。
实际使用 pygments 时，gtags 会启动 python 运行名为 pygments_parser.py 的脚本，
通过管道和它通信，完成源代码分析，故需保证 gtags 能在 $PATH 里调用 python，且这个 python 安装了 pygments 模块。

3 搜索 gtags.conf or gtags.conf.gz(gunzip) 拷贝到家目录.globalrc

    cp /usr/share/doc/global/examples/gtags.conf ~/.globalrc

4 如果项目中添加了一些特殊后缀的文件，可通过编辑 .globalrc 来让gtags生成索引

    例如：.hbc和.hbh 生成c索引
    修改 .globalrc
    :langmap=c\:.c.h,yacc\:.y,asm\:.s.S,java\:.java,cpp\:.c++.cc.cpp.cxx.hxx.hpp.C.H,php\:.php.php3.phtml:
    为
    :langmap=c\:.c.h.hbc.hbh,yacc\:.y,asm\:.s.S,java\:.java,cpp\:.c++.cc.cpp.cxx.hxx.hpp.C.H,php\:.php.php3.phtml:


#### 在VIM 中对python进行调试

    nnoremap <F5> :call CompileRunPython()<cr>
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

运行使用了vim 8.0的异步机制，所以确保你的vim版本不低于8.0
并且使用了vim插件：AsyncRun

    Plug 'skywind3000/asyncrun.vim'

实际在使用时，按下F5，会打开quickfix窗口，在后台运行python，并且不会影响继续编写代码，
等待代码执行完成时，便会将程序执行结果显示在quickfix中。
调试时在程序中加入set_trace()语句，具体调用pdb还是pudb取决于程序import了哪个。按下F5会自动调用调试
性能测试使用的是line_profiler，安装方式：

    pip install line_profiler

使用时在程序的要测试的函数上一行加入@profile 按下F5，便会给出这个函数中具体每一行执行的时间、次数


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

