#!/bin/bash

function fetch_dir(){
    for sub_dir in `ls $1` #通过 ls root_dir 遍历出子目录，装入子目录 sub_dir 中
    do
        curr_dir=$1"/"$sub_dir #将根目录 $1 与子目录 sub_dir 拼接成完整的目录
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

fetch_dir `pwd`"/plugged"

