FROM archlinux:latest

LABEL com.github.containers.toolbox="true"

# Update system and install base development tools
RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm --needed \
        base-devel \
        git \
        gcc \
        openssl \
        curl \
        wget \
        unzip \
        zip \
        p7zip \
        rsync \
        tar \
        sed \
        stow \
        gawk \
        just \
        jq \
        # Editors and version control
        neovim \
        github-cli \
        tokei \
        lazygit \
        # Shells and terminal utilities
        zsh \
        bash \
        tmux \
        starship \
        # System monitoring
        btop \
        htop \
        fastfetch \
        nmap \
        speedtest-cli \
        # File managers and navigation
        nnn \
        mc \
        fzf \
        fd \
        ripgrep \
        tree \
        zoxide \
        dysk \
        eza \
        # Media and processing
        ffmpeg \
        yt-dlp \
        # Language servers and development
        marksman \
        python \
        python-pip \
        nodejs \
        npm \
        # Fun terminal tools
        figlet \
        fortune-mod \
        cowsay \
        cmatrix \
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

# Clean up cache
RUN rm -rf /var/cache/pacman/pkg/*

# Add setup script
COPY setup.sh /usr/local/bin/distrobox-setup
RUN chmod +x /usr/local/bin/distrobox-setup
