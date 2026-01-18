# Distrobox Nginx Environment

Arch Linux-based container for testing and developing Nginx configurations.

## Quick Start

```bash
podman build -t distrobox-nginx ~/.dotfiles/distrobox/nginx/
distrobox create -i distrobox-nginx -n nginx
distrobox enter nginx
distrobox-setup
```

## Included Tools

### Web Server
- **nginx** - HTTP server

### SSL/TLS
- **openssl** - Certificate generation
- **certbot** - Let's Encrypt client

### Testing & Load Testing
- **curl** - HTTP client
- **httpie** - User-friendly HTTP client
- **wrk** - HTTP benchmarking
- **siege** - Load testing
- **hey** - HTTP load generator (via setup.sh)

### Debugging
- **tcpdump** - Packet analyzer
- **nmap** - Network scanner
- **dig** - DNS lookup

## Workspace

After running `distrobox-setup`, a workspace is created:

```
~/nginx-workspace/
├── sites/       # Nginx config files
├── ssl/         # SSL certificates
├── logs/        # Log files
└── html/        # Static content
```

## Helper Commands

| Command | Description |
|---------|-------------|
| `nginx-test [config]` | Test nginx configuration |
| `nginx-start [config]` | Start nginx (foreground) |
| `nginx-reload` | Reload configuration |
| `ssl-gen [domain]` | Generate self-signed certificate |

## Common Workflows

### Basic Server

```bash
# Start default server on :8080
nginx-start

# Test in another terminal
curl localhost:8080
```

### Test Configuration

```bash
# Edit config
nvim ~/nginx-workspace/sites/default.conf

# Test syntax
nginx-test ~/nginx-workspace/sites/default.conf

# Restart
nginx-reload
```

### SSL Setup

```bash
# Generate self-signed cert
ssl-gen localhost

# Use in config:
# ssl_certificate /home/deck/nginx-workspace/ssl/localhost.crt;
# ssl_certificate_key /home/deck/nginx-workspace/ssl/localhost.key;
```

### Load Testing

```bash
# wrk
wrk -t12 -c400 -d30s http://localhost:8080/

# siege
siege -c 50 -t 30s http://localhost:8080/

# hey
hey -n 10000 -c 100 http://localhost:8080/
```

### Reverse Proxy Config

```nginx
server {
    listen 8080;
    location / {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}
```

### Rate Limiting Config

```nginx
limit_req_zone $binary_remote_addr zone=one:10m rate=1r/s;

server {
    listen 8080;
    location / {
        limit_req zone=one burst=5;
        root /home/deck/nginx-workspace/html;
    }
}
```
