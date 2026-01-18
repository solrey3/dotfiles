FROM archlinux:latest

LABEL com.github.containers.toolbox="true"

RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm --needed \
        # Ruby and Jekyll dependencies
        ruby \
        rubygems \
        ruby-bundler \
        base-devel \
        libffi \
        # Node.js for asset pipeline
        nodejs \
        npm \
        # Git and GitHub
        git \
        github-cli \
        # Editors and utilities
        neovim \
        lazygit \
        jq \
        yq \
        tree \
        fzf \
        ripgrep \
        fd \
        # Image optimization
        imagemagick \
        optipng \
        jpegoptim \
        # Shell
        zsh \
        bash \
        tmux \
        starship \
        zoxide \
        eza \
        htop \
        # Distrobox integration
        sudo \
        shadow \
        bc \
        curl \
        wget \
        diffutils \
        findutils \
        less \
        ncurses \
        pinentry \
        procps-ng \
        util-linux \
        vte-common \
        xorg-xauth \
    && pacman -Scc --noconfirm

RUN rm -rf /var/cache/pacman/pkg/*

COPY setup.sh /usr/local/bin/distrobox-setup
RUN chmod +x /usr/local/bin/distrobox-setup
