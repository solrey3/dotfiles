FROM archlinux:latest

LABEL com.github.containers.toolbox="true"

# Update system and install base tools
RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm --needed \
        # Base development
        base-devel \
        git \
        curl \
        wget \
        unzip \
        zip \
        jq \
        yq \
        just \
        # Shell and terminal
        zsh \
        bash \
        tmux \
        starship \
        fzf \
        fd \
        ripgrep \
        zoxide \
        eza \
        # Editors
        neovim \
        github-cli \
        lazygit \
        # Cloud CLIs (official repos)
        aws-cli-v2 \
        azure-cli \
        doctl \
        # Kubernetes tools
        kubectl \
        helm \
        k9s \
        kustomize \
        kubectx \
        stern \
        # Infrastructure as Code
        terraform \
        opentofu \
        ansible \
        # Container tools
        podman \
        buildah \
        skopeo \
        dive \
        # Security scanning (official repos)
        trivy \
        # Networking and debugging
        nmap \
        bind \
        openssh \
        openssl \
        httpie \
        # Monitoring
        btop \
        htop \
        fastfetch \
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
        python \
        python-pip \
    && pacman -Scc --noconfirm

# Clean up cache
RUN rm -rf /var/cache/pacman/pkg/*

# Add setup script
COPY setup.sh /usr/local/bin/distrobox-setup
RUN chmod +x /usr/local/bin/distrobox-setup
