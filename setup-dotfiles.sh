#!/bin/bash

# Define the base directory
BASE_DIR="$HOME/dotfiles"

# Function to create directories
create_directory() {
    local dir="$1"
    echo "Creating directory $dir"
    mkdir -p "$dir"
}

# Function to create sample files
create_file() {
    local file="$1"
    local content="$2"
    echo "Creating file $file"
    echo -e "$content" > "$file"
}

# Create directories
create_directory "$BASE_DIR/bash"
create_directory "$BASE_DIR/tmux"
create_directory "$BASE_DIR/nvim"
create_directory "$BASE_DIR/vim"
create_directory "$BASE_DIR/alacritty"
create_directory "$BASE_DIR/vnc"
create_directory "$BASE_DIR/laravel"
create_directory "$BASE_DIR/typescript-node-nextjs"
create_directory "$BASE_DIR/django"
create_directory "$BASE_DIR/wordpress"
create_directory "$BASE_DIR/fastapi"
create_directory "$BASE_DIR/nginx"
create_directory "$BASE_DIR/terraform/gcp"
create_directory "$BASE_DIR/terraform/aws"
create_directory "$BASE_DIR/terraform/digitalocean"
create_directory "$BASE_DIR/terraform/docker"
create_directory "$BASE_DIR/redis"
create_directory "$BASE_DIR/elk"
create_directory "$BASE_DIR/postgresql"
create_directory "$BASE_DIR/mysql"
create_directory "$BASE_DIR/graphql"
create_directory "$BASE_DIR/node"
create_directory "$BASE_DIR/react"

# Create sample files

# Bash
create_file "$BASE_DIR/bash/.bashrc" '# .bashrc\n\n# User specific aliases and functions\nalias ll="ls -la"\nalias gs="git status"\nalias gp="git pull"\nalias gc="git commit"\n\n# Source global definitions\nif [ -f /etc/bashrc ]; then\n    . /etc/bashrc\nfi\n'
create_file "$BASE_DIR/bash/.bash_profile" '# .bash_profile\n\n# Get the aliases and functions\nif [ -f ~/.bashrc ]; then\n    . ~/.bashrc\nfi\n\n# Add user bin directory to PATH\nexport PATH=$PATH:$HOME/bin\n'

# Tmux
create_file "$BASE_DIR/tmux/.tmux.conf" '# .tmux.conf\n\n# Set prefix to Ctrl-a\nunbind C-b\nset-option -g prefix C-a\nbind-key C-a send-prefix\n\n# Split panes using | and -\nbind | split-window -h\nbind - split-window -v\n\n# Enable mouse support\nset -g mouse on\n\n# Reload tmux config\nbind r source-file ~/.tmux.conf \\; display "Reloaded!"\n'

# Neovim
create_file "$BASE_DIR/nvim/init.lua" '-- init.lua\n\n-- Basic settings\nvim.o.number = true  -- Show line numbers\nvim.o.relativenumber = true  -- Show relative line numbers\nvim.o.expandtab = true  -- Use spaces instead of tabs\nvim.o.shiftwidth = 4  -- Indentation level\nvim.o.tabstop = 4  -- Number of spaces tabs count for\nvim.o.smartindent = true  -- Smart indentation\nvim.o.clipboard = "unnamedplus"  -- Use system clipboard\nvim.o.termguicolors = true  -- Enable 24-bit RGB colors\n\n-- Load plugins using packer.nvim\nrequire("packer").startup(function()\n  use "wbthomason/packer.nvim"  -- Plugin manager\n  use "nvim-treesitter/nvim-treesitter"  -- Treesitter for better syntax highlighting\n  use "neovim/nvim-lspconfig"  -- LSP configurations\n  use "hrsh7th/nvim-compe"  -- Auto-completion\n  use "nvim-telescope/telescope.nvim"  -- Fuzzy finder\n  use "gruvbox-community/gruvbox"  -- Gruvbox color scheme\nend)\n\n-- LSP settings\nrequire("lspconfig").pyright.setup{}  -- Example LSP for Python\n\n-- Telescope keybindings\nvim.api.nvim_set_keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { noremap = true })\nvim.api.nvim_set_keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { noremap = true })\n\n-- Colorscheme\nvim.cmd("colorscheme gruvbox")\n'

# Vim
create_file "$BASE_DIR/vim/.vimrc" '" .vimrc\n\n" Enable line numbers\nset number\n\n" Set tabs to 4 spaces\nset tabstop=4\nset shiftwidth=4\nset expandtab\n\n" Enable syntax highlighting\nsyntax on\n\n" Use spaces instead of tabs\nset expandtab\n\n" Set color scheme\ncolorscheme desert\n\n" Enable line numbers\nset number\n'

# Alacritty
create_file "$BASE_DIR/alacritty/alacritty.yml" '# alacritty.yml\n\n# Configuration for Alacritty terminal\n\nwindow:\n  padding:\n    x: 10\n    y: 10\n\nfont:\n  size: 12.0\n\ncolors:\n  primary:\n    background: "0x1d1f21"\n    foreground: "0xc5c8c6"\n'

# VNC
create_file "$BASE_DIR/vnc/xstartup" '#!/bin/sh\n\n# xstartup\n\n# Start the window manager\nxsetroot -solid grey\nvncconfig -iconic &\nxterm &\ntwm &\n'

# Laravel
create_file "$BASE_DIR/laravel/Dockerfile" '# Dockerfile\n\nFROM php:8.0-apache\n\n# Install dependencies\nRUN apt-get update && apt-get install -y \\\n    libpng-dev \\\n    libjpeg-dev \\\n    libfreetype6-dev \\\n    && docker-php-ext-configure gd --with-freetype --with-jpeg \\\n    && docker-php-ext-install gd \\\n    && docker-php-ext-install pdo_mysql\n\n# Enable Apache rewrite module\nRUN a2enmod rewrite\n\n# Copy the application files\nCOPY . /var/www/html\n\n# Set permissions\nRUN chown -R www-data:www-data /var/www/html\n'
create_file "$BASE_DIR/laravel/docker-compose.yml" 'version: "3.8"\n\nservices:\n  app:\n    build: .\n    ports:\n      - "8000:80"\n    volumes:\n      - .:/var/www/html\n    environment:\n      - APACHE_RUN_USER=www-data\n      - APACHE_RUN_GROUP=www-data\n\n  db:\n    image: mysql:8.0\n    environment:\n      MYSQL_ROOT_PASSWORD: root\n      MYSQL_DATABASE: laravel\n      MYSQL_USER: laravel\n      MYSQL_PASSWORD: laravel\n    volumes:\n      - mysql-data:/var/lib/mysql\n\nvolumes:\n  mysql-data:\n'

# TypeScript Node API with Next.js
create_file "$BASE_DIR/typescript-node-nextjs/Dockerfile.api" '# Dockerfile.api\n\nFROM node:18\n\nWORKDIR /app\n\nCOPY package*.json ./\n\nRUN npm install\n\nCOPY . .\n\nRUN npm run build\n\nCMD ["npm", "start"]\n'
create_file "$BASE_DIR/typescript-node-nextjs/Dockerfile.web" '# Dockerfile.web\n\nFROM node:18\n\nWORKDIR /app\n\nCOPY package*.json ./\n\nRUN npm install\n\nCOPY . .\n\nRUN npm run build\n\nEXPOSE 3000\n\nCMD ["npm", "start"]\n'
create_file "$BASE_DIR/typescript-node-nextjs/docker-compose.yml" 'version: "3.8"\n\nservices:\n  api:\n    build:\n      context: .\n      dockerfile: Dockerfile.api\n    volumes:\n      - ./api:/app\n    ports:\n      - "4000:4000"\n\n  web:\n    build:\n      context: .\n      dockerfile: Dockerfile.web\n    volumes:\n      - ./web:/app\n    ports:\n      - "3000:3000"\n    environment:\n      NEXT_PUBLIC_API_URL: "http://localhost:4000"\n\n  db:\n    image: postgres:13\n    environment:\n      POSTGRES_DB: app\n      POSTGRES_USER: user\n      POSTGRES_PASSWORD: password\n    volumes:\n      - postgres-data:/var/lib/postgresql/data\n\nvolumes:\n  postgres-data:\n'

# Django
create_file "$BASE_DIR/django/Dockerfile" '# Dockerfile\n\nFROM python:3.9\n\nWORKDIR /app\n\nCOPY requirements.txt .\n\nRUN pip install --no-cache-dir -r requirements.txt\n\nCOPY . .\n\nCMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]\n'
create_file "$BASE_DIR/django/docker-compose.yml" 'version: "3.8"\n\nservices:\n  web:\n    build: .\n    command: python manage.py runserver 0.0.0.0:8000\n    volumes:\n      - .:/app\n    ports:\n      - "8000:8000"\n    depends_on:\n      - db\n\n  db:\n    image: postgres:13\n    environment:\n      POSTGRES_DB: django\n      POSTGRES_USER: user\n      POSTGRES_PASSWORD: password\n    volumes:\n      - postgres-data:/var/lib/postgresql/data\n\nvolumes:\n  postgres-data:\n'

# WordPress
create_file "$BASE_DIR/wordpress/docker-compose.yml" 'version: "3.8"\n\nservices:\n  wordpress:\n    image: wordpress:latest\n    ports:\n      - "8080:80"\n    environment:\n      WORDPRESS_DB_HOST: db\n      WORDPRESS_DB_USER: wordpress\n      WORDPRESS_DB_PASSWORD: wordpress\n      WORDPRESS_DB_NAME: wordpress\n    volumes:\n      - ./wordpress:/var/www/html\n\n  db:\n    image: mysql:5.7\n    environment:\n      MYSQL_DATABASE: wordpress\n      MYSQL_USER: wordpress\n      MYSQL_PASSWORD: wordpress\n      MYSQL_RANDOM_ROOT_PASSWORD: "1"\n    volumes:\n      - mysql-data:/var/lib/mysql\n\nvolumes:\n  mysql-data:\n  wordpress:\n'

# FastAPI
create_file "$BASE_DIR/fastapi/Dockerfile" '# Dockerfile\n\nFROM python:3.9\n\nWORKDIR /app\n\nCOPY requirements.txt .\n\nRUN pip install --no-cache-dir -r requirements.txt\n\nCOPY . .\n\nCMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]\n'
create_file "$BASE_DIR/fastapi/docker-compose.yml" 'version: "3.8"\n\nservices:\n  api:\n    build: .\n    volumes:\n      - .:/app\n    ports:\n      - "8000:8000"\n    depends_on:\n      - db\n\n  db:\n    image: postgres:13\n    environment:\n      POSTGRES_DB: fastapi\n      POSTGRES_USER: user\n      POSTGRES_PASSWORD: password\n    volumes:\n      - postgres-data:/var/lib/postgresql/data\n\nvolumes:\n  postgres-data:\n'
create_file "$BASE_DIR/fastapi/Dockerfile.graphql" '# Dockerfile.graphql\n\nFROM python:3.9\n\nWORKDIR /app\n\nCOPY requirements.txt .\n\nRUN pip install --no-cache-dir -r requirements.txt\n\nCOPY . .\n\nCMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]\n'
create_file "$BASE_DIR/fastapi/docker-compose.graphql.yml" 'version: "3.8"\n\nservices:\n  api:\n    build:\n      context: .\n      dockerfile: Dockerfile.graphql\n    volumes:\n      - .:/app\n    ports:\n      - "8000:8000"\n    depends_on:\n      - db\n\n  db:\n    image: postgres:13\n    environment:\n      POSTGRES_DB: fastapi\n      POSTGRES_USER: user\n      POSTGRES_PASSWORD: password\n    volumes:\n      - postgres-data:/var/lib/postgresql/data\n\nvolumes:\n  postgres-data:\n'

# Redis
create_file "$BASE_DIR/redis/redis.conf" '# redis.conf\n\n# Redis configuration file example\n\nbind 127.0.0.1\nprotected-mode yes\nport 6379\n\n# Set Redis to use a specific maximum memory limit\nmaxmemory 128mb\n\n# Eviction policy\nmaxmemory-policy allkeys-lru\n'

# ELK
create_file "$BASE_DIR/elk/elasticsearch.yml" '# elasticsearch.yml\n\ncluster.name: "docker-cluster"\nnetwork.host: 0.0.0.0\n'
create_file "$BASE_DIR/elk/logstash.conf" '# logstash.conf\n\ninput {\n  beats {\n    port => 5044\n  }\n}\n\noutput {\n  elasticsearch {\n    hosts => ["http://elasticsearch:9200"]\n  }\n}\n'
create_file "$BASE_DIR/elk/kibana.yml" '# kibana.yml\n\nserver.port: 5601\nelasticsearch.hosts: ["http://elasticsearch:9200"]\n'

# PostgreSQL
create_file "$BASE_DIR/postgresql/postgresql.conf" '# postgresql.conf\n\n# Listen on all IP addresses\nlisten_addresses = "*"\n\n# Set the port number\nport = 5432\n\n# Specify the data directory\ndata_directory = "/var/lib/postgresql/data"\n'

# MySQL
create_file "$BASE_DIR/mysql/my.cnf" '# my.cnf\n\n[mysqld]\nport = 3306\nbind-address = 0.0.0.0\ndefault_authentication_plugin = mysql_native_password\n'

# GraphQL
create_file "$BASE_DIR/graphql/schema.graphql" '# schema.graphql\n\ntype Query {\n  hello: String\n}\n'

# Node
create_file "$BASE_DIR/node/Dockerfile" '# Dockerfile\n\nFROM node:18\n\nWORKDIR /app\n\nCOPY package*.json ./\n\nRUN npm install\n\nCOPY . .\n\nRUN npm run build\n\nCMD ["npm", "start"]\n'
create_file "$BASE_DIR/node/docker-compose.yml" 'version: "3.8"\n\nservices:\n  app:\n    build: .\n    ports:\n      - "3000:3000"\n    volumes:\n      - .:/app\n'

# React
create_file "$BASE_DIR/react/Dockerfile" '# Dockerfile\n\nFROM node:18\n\nWORKDIR /app\n\nCOPY package*.json ./\n\nRUN npm install\n\nCOPY . .\n\nRUN npm run build\n\nEXPOSE 3000\n\nCMD ["npm", "start"]\n'
create_file "$BASE_DIR/react/docker-compose.yml" 'version: "3.8"\n\nservices:\n  web:\n    build: .\n    ports:\n      - "3000:3000"\n    volumes:\n      - .:/app\n'

echo "Directory structure and sample files have been created in $BASE_DIR"
