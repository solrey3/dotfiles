FROM kalilinux/kali-rolling:latest

LABEL com.github.containers.toolbox="true"

ENV DEBIAN_FRONTEND=noninteractive

# Update and install base system
RUN apt-get update && apt-get install -y \
    # Distrobox integration
    sudo \
    passwd \
    bc \
    curl \
    wget \
    diffutils \
    findutils \
    less \
    ncurses-base \
    pinentry-curses \
    procps \
    util-linux \
    libnss-myhostname \
    libvte-2.91-common \
    xauth \
    # Base tools
    git \
    vim \
    neovim \
    tmux \
    zsh \
    fzf \
    ripgrep \
    fd-find \
    jq \
    tree \
    htop \
    net-tools \
    dnsutils \
    iputils-ping \
    # Kali metapackages - headless/CLI tools
    kali-linux-headless \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Add setup script
COPY setup.sh /usr/local/bin/distrobox-setup
RUN chmod +x /usr/local/bin/distrobox-setup
