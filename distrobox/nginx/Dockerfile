FROM archlinux:latest

LABEL com.github.containers.toolbox="true"

RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm --needed \
        # Nginx and variants
        nginx \
        # SSL/TLS tools
        openssl \
        certbot \
        # Testing tools
        curl \
        wget \
        httpie \
        # Load testing
        wrk \
        siege \
        # Debugging
        tcpdump \
        nmap \
        bind \
        inetutils \
        # Editors and utilities
        neovim \
        git \
        jq \
        yq \
        tree \
        fzf \
        ripgrep \
        fd \
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
