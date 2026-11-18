# Dockerfile for vimplus vim/nvim runtime environment
# Base image as requested; vim/nvim and toolchain are installed referencing install.sh
# (install_prepare_software_by_apt, compile_vim_by_source, install_nvim_config).
#
# This image provides vim/nvim commands and language/tooling dependencies for the host.
# Editor configuration and plugins are NOT baked into the image: keep them on the host
# under ~/.vim (and ~/.vimrc, ~/.config/nvim) and bind-mount when running.

FROM ubuntu:26.04

ENV DEBIAN_FRONTEND=noninteractive \
    LANG=C.UTF-8 \
    LC_ALL=C.UTF-8

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# ---------------------------------------------------------------------------
# Base toolchain and dependencies (ref: install.sh install_prepare_software_by_apt
# and compile_vim_by_source). Vim is compiled from source and Neovim is installed
# from the latest official release, as in install.sh.
# ---------------------------------------------------------------------------
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    git \
    curl \
    wget \
    unzip \
    xz-utils \
    build-essential \
    gcc-multilib \
    cmake \
    ninja-build \
    autoconf \
    automake \
    libtool \
    pkg-config \
    bear \
    flex \
    bison \
    fontconfig \
    libfile-next-perl \
    python3 \
    python3-dev \
    python3-pip \
    python3-pygments \
    python3-pynvim \
    universal-ctags \
    global \
    fd-find \
    ripgrep \
    astyle \
    xclip \
    llvm \
    lldb \
    clangd \
    clang \
    clang-tools \
    clang-format \
    # Vim build/runtime deps (ref: compile_vim_by_source)
    libncurses-dev \
    libncursesw5-dev \
    ruby-dev \
    lua5.1 \
    liblua5.1-0-dev \
    luajit \
    libluajit-5.1-dev \
    libgtk-3-dev \
    libatk1.0-dev \
    libcairo2-dev \
    libx11-dev \
    libxpm-dev \
    libxt-dev \
    libperl-dev \
    && rm -rf /var/lib/apt/lists/*

# Match install.sh convenience aliases
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 1 \
    && if [ ! -e /usr/bin/fd ] && [ -x /usr/bin/fdfind ]; then ln -s /usr/bin/fdfind /usr/bin/fd; fi

# ---------------------------------------------------------------------------
# Node.js / npm (ref: install.sh install_nodejs_by_apt)
# ---------------------------------------------------------------------------
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - \
    && apt-get update \
    && apt-get install -y --no-install-recommends nodejs npm \
    && rm -rf /var/lib/apt/lists/*

# ---------------------------------------------------------------------------
# Vim: compile from latest source (ref: install.sh compile_vim_by_source)
# Keep configure flags aligned with install.sh, including --without-wayland.
# ---------------------------------------------------------------------------
RUN set -eux; \
    git clone --depth 1 https://github.com/vim/vim.git /tmp/vim_source; \
    cd /tmp/vim_source; \
    ./configure --with-features=huge \
        --enable-multibyte \
        --enable-python3interp=yes \
        --with-python3-config-dir="$(python3-config --configdir)" \
        --enable-perlinterp=yes \
        --enable-rubyinterp=yes \
        --enable-luainterp=yes \
        --with-luajit \
        --enable-gui=gtk3 \
        --with-x \
        --without-wayland \
        --enable-cscope \
        --enable-terminal \
        --enable-fail-if-missing \
        --prefix=/usr/local; \
    make -j"$(nproc)"; \
    make install; \
    cd /; \
    rm -rf /tmp/vim_source; \
    update-alternatives --install /usr/bin/vim vim /usr/local/bin/vim 100 || true; \
    update-alternatives --set vim /usr/local/bin/vim || true; \
    vim --version | head -n 2

# ---------------------------------------------------------------------------
# Neovim: install latest release (ref: install.sh install_nvim_config)
# ---------------------------------------------------------------------------
RUN set -eux; \
    curl -fL -o /tmp/nvim-linux-x86_64.tar.gz \
        https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz; \
    rm -rf /opt/nvim-linux-x86_64; \
    tar -C /opt -xzf /tmp/nvim-linux-x86_64.tar.gz; \
    rm -f /tmp/nvim-linux-x86_64.tar.gz; \
    ln -sfn /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim; \
    ln -sfn /opt/nvim-linux-x86_64/bin/nvim /usr/bin/nvim || true; \
    npm install -g neovim || true; \
    python3 -m pip install --break-system-packages --upgrade pynvim \
        || python3 -m pip install --upgrade pynvim || true; \
    nvim --version | head -n 2

# ---------------------------------------------------------------------------
# tree-sitter CLI (ref: install.sh install_nvim_config)
# ---------------------------------------------------------------------------
RUN set -eux; \
    curl -fL -o /tmp/tree-sitter.gz \
        https://github.com/tree-sitter/tree-sitter/releases/download/nightly/tree-sitter-linux-x64.gz; \
    gunzip -f /tmp/tree-sitter.gz; \
    chmod +x /tmp/tree-sitter; \
    mv /tmp/tree-sitter /usr/local/bin/tree-sitter; \
    tree-sitter --version || true

# Runtime defaults: config stays on host (~/.vim, ~/.vimrc, ~/.config/nvim)
WORKDIR /workspace
CMD ["bash"]
