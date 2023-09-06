#!/usr/bin/env bash

# 获取linux发行版名称
function get_linux_distro()
{
    if grep -Eq "Ubuntu" /etc/*-release; then
        echo "Ubuntu"
    elif grep -Eq "Deepin" /etc/*-release; then
        echo "Deepin"
    elif grep -Eq "Raspbian" /etc/*-release; then
        echo "Raspbian"
    elif grep -Eq "uos" /etc/*-release; then
        echo "UOS"
    elif grep -Eq "LinuxMint" /etc/*-release; then
        echo "LinuxMint"
    elif grep -Eq "elementary" /etc/*-release; then
        echo "elementaryOS"
    elif grep -Eq "Debian" /etc/*-release; then
        echo "Debian"
    elif grep -Eq "Kali" /etc/*-release; then
        echo "Kali"
    elif grep -Eq "Parrot" /etc/*-release; then
        echo "Parrot"
    elif grep -Eq "CentOS" /etc/*-release; then
        echo "CentOS"
    elif grep -Eq "fedora" /etc/*-release; then
        echo "fedora"
    elif grep -Eq "openSUSE" /etc/*-release; then
        echo "openSUSE"
    elif grep -Eq "Arch Linux" /etc/*-release; then
        echo "ArchLinux"
    elif grep -Eq "ManjaroLinux" /etc/*-release; then
        echo "ManjaroLinux"
    elif grep -Eq "Gentoo" /etc/*-release; then
        echo "Gentoo"
    else
        echo "Unknow"
    fi
}

# 获取日期
function get_datetime()
{
    time=$(date "+%Y%m%d%H%M%S")
    echo $time
}

# 判断文件是否存在
function is_exist_file()
{
    filename=$1
    if [ -f $filename ]; then
        echo 1
    else
        echo 0
    fi
}

# 判断目录是否存在
function is_exist_dir()
{
    dir=$1
    if [ -d $dir ]; then
        echo 1
    else
        echo 0
    fi
}

# 安装配置文件
function install_config_files()
{
    vimrc_file=$HOME"/.vimrc"
    vimrc_exist=$(is_exist_file $vimrc_file)
    if [ $vimrc_exist == 1 ]; then
        rm -rf $vimrc_file
    fi
    ln -s ${PWD}/vimrc    $vimrc_file

    vim_dir=$HOME"/.vim"
    vim_exist=$(is_exist_dir $vim_dir)
    if [ $vim_exist == 1 ]; then
        rm -rf $vim_dir
    fi
    mkdir $vim_dir
    ln -s ${PWD}/help.md  $vim_dir
    ln -s ${PWD}/colors   $vim_dir
    ln -s ${PWD}/ftplugin $vim_dir
    ln -s ${PWD}/autoload $vim_dir
    ln -s ${PWD}/plugged  $vim_dir
}

# 获取ubuntu版本
function get_ubuntu_version()
{
    line=$(cat /etc/lsb-release | grep "DISTRIB_RELEASE")
    arr=(${line//=/ })
    version=(${arr[1]//./ })

    echo ${version[0]}
}

# 获取centos版本
function get_centos_version()
{
    version=`cat /etc/redhat-release | awk '{print $4}' | awk -F . '{printf "%s",$1}'`
    echo $version
}

# 判断是否是macos10.14版本
function is_macos1014()
{
    product_version=$(sw_vers | grep ProductVersion)
    if [[ $product_version =~ "10.14" ]]; then
        echo 1
    else
        echo 0
    fi
}

# 在ubuntu上源代码安装vim
function compile_vim_on_ubuntu()
{
    sudo apt-get remove vim
    sudo apt-get remove vim-runtime
    sudo apt-get remove vim -tiny
    sudo apt-get remove vim-common

    sudo apt-get install -y libncurses5-dev libncurses5 libgnome2-dev libgnomeui-dev \
        libgtk2.0-dev libatk1.0-dev libbonoboui2-dev \
        libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev python3-dev ruby-dev lua5.1 lua5.1-dev

    rm -rf ~/vim_source
    git clone https://github.com/vim/vim.git ~/vim_source
    cd ~/vim_source
    ./configure --with-features=huge \
            --enable-multibyte \
            --enable-rubyinterp=yes \
            --enable-pythoninterp=yes \
            --with-python-config-dir=/usr/lib/python2.7/config \
            --enable-python3interp=yes \
            --with-python3-config-dir=/usr/lib/python3.5/config \
            --enable-perlinterp=yes \
            --enable-luainterp=yes \
            --enable-gui=gtk2 \
            --enable-cscope \
            --prefix=/usr/local/vim8

    sudo make
    sudo make install

    sudo update-alternatives --install /usr/bin/editor editor /usr/local/vim8/bin/vim 1
    sudo update-alternatives --set editor /usr/local/vim8/bin/vim
    sudo update-alternatives --install /usr/bin/vim vim /usr/local/vim8/bin/vim 1
    sudo update-alternatives --set vim /usr/local/vim8/bin/vim

    cd -
}

# 在debian上源代码安装vim
function compile_vim_on_debian()
{
    sudo apt-get install -y libncurses5-dev libncurses5 libgtk2.0-dev libatk1.0-dev libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev python3-dev ruby-dev lua5.1 lua5.1-dev

    rm -rf ~/vim_source
    git clone https://github.com/vim/vim.git ~/vim_source
    cd ~/vim_source
    ./configure --with-features=huge \
        --enable-multibyte \
        --enable-rubyinterp \
        --enable-pythoninterp \
        --enable-perlinterp \
        --enable-luainterp \
        --enable-gui=gtk2 \
        --enable-cscope \
        --prefix=/usr
    make
    sudo make install
    cd -
}

# 在parrot上源代码安装vim
function compile_vim_on_parrot()
{
    sudo apt-get install -y libncurses5-dev libncurses5 libgtk2.0-dev libatk1.0-dev libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev python3-dev ruby-dev lua5.1 vim

    rm -rf ~/vim_source
    git clone https://github.com/vim/vim.git ~/vim_source
    cd ~/vim_source
    ./configure --with-features=huge \
        --enable-multibyte \
        --enable-rubyinterp \
        --enable-pythoninterp \
        --enable-perlinterp \
        --enable-luainterp \
        --enable-gui=gtk2 \
        --enable-cscope \
        --prefix=/usr
    make
    sudo make install
    cd -
}

# 在centos上源代码安装vim
function compile_vim_on_centos()
{
    sudo yum install -y ruby ruby-devel lua lua-devel luajit \
        luajit-devel ctags git python python-devel \
        python34 python34-devel tcl-devel \
        perl perl-devel perl-ExtUtils-ParseXS \
        perl-ExtUtils-XSpp perl-ExtUtils-CBuilder \
        perl-ExtUtils-Embed libX11-devel ncurses-devel

    rm -rf ~/vim_source
    git clone https://github.com/vim/vim.git ~/vim_source
    cd ~/vim_source
    ./configure --with-features=huge \
        --enable-multibyte \
        --with-tlib=tinfo \
        --enable-rubyinterp=yes \
        --enable-pythoninterp=yes \
        --enable-perlinterp=yes \
        --enable-luainterp=yes \
        --enable-gui=gtk2 \
        --enable-cscope \
        --prefix=/usr
    make
    sudo make install
    cd -
}

# 安装mac平台必备软件
function install_prepare_software_on_mac()
{
    xcode-select --install

    brew install vim gcc cmake ctags-exuberant ack

    macos1014=$(is_macos1014)
    if [ $macos1014 == 1 ]; then
        open /Library/Developer/CommandLineTools/Packages/macOS_SDK_headers_for_macOS_10.14.pkg
    fi
}

# 安装FreeBSD必备软件
function install_prepare_software_on_freebsd()
{
    sudo pkg install -y vim ctags automake gcc cmake p5-ack python git fontconfig
}

# 安装android平台必备软件
function install_prepare_software_on_android()
{
    pkg update
    pkg install -y git vim-python cmake python2 python ctags ack-grep ncurses-utils
}

# 安装ubuntu必备软件
function install_prepare_software_on_ubuntu()
{
    sudo apt-get update

    version=$(get_ubuntu_version)
    if [ $version -eq 14 ];then
        sudo apt-get install -y cmake3
    else
        sudo apt-get install -y cmake
    fi

    sudo apt-get install -y  ninja-build gcc-multilib autoconf automake libtool flex bison

    sudo apt-get install -y  build-essential python python-dev python3 python3-dev python3-pip fontconfig libfile-next-perl

    sudo apt-get install -y  universal-ctags ripgrep clang astyle ccls global xclip
    
    read -p "Do you want to re-install VIM ? [Y/N] " ch
    if [[ $ch == "Y" ]] || [[ $ch == "y" ]]; then
        if [ $version -ge 18 ];then
            sudo add-apt-repository ppa:jonathonf/vim
            sudo apt-get update
            sudo apt-get install -y vim
        else
            compile_vim_on_ubuntu
        fi
    fi

    if which nvim >/dev/null 2>&1; then
        nvim_version=`nvim --version | head -n 1 | awk '{print $2}'`
        echo "Current nvim vession is $nvim_version"
        read -p "Do you want to re-install NEOVIM(0.8.3) ? [Y/N] " ch
        if [[ $ch == "Y" ]] || [[ $ch == "y" ]]; then
            wget https://gitee.com/keeferwu/vimplus/releases/download/append/nvim-linux64-0.8.3.deb
            sudo apt remove neovim --purge
            sudo dpkg -i nvim-linux64-0.8.3.deb
            rm nvim-linux64-0.8.3.deb
        fi
    else
        wget https://gitee.com/keeferwu/vimplus/releases/download/append/nvim-linux64-0.8.3.deb
        sudo dpkg -i nvim-linux64-0.8.3.deb
        rm nvim-linux64-0.8.3.deb
    fi
}

# 安装ubuntu系必备软件
function install_prepare_software_on_ubuntu_like()
{
    sudo apt-get update
    sudo apt-get install -y cmake exuberant-ctags build-essential python python-dev python3-dev fontconfig libfile-next-perl ack-grep git
    compile_vim_on_ubuntu
}

# 安装debian必备软件
function install_prepare_software_on_debian()
{
    sudo apt-get update
    sudo apt-get install -y cmake exuberant-ctags build-essential python python-dev python3-dev fontconfig libfile-next-perl ack git
    compile_vim_on_debian
}

# 安装parrot必备软件
function install_prepare_software_on_parrot()
{
    sudo apt-get update
    sudo apt-get install -y cmake exuberant-ctags build-essential python python-dev python3-dev fontconfig libfile-next-perl ack git
    compile_vim_on_parrot
}

# 安装centos必备软件
function install_prepare_software_on_centos()
{
    version=$(get_centos_version)
    if [ $version -ge 8 ];then
        sudo dnf install -y epel-release
        sudo dnf install -y vim ctags automake gcc gcc-c++ kernel-devel make cmake python2 python2-devel python3-devel fontconfig ack git
    else
        sudo yum install -y ctags automake gcc gcc-c++ kernel-devel cmake python-devel python3-devel fontconfig ack git
        compile_vim_on_centos
    fi
}

# 安装fedora必备软件
function install_prepare_software_on_fedora()
{
    sudo dnf install -y vim ctags automake gcc gcc-c++ kernel-devel cmake python-devel python3-devel fontconfig ack git
}

# 安装archlinux必备软件
function install_prepare_software_on_archlinux()
{
    sudo pacman -S --noconfirm vim ctags automake gcc cmake python3 python2 ack git fontconfig
    sudo ln -s /usr/lib/libtinfo.so.6 /usr/lib/libtinfo.so.5
}

# 安装gentoo必备软件
function install_prepare_software_on_gentoo()
{
    install_software_on_gentoo app-editors/vim dev-util/ctags sys-devel/automake sys-devel/gcc dev-util/cmake sys-apps/ack dev-vcs/git media-libs/fontconfig
    su - -c "ln -s /usr/lib/libtinfo.so.6 /usr/lib/libtinfo.so.5" -s /bin/bash
}

function install_software_on_gentoo()
{
    pkgs=$*
    pkg_need_install=""
    for pkg in ${pkgs}
    do
        if qlist -I | grep -Eq $pkg; then
            echo "$pkg is already installed."
        else
            pkg_need_install="$pkg_need_install $pkg"
        fi
    done

    if sudo -l | grep -Eq "emerge"; then
        sudo emerge -v $pkg_need_install 
    else
        echo "Need Root password:"
        su - -c "emerge -v $pkg_need_install" -s /bin/bash
    fi
}

# 安装opensuse必备软件
function install_prepare_software_on_opensuse()
{
    sudo zypper install -y vim ctags gcc gcc-c++ cmake python-devel python3-devel ack fontconfig git ncurses5-devel
}

# 安装mac平台字体
function install_fonts_on_mac()
{
    rm -rf ~/Library/Fonts/Droid\ Sans\ Mono\ Nerd\ Font\ Complete.otf
    cp ./fonts/Droid\ Sans\ Mono\ Nerd\ Font\ Complete.otf ~/Library/Fonts
}

# 安装android平台字体
function install_fonts_on_android()
{
    rm -rf ~/.termux/font.ttf
    mkdir ~/.termux
    cp ./fonts/DejaVu.ttf ~/.termux/font.ttf

    # 刷新style
    REL="am broadcast --user 0 -a com.termux.app.reload_style com.termux"
    $REL > /dev/null
}

# 安装linux平台字体
function install_fonts_on_linux()
{
    mkdir -p ~/.local/share/fonts
    rm -rf ~/.local/share/fonts/Droid\ Sans\ Mono\ Nerd\ Font\ Complete.otf
    cp ./fonts/Droid\ Sans\ Mono\ Nerd\ Font\ Complete.otf ~/.local/share/fonts

    fc-cache -vf ~/.local/share/fonts
}

# 安装vim插件
function install_vim_plugin()
{
    PLUGDIR=${PWD}/plugged
    if [ ! -d $PLUGDIR ]; then
        wget https://gitee.com/keeferwu/vimplus/releases/download/append/plugged.tar.gz
        tar -xzf ${PWD}/plugged.tar.gz && rm plugged.tar.gz
        sudo chown $USER:$USER $PLUGDIR -R
    fi

    vim -c "PlugInstall" -c "q" -c "q"
}

# 安装ycm插件
function install_ycm()
{
    read -p "Do you want to install YCM ? [Y/N] " ch
    if [[ $ch == "Y" ]] || [[ $ch == "y" ]]; then
        rm -rf ~/.ycm_extra_conf.py
        ln -s ${PWD}/.ycm_extra_conf.py ~
        git clone https://gitee.com/chxuan/YouCompleteMe-clang.git ~/.vim/plugged/YouCompleteMe
        cd ~/.vim/plugged/YouCompleteMe
        read -p "Please choose to compile ycm with python2 or python3, if there is a problem with the current selection, please choose another one. [2/3] " version
        if [[ $version == "2" ]]; then
            echo "Compile ycm with python2."
            {
                python2.7 ./install.py --clang-completer
            } || {
                echo "##########################################"
                echo "Build error, trying rebuild without Clang."
                echo "##########################################"
                python2.7 ./install.py
            }
        else
            echo "Compile ycm with python3."
            {
                python3 ./install.py --clang-completer
            } || {
                echo "##########################################"
                echo "Build error, trying rebuild without Clang."
                echo "##########################################"
                python3 ./install.py
            }
        fi
    fi
}

# 在android上安装ycm插件
function install_ycm_on_android()
{
    read -p "Do you want to install YCM ? [Y/N] " ch
    if [[ $ch == "Y" ]] || [[ $ch == "y" ]]; then
        rm -rf ~/.ycm_extra_conf.py
        ln -s ${PWD}/.ycm_extra_conf.py ~
        git clone https://gitee.com/chxuan/YouCompleteMe-clang.git ~/.vim/plugged/YouCompleteMe
        cd ~/.vim/plugged/YouCompleteMe
        read -p "Please choose to compile ycm with python2 or python3, if there is a problem with the current selection, please choose another one. [2/3] " version
        if [[ $version == "2" ]]; then
            echo "Compile ycm with python2."
            python2.7 ./install.py --clang-completer --system-libclang
        else
            echo "Compile ycm with python3."
            python3 ./install.py --clang-completer --system-libclang
        fi
    fi
}

# 打印logo
function print_logo()
{
    color="$(tput setaf 6)"
    normal="$(tput sgr0)"
    printf "${color}"
    echo '        __                __           '
    echo '__   __/_/___ ___  ____  / /_  _______ '
    echo '\ \ / / / __ `__ \/ __ \/ / / / / ___/ '
    echo ' \ V / / / / / / / /_/ / / /_/ (__  )  '
    echo '  \_/_/_/ /_/ /_/ ,___/_/\____/____/   '
    echo '               /_/                     ...is now installed!'
    echo ''
    echo ''
    echo 'Just enjoy it!'
    echo ''
    printf "${normal}"
}

# 在mac平台安装vimplus
function install_vimplus_on_mac()
{
    install_prepare_software_on_mac
    install_config_files
    install_fonts_on_mac
    #install_ycm
    install_vim_plugin
    print_logo
}

# 在FreeBSD上安装vimplus
function install_vimplus_on_freebsd()
{
    install_prepare_software_on_freebsd
    begin_install_vimplus
}

# 在android平台安装vimplus
function install_vimplus_on_android()
{
    install_prepare_software_on_android
    install_config_files
    install_fonts_on_android
    #install_ycm_on_android
    install_vim_plugin
    print_logo
}

# 开始安装vimplus
function begin_install_vimplus()
{
    install_config_files
    install_fonts_on_linux
    #install_ycm
    install_vim_plugin
    print_logo
}

# 在ubuntu上安装vimplus
function install_vimplus_on_ubuntu()
{
    install_prepare_software_on_ubuntu
    begin_install_vimplus
}

# 在ubuntu系上安装vimplus
function install_vimplus_on_ubuntu_like()
{
    install_prepare_software_on_ubuntu_like
    begin_install_vimplus
}

# 在debian上安装vimplus
function install_vimplus_on_debian()
{
    install_prepare_software_on_debian
    begin_install_vimplus
}

# 在parrot上安装vimplus
function install_vimplus_on_parrot()
{
    install_prepare_software_on_parrot
    begin_install_vimplus
}

# 在centos上安装vimplus
function install_vimplus_on_centos()
{
    install_prepare_software_on_centos
    begin_install_vimplus
}

# 在fedora上安装vimplus
function install_vimplus_on_fedora()
{
    install_prepare_software_on_fedora
    begin_install_vimplus
}

# 在archlinux上安装vimplus
function install_vimplus_on_archlinux()
{
    install_prepare_software_on_archlinux
    begin_install_vimplus
}

# 在Gentoo上安装vimplus
function install_vimplus_on_gentoo()
{
    install_prepare_software_on_gentoo
    begin_install_vimplus
}

# 在opensuse上安装vimplus
function install_vimplus_on_opensuse()
{
    install_prepare_software_on_opensuse
    begin_install_vimplus
}

# 在linux平上台安装vimplus
function install_vimplus_on_linux()
{
    distro=`get_linux_distro`
    echo "Linux distro: "${distro}

    if [ ${distro} == "Ubuntu" ]; then
        install_vimplus_on_ubuntu
    elif [ ${distro} == "Deepin" ]; then
        install_vimplus_on_ubuntu_like
    elif [ ${distro} == "LinuxMint" ]; then
        install_vimplus_on_ubuntu_like
    elif [ ${distro} == "elementaryOS" ]; then
        install_vimplus_on_ubuntu_like
    elif [ ${distro} == "Debian" ]; then
        install_vimplus_on_debian
    elif [ ${distro} == "Raspbian" ]; then
        install_vimplus_on_debian
    elif [ ${distro} == "UOS" ]; then
        install_vimplus_on_debian
    elif [ ${distro} == "Kali" ]; then
        install_vimplus_on_debian
    elif [ ${distro} == "Parrot" ]; then
        install_vimplus_on_parrot
    elif [ ${distro} == "CentOS" ]; then
        install_vimplus_on_centos
    elif [ ${distro} == "fedora" ]; then
        install_vimplus_on_fedora
    elif [ ${distro} == "openSUSE" ]; then
        install_vimplus_on_opensuse
    elif [ ${distro} == "ArchLinux" ]; then
        install_vimplus_on_archlinux
    elif [ ${distro} == "ManjaroLinux" ]; then
        install_vimplus_on_archlinux
    elif [ ${distro} == "Gentoo" ]; then
        install_vimplus_on_gentoo
    else
        echo "Not support linux distro: "${distro}
    fi
}

# 获取当前时间戳
function get_now_timestamp()
{
    cur_sec_and_ns=`date '+%s-%N'`
    echo ${cur_sec_and_ns%-*}
}

# main函数
function main()
{
    begin=`get_now_timestamp`

    type=$(uname)
    echo "Platform type: "${type}

    if [ ${type} == "Darwin" ]; then
        install_vimplus_on_mac
    elif [ ${type} == "FreeBSD" ]; then
        install_vimplus_on_freebsd
    elif [ ${type} == "Linux" ]; then
        tp=$(uname -a)
        if [[ $tp =~ "Android" ]]; then
            echo "Android"
            install_vimplus_on_android
        else
            install_vimplus_on_linux
        fi
    else
        echo "Not support platform type: "${type}
    fi

    end=`get_now_timestamp`
    second=`expr ${end} - ${begin}`
    min=`expr ${second} / 60`
    echo "It takes "${min}" minutes."
}

# 调用main函数
main
