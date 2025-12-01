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
    elif grep -Eq "Arch Linux" /etc/*-release; then
        echo "ArchLinux"
    elif grep -Eq "Manjaro Linux" /etc/*-release; then
        echo "ManjaroLinux"
    else
        echo "Unknow"
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

# 获取日期
function get_datetime()
{
    time=$(date "+%Y%m%d%H%M%S")
    echo $time
}

#备份原有的.vim目录
function backup_vim_config()
{
    home_path=$1
    old_vim=$home_path".vim"
    old_vimrc=$home_path".vimrc"
    if [ -d $old_vim ] || [ -f $old_vimrc ]; then
        time=$(get_datetime)
        backup_vim=$old_vim"_bak_"$time
        backup_vimrc=$old_vimrc"_bak_"$time
        read -p "Find vim config already exists,do you want to backup ? [Y/n] " ch
        ch=${ch:-Y} # 如果用户直接按回车，则使用默认值 'Y'
        if [[ $ch =~ ^[Yy]$ ]]; then
            cp -R $old_vim $backup_vim
            cp $old_vimrc $backup_vimrc
        fi
    fi
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

function install_nvim_config()
{
    target_version="v0.11.0"
    if which nvim >/dev/null 2>&1; then
        nvim_version=`nvim --version | head -n 1 | awk '{print $2}'`
        if ! printf '%s\n%s\n' "${nvim_version#v}" "${target_version#v}" | sort -V -C -r; then
            echo
            echo -e "\033[33m Current nvim version is $nvim_version, make sure it >= $target_version \033[0m"
            echo
        fi
    else
        echo -e "\033[31m Neovim is not exists, will try install the latest version\033[0m"
        curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
        sudo rm -rf /opt/nvim-linux-x86_64
        sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
        sudo rm -rf nvim-linux-x86_64.tar.gz
        echo -e "\033[33m You should add /opt/nvim-linux-x86_64/bin to PATH\033[0m"
    fi
    home_path=$1
    nvim_config="$home_path/.config/nvim"
    if [ -d $nvim_config ]; then
        time=$(get_datetime)
        backup_nvim=$nvim_config"_bak_"$time
        read -p "Find neovim config already exists, backup to "$backup_nvim"? [Y/n] " ch
        ch=${ch:-Y} # 如果用户直接按回车，则使用默认值 'Y'
        if [[ $ch =~ ^[Yy]$ ]]; then
            cp -R $nvim_config $backup_nvim
        fi
        rm -rf $nvim_config
    fi

    mkdir -p $nvim_config
    # 定义文件内容并写入
    {
    echo "let loaded_gtags_cscope = 1"
    echo "set runtimepath^=~/.vim runtimepath+=~/.vim/"
    echo "let &packpath = &runtimepath"
    echo "source ~/.vimrc"
    echo "lua dofile(vim.fn.expand(\"~/.vim/config.lua\"))"
    } > "$nvim_config/init.vim"
}

# 在linux上将vimplus 拷贝到指定用户
function copy_config_to_user()
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

    backup_vim_config $desc_home_path

    src_vim_path=$src_home_path".vim/"
    desc_vim_path=$desc_home_path".vim/"
    # 拷贝.vimrc
    rm -rf $desc_home_path".vimrc"
    cp $src_vim_path"vimrc" $desc_home_path".vimrc"
    chown $desc_username":"$desc_username $desc_home_path".vimrc"
    # 拷贝.vim目录
    rm -rf $desc_vim_path
    mkdir $desc_vim_path
    cp    $src_vim_path"config.lua"         $desc_vim_path
    cp    $src_vim_path"coc-settings.json"  $desc_vim_path
    cp -R $src_vim_path"doc/"               $desc_vim_path
    cp -R $src_vim_path"colors/"            $desc_vim_path
    cp -R $src_vim_path"autoload/"          $desc_vim_path
    cp -R $src_vim_path"ftplugin/"          $desc_vim_path
    cp -R $src_vim_path"plugged/"           $desc_vim_path
    chown -R $desc_username":"$desc_username $desc_vim_path

    # 安装字体
    mkdir -p $desc_home_path".local/share/fonts/"
    rm -rf $desc_home_path".local/share/fonts/Droid Sans Mono Nerd Font Complete.otf"
    cp $src_vim_path"fonts/Droid Sans Mono Nerd Font Complete.otf" $desc_home_path".local/share/fonts/"
    chown -R $desc_username":"$desc_username $desc_home_path".local/"
    fc-cache -vf $desc_home_path".local/share/fonts/"

    read -p "Do you want to config neovim for user "$desc_username"? [y/N] " ch
    ch=${ch:-N} # 如果用户直接按回车，则使用默认值 'N'
    if [[ $ch =~ ^[Yy]$ ]]; then
        install_nvim_config $desc_home_path
    fi

    print_logo
}

# 安装配置文件
function install_config_files()
{
    vimrc_file=$HOME"/.vimrc"
    if [ -f $vimrc_file ]; then
        rm -rf $vimrc_file
    fi
    ln -s ${PWD}/vimrc $vimrc_file

    read -p "Do you want to config neovim ? [y/N] " ch
    ch=${ch:-N} # 如果用户直接按回车，则使用默认值 'N'
    if [[ $ch =~ ^[Yy]$ ]]; then
        install_nvim_config $HOME
    fi
}

# 获取ubuntu版本
function get_ubuntu_version()
{
    line=$(cat /etc/lsb-release | grep "DISTRIB_RELEASE")
    arr=(${line//=/ })
    version=(${arr[1]//./ })

    echo ${version[0]}
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
function compile_vim_by_source()
{
    sudo apt-get remove vim vim-runtime  vim-tiny vim-common vim-gui-common
    sudo apt-get purge vim vim-runtime  vim-tiny vim-common vim-gui-common

    sudo apt-get install -y libncurses5-dev libncurses5 python3-dev ruby-dev lua5.1 liblua5.1-dev luajit libluajit-5.1-dev libgtk2.0-dev libatk1.0-dev libcairo2-dev libx11-dev libxpm-dev libxt-dev libperl-dev

    rm -rf ~/vim_source
    git clone https://github.com/vim/vim.git ~/vim_source
    cd ~/vim_source
    if [ $? -eq 0 ]; then
        ./configure --with-features=huge \
                --enable-multibyte \
                --enable-rubyinterp=yes \
                --enable-python3interp=yes \
                --with-python3-config-dir=$(python3-config --configdir) \
                --enable-perlinterp=yes \
                --enable-luainterp=yes \
                --with-luajit \
                --enable-gui=gtk2 \
                --with-x \
                --enable-cscope \
                --enable-fail-if-missing \
                --prefix=/usr/local

        sudo make
        sudo make install

        sudo update-alternatives --install /usr/bin/vim vim /usr/local/bin/vim 1
        sudo update-alternatives --set vim /usr/local/bin/vim

        cd -
    else
        echo -e "\033[33m Download vim source failure! \033[0m"
    fi
    #如果缺少软件依赖可能会导致configure配置失败，导致安装的vim不支持python
    #remove vim which is installed by source
    #sudo rm -rf /usr/bin/vim
    #sudo rm -rf /usr/local/bin/vim
    #sudo rm -rf /usr/local/share/vim
    #sudo rm -rf /usr/local/man/man1/vim.1
}

# 在ubuntu上安装nodejs
function install_nodejs_by_apt()
{
    if which nodejs >/dev/null 2>&1; then
        nodejs_version=`nodejs --version`
        target_version="v16.18.0"
        if ! printf '%s\n%s\n' "${nodejs_version#v}" "${target_version#v}" | sort -V -C -r; then
            echo
            echo -e "\033[33m Current nodejs version is $nodejs_version, make sure it >= $target_version \033[0m"
            echo
        fi
    else
        curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
        # install nodejs and npm
        sudo apt-get install -y nodejs
    fi
    if ! which npm >/dev/null 2>&1; then
        sudo apt-get install -y npm
    fi
}

# 安装mac平台必备软件
function install_prepare_software_on_mac()
{
    xcode-select --install

    brew install cmake ninja gcc autoconf automake libtool flex bison wget fontconfig libfile-next-perl
    brew install python3 python3-dev python3-pip python3-pygments python3-pynvim
    brew install universal-ctags global fd ripgrep astyle ccls llvm
    brew install vim node npm

    macos1014=$(is_macos1014)
    if [ $macos1014 == 1 ]; then
        open /Library/Developer/CommandLineTools/Packages/macOS_SDK_headers_for_macOS_10.14.pkg
    fi
}

# 安装ubuntu系必备软件
function install_prepare_software_by_apt()
{
    sudo apt-get update
    sudo apt-get install -y cmake ninja-build gcc-multilib autoconf automake libtool
    sudo apt-get install -y flex bison build-essential wget curl fontconfig libfile-next-perl
    sudo apt-get install -y python3 python3-dev python3-pip python3-pygments python3-pynvim
    sudo apt-get install -y universal-ctags global fd-find ripgrep astyle xclip ccls llvm

    install_nodejs_by_apt

    if ! which fd >/dev/null 2>&1; then
        sudo ln -s /usr/bin/fdfind /usr/bin/fd
    fi

    if which vim >/dev/null 2>&1; then
        vim_version=`vim --version | head -n 1 | awk '{print $5}'`
        target_version="9.1"
        if ! printf '%s\n%s\n' "$vim_version" "$target_version" | sort -V -C -r; then
            echo
            echo -e "\033[33m Current vim version is $vim_version, make sure it >= $target_version \033[0m"
            echo
        fi
    else
        read -p "VIM is not exists, do you want to install by latest source ? [Y/n] " ch
        ch=${ch:-Y} # 如果用户直接按回车，则使用默认值 'Y'
        if [[ $ch =~ ^[Yy]$ ]]; then
            compile_vim_by_source
        fi
    fi
}

# 安装archlinux必备软件
function install_prepare_software_by_pacman()
{
    sudo pacman -S --noconfirm vim cmake gcc gcc-libs autoconf automake libtool flex bison fontconfig wget
    sudo pacman -S --noconfirm python python-pip python-pygments python-pynvim python-setuptools
    sudo pacman -S --noconfirm ctags ripgrep clang astyle ccls global xclip fd nodejs npm
    sudo ln -s /usr/lib/libtinfo.so.6 /usr/lib/libtinfo.so.5
}

# 安装mac平台字体
function install_fonts_on_mac()
{
    rm -rf ~/Library/Fonts/Droid\ Sans\ Mono\ Nerd\ Font\ Complete.otf
    cp ./fonts/Droid\ Sans\ Mono\ Nerd\ Font\ Complete.otf ~/Library/Fonts
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
            git gc
            git fetch && git rebase
            if [ $sub_dir == "LeaderF" ]; then
                #更新LeaderF插件，重新执行其目录下的install.sh脚本
                ./install.sh
            fi
            echo #打印空行
        else
            echo -e "\033[33m $curr_dir is not a directory \033[0m"
            echo #打印空行
        fi
    done
    #更新plug.vim
    echo -e "\033[32m Updating plug.vim ... \033[0m"
    curl -fLo ${PWD}/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
}

# 安装vim插件
function install_vim_plugin()
{
    PLUGDIR=${PWD}/plugged

    wget https://gitee.com/keeferwu/vimplus/releases/download/plugin-2025-12-01/plugged.tar.gz
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

# 在mac平台安装vimplus
function install_vimplus_on_mac()
{
    install_prepare_software_on_mac
    install_config_files
    install_fonts_on_mac
    install_vim_plugin
    print_logo
}

# 在linux平上台安装vimplus
function install_vimplus_on_linux()
{
    distro=`get_linux_distro`
    echo "Linux distro: "${distro}
    if [ ${distro} == "Unknow" ]; then
        return
    elif [ ${distro} == "ArchLinux" ] || [ ${distro} == "ManjaroLinux" ]; then
        install_prepare_software_by_pacman
    else
        install_prepare_software_by_apt
    fi
    install_config_files
    install_fonts_on_linux
    install_vim_plugin
    print_logo
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
    if [ $# -lt 1 ]; then
        echo "$0 {-p|-i|-u|-h}"
        exit 1
    fi
    while getopts ":hiu:p" opt
    do
        case "$opt" in
        p)
            #通过shift $(($OPTIND - 1))的处理，$*中就只保留了除去选项内容的参数，
            shift $(($OPTIND - 1))
            #如果输入参数为release，重新安装plugin
            if [ "$1" == "release" ]; then
                install_vim_plugin
            fi
            update_vim_plugin
            exit 0
            ;;
        i)
            begin=`get_now_timestamp`
            echo "Install vim configuration "
            if [ $(uname) == "Darwin" ]; then
                install_vimplus_on_mac
            elif [ $(uname) == "Linux" ]; then
                install_vimplus_on_linux
            else
                echo "Not support platform type: "$(uname)
            fi
            end=`get_now_timestamp`
            second=`expr ${end} - ${begin}`
            min=`expr ${second} / 60`
            echo "It takes "${min}" minutes."
            exit 0
            ;;
        u)
            if [ "$EUID" -ne 0 ]; then
                echo "Should running with sudo."
                exit 1
            fi

            if [ ! -d ${PWD}/plugged ]; then
                install_vim_plugin
            fi

            if [ $(uname) == "Linux" ]; then
                echo "copy vim configuration to "$OPTARG
                copy_config_to_user $OPTARG
            else
                echo "Not support platform type: "$(uname)
            fi
            exit 0
            ;;
        :)
            echo "-$OPTARG need parameter"
            exit 1
            ;; 
        h|?)
            echo ""
            echo "-p : update vim plugins"
            echo "-i : install vim configuration"
            echo "-u : copy vim configuration to <user>"
            echo ""
            exit 1
            ;;
        esac
    done
}

# 调用main函数
main "$@"
