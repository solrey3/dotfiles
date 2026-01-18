FROM archlinux:latest

LABEL com.github.containers.toolbox="true"

RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm --needed \
        # Base tools
        curl \
        wget \
        git \
        jq \
        neovim \
        # Python for LLM tools
        python \
        python-pip \
        # Shell
        zsh \
        bash \
        tmux \
        starship \
        fzf \
        ripgrep \
        fd \
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
