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

#备份原有的.vimrc文件
function backup_vimrc_file()
{
    user=$1
    home_path=$2
    old_vimrc=$home_path".vimrc"
    is_exist=$(is_exist_file $old_vimrc)
    if [ $is_exist == 1 ]; then
        time=$(get_datetime)
        backup_vimrc=$old_vimrc"_bak_"$time
        read -p "Find "$old_vimrc" already exists,backup "$old_vimrc" to "$backup_vimrc"? [Y/N] " ch
        if [[ $ch == "Y" ]] || [[ $ch == "y" ]]; then
            cp $old_vimrc $backup_vimrc
            chown $user":"$user $backup_vimrc
        fi
    fi
}

#备份原有的.vim目录
function backup_vim_dir()
{
    user=$1
    home_path=$2
    old_vim=$home_path".vim"
    is_exist=$(is_exist_dir $old_vim)
    if [ $is_exist == 1 ]; then
        time=$(get_datetime)
        backup_vim=$old_vim"_bak_"$time
        read -p "Find "$old_vim" already exists,backup "$old_vim" to "$backup_vim"? [Y/N] " ch
        if [[ $ch == "Y" ]] || [[ $ch == "y" ]]; then
            cp -R $old_vim $backup_vim
            chown -R $user":"$user $backup_vim
        fi
    fi
}

# 备份原有的.vimrc和.vim
function backup_vimrc_and_vim()
{
    backup_vimrc_file $1 $2
    backup_vim_dir $1 $2
}

# 在linux上获取当前用户
function get_current_username_on_linux()
{
    current_path=$PWD
    array=(${current_path//// })

    if [ ${array[0]} == "root" ]; then
        echo ${array[0]}
    else
        echo ${array[1]}
    fi
}

# 在linux上判断用户是否存在
function is_valid_user_on_linux()
{
    desc_username=$1
    usernames=$(ls /home/)
    array=(${usernames// / })

    is_found=0
    for username in ${array[@]}
    do
        if [ $username == $desc_username ]; then
            is_found=1
            break
        fi
    done

    if [ $desc_username == "root" ]; then
        is_found=1
    fi

    echo $is_found
}

# 获得home路径
function get_home_path()
{
    username=$1
    if [ $username == "root" ]; then
        echo "/root/"
    else
        echo "/home/"$username"/"
    fi
}

# 在linux上将vimplus安装到指定用户
function install_config_to_user()
{
    src_username=`get_current_username_on_linux`
    desc_username=$1

    # 判断是否是有效用户
    is_found=$(is_valid_user_on_linux $desc_username)
    if [ $is_found != 1 ]; then
        echo "Invalid username "$desc_username
        return
    fi

    # 判断是否是当前用户
    if [ $src_username == $desc_username ]; then
        echo "Can not install vimplus to "$desc_username
        return
    fi

    src_home_path=$(get_home_path $src_username)
    desc_home_path=$(get_home_path $desc_username)

    echo "Current home path:"$src_home_path
    echo "Installing vimplus to "$desc_home_path

    backup_vimrc_and_vim $desc_username $desc_home_path

	# 拷贝.vimrc
    rm -rf $desc_home_path".vimrc"
	cp $src_vimplus_path"vimrc" $desc_home_path".vimrc"
	chown $desc_username":"$desc_username $desc_home_path".vimrc"

    # 拷贝.vim目录
    src_vimplus_path=$src_home_path".vimplus/"
    desc_vim_path=$desc_home_path".vim/"
    rm -rf $desc_vim_path
    mkdir $desc_vim_path
    cp    $src_vimplus_path"help.md" $desc_vim_path
    cp -R $src_vimplus_path"autoload/" $desc_vim_path
    cp -R $src_vimplus_path"colors/" $desc_vim_path
    cp -R $src_vimplus_path"ftplugin/" $desc_vim_path
    cp -R $src_vimplus_path"plugged/" $desc_vim_path
    chown -R $desc_username":"$desc_username $desc_vim_path

    # 安装字体
    mkdir -p $desc_home_path".local/share/fonts/"
    rm -rf $desc_home_path".local/share/fonts/Droid Sans Mono Nerd Font Complete.otf"
    cp $src_vimplus_path"fonts/Droid Sans Mono Nerd Font Complete.otf" $desc_home_path".local/share/fonts/"
    chown -R $desc_username":"$desc_username $desc_home_path".local/"
    fc-cache -vf $desc_home_path".local/share/fonts/"

    print_logo
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
    sudo apt-get remove vim vim-runtime  vim-tiny vim-common vim-gui-common
    sudo apt-get purge vim vim-runtime  vim-tiny vim-common vim-gui-common

    sudo apt-get install -y libncurses5-dev libncurses5 libgnome2-dev libgnomeui-dev \
        libgtk2.0-dev libatk1.0-dev libbonoboui2-dev libcairo2-dev libx11-dev libxpm-dev libxt-dev \
        python-dev python3-dev ruby-dev lua5.1 luajit

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
            --with-luajit \
            --enable-gui=gtk2 \
            --enable-cscope \
            --enable-fail-if-missing \
            --prefix=/usr/local/vim

    sudo make
    sudo make install

    sudo update-alternatives --install /usr/bin/editor editor /usr/local/vim/bin/vim 1
    sudo update-alternatives --set editor /usr/local/vim/bin/vim
    sudo update-alternatives --install /usr/bin/vim vim /usr/local/vim/bin/vim 1
    sudo update-alternatives --set vim /usr/local/vim/bin/vim

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
            sudo apt-get remove neovim --purge
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

# 更新vim插件
function update_vim_plugin()
{
    PLUGDIR=${PWD}/plugged
    #通过 ls root_dir 遍历出子目录，装入子目录 sub_dir 中
    for sub_dir in `ls $PLUGDIR`
    do
        #将根目录 $1 与子目录 sub_dir 拼接成完整的目录
        curr_dir=$PLUGDIR"/"$sub_dir
        if [ -d $curr_dir ]
        then
            cd $curr_dir
            echo -e "\033[32m try fetching code in $curr_dir \033[0m"
            git fetch && git rebase
            echo #打印空行
        else
            echo -e "\033[33m $curr_dir is not a directory \033[0m"
            echo #打印空行
        fi
    done
}

# 安装vim插件
function install_vim_plugin()
{
    PLUGDIR=${PWD}/plugged

    wget https://gitee.com/keeferwu/vimplus/releases/download/plugin-2023-12-15/plugged.tar.gz
    if [ $? -eq 0 ]; then
        if [ -d $PLUGDIR ]; then
            echo -e "\033[33m Remove old $PLUGDIR directory \033[0m"
            rm $PLUGDIR -rf
            echo #打印空行
        fi
        tar -xzf ${PWD}/plugged.tar.gz && rm plugged.tar.gz
        sudo chown $USER:$USER $PLUGDIR -R
    else
        vim -c "PlugInstall" -c "q" -c "q"
    fi
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
    case "$1" in
    -p )
        read -p "Do you want to re-install plugin ? [Y/N] " ch
        if [[ $ch == "Y" ]] || [[ $ch == "y" ]]; then
            install_vim_plugin
        fi
        update_vim_plugin
        ;;
    -i )
        begin=`get_now_timestamp`
        echo "Install vim configuration "
        if [ $(uname) == "Darwin" ]; then
            install_vimplus_on_mac
        elif [ $(uname) == "FreeBSD" ]; then
            install_vimplus_on_freebsd
        elif [ $(uname) == "Linux" ]; then
            tp=$(uname -a)
            if [[ $tp =~ "Android" ]]; then
                echo "Android"
                install_vimplus_on_android
            else
                install_vimplus_on_linux
            fi
        else
            echo "Not support platform type: "$(uname)
        fi
        end=`get_now_timestamp`
        second=`expr ${end} - ${begin}`
        min=`expr ${second} / 60`
        echo "It takes "${min}" minutes."
        ;;
    -u )
        if [ $# -lt 2 ]; then
            echo "Please input username!"
            exit 1
        fi

        if [ ! -d ${PWD}/plugged ]; then
            install_vim_plugin
        fi

        if [ $(uname) == "Linux" ]; then
            echo "Install vim configuration to "$2
            install_config_to_user $2
        else
            echo "Not support platform type: "$(uname)
        fi
        ;;
     * )
        echo ""
        echo "-p : update vim plugins"
        echo "-i : install vim configuration"
        echo "-u : install vim configuration to <user>"
        echo ""
        ;;
    esac
}

# 调用main函数
main "$@"
