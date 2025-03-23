set runtimepath^=~/.vim runtimepath+=~/.vim/
let &packpath = &runtimepath
source ~/.vimrc
lua dofile(os.getenv("HOME") .. "/.config/nvim/config.lua")
