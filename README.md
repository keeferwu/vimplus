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

