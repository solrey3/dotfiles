# Distrobox Node.js/TypeScript Environment

Arch Linux-based container for Node.js and TypeScript development with multiple package managers.

## Quick Start

```bash
podman build -t distrobox-nodejs ~/.dotfiles/distrobox/nodejs/
distrobox create -i distrobox-nodejs -n nodejs
distrobox enter nodejs
distrobox-setup
```

## Included Tools

### Package Managers
| Tool | Description |
|------|-------------|
| npm | Node Package Manager (built-in) |
| yarn | Yarn Classic |
| pnpm | Performant npm (via setup.sh) |
| bun | All-in-one JS toolkit (via setup.sh) |

### Node Version Management
- **fnm** - Fast Node Manager (via setup.sh)

### TypeScript
| Tool | Description |
|------|-------------|
| typescript | TypeScript compiler |
| ts-node | Run TypeScript directly |
| tsx | Fast TypeScript execution |
| @types/node | Node.js type definitions |

### Development Tools
| Tool | Description |
|------|-------------|
| nodemon | Auto-restart on changes |
| pm2 | Process manager |
| turbo | Monorepo build system |
| concurrently | Run multiple commands |
| serve | Static file server |
| http-server | Simple HTTP server |

### Code Quality
| Tool | Description |
|------|-------------|
| eslint | Linter |
| prettier | Code formatter |
| typescript-eslint | TS ESLint support |

### Language Servers (for Neovim)
- typescript-language-server
- vscode-langservers-extracted

## Package Manager Comparison

| Feature | npm | yarn | pnpm | bun |
|---------|-----|------|------|-----|
| Speed | Slow | Medium | Fast | Fastest |
| Disk usage | High | High | Low | Low |
| Lockfile | package-lock.json | yarn.lock | pnpm-lock.yaml | bun.lockb |
| Workspaces | Yes | Yes | Yes | Yes |

## Common Workflows

### New Project

```bash
# With npm
mkdir my-app && cd my-app
npm init -y
npm i typescript @types/node -D
npx tsc --init

# With Bun (fastest)
mkdir my-app && cd my-app
bun init

# With pnpm
mkdir my-app && cd my-app
pnpm init
pnpm add typescript @types/node -D
```

### Node Version Management

```bash
# Install a version
fnm install 20
fnm install 18

# Switch versions
fnm use 20

# List installed
fnm list

# Auto-switch with .node-version file
echo "20" > .node-version
```

### TypeScript Project Setup

```bash
mkdir my-ts-app && cd my-ts-app
npm init -y
npm i typescript @types/node -D
npx tsc --init

# tsconfig.json essentials
cat > tsconfig.json << 'EOF'
{
  "compilerOptions": {
    "target": "ES2022",
    "module": "NodeNext",
    "moduleResolution": "NodeNext",
    "strict": true,
    "esModuleInterop": true,
    "outDir": "./dist",
    "rootDir": "./src"
  },
  "include": ["src/**/*"]
}
EOF

mkdir src
echo 'console.log("Hello TypeScript!")' > src/index.ts

# Run
npx tsx src/index.ts
```

### Development Server

```bash
# With nodemon (auto-restart)
nodemon --exec tsx src/index.ts

# With Bun (built-in watch)
bun --watch src/index.ts
```

### Static File Server

```bash
# serve (SPA-friendly)
serve -s dist -l 3000

# http-server
http-server dist -p 3000

# Bun
bun --bun serve dist
```

### ESLint + Prettier Setup

```bash
npm i -D eslint prettier @typescript-eslint/parser @typescript-eslint/eslint-plugin

# .eslintrc.json
cat > .eslintrc.json << 'EOF'
{
  "parser": "@typescript-eslint/parser",
  "plugins": ["@typescript-eslint"],
  "extends": [
    "eslint:recommended",
    "plugin:@typescript-eslint/recommended"
  ]
}
EOF

# .prettierrc
cat > .prettierrc << 'EOF'
{
  "semi": false,
  "singleQuote": true,
  "tabWidth": 2
}
EOF
```

### PM2 Process Management

```bash
# Start app
pm2 start dist/index.js --name my-app

# List processes
pm2 list

# Logs
pm2 logs my-app

# Restart
pm2 restart my-app

# Stop
pm2 stop my-app
```

### Check for Updates

```bash
# npm-check-updates
ncu           # Check for updates
ncu -u        # Update package.json
npm install   # Install updates
```
