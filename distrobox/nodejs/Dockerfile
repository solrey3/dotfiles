FROM archlinux:latest

LABEL com.github.containers.toolbox="true"

RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm --needed \
        # Node.js ecosystem
        nodejs \
        npm \
        yarn \
        # Build tools
        base-devel \
        git \
        # Editors
        neovim \
        github-cli \
        lazygit \
        # Utilities
        jq \
        yq \
        tree \
        fzf \
        ripgrep \
        fd \
        curl \
        wget \
        httpie \
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
