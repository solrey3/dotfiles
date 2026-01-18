# Distrobox Kali Linux Environment

Kali Linux rolling release container for penetration testing and security research.

## Contents

- **Dockerfile** - Kali Linux with kali-linux-headless metapackage
- **setup.sh** - Post-creation script for additional tools
- **distrobox.ini** - Assemble manifest for quick container creation

## Quick Start

```bash
# Build the image (this takes a while due to kali-linux-headless)
podman build -t distrobox-kali ~/.dotfiles/distrobox/kali/

# Create the container
distrobox create -i distrobox-kali -n kali

# Enter the container
distrobox enter kali

# Run the setup script (first time only)
distrobox-setup
```

## Included Tools

### Recon & Enumeration

| Tool | Description |
|------|-------------|
| nmap | Network scanner |
| masscan | Fast port scanner |
| nikto | Web server scanner |
| dirb/gobuster/ffuf | Directory bruteforce |
| whatweb | Web technology identifier |
| dnsrecon/dnsenum | DNS enumeration |
| enum4linux | SMB enumeration |
| recon-ng | Reconnaissance framework |

### Web Application Testing

| Tool | Description |
|------|-------------|
| sqlmap | SQL injection |
| wpscan | WordPress scanner |
| commix | Command injection |
| feroxbuster | Content discovery |
| hydra | Web form bruteforce |

### Exploitation

| Tool | Description |
|------|-------------|
| metasploit-framework | Exploitation framework |
| searchsploit | Exploit-DB search |
| exploitdb | Exploit database |
| set | Social Engineering Toolkit |

### Password Attacks

| Tool | Description |
|------|-------------|
| john | John the Ripper |
| hashcat | GPU hash cracker |
| hydra | Network login cracker |
| medusa | Parallel login cracker |
| cewl | Wordlist generator |
| crunch | Wordlist generator |

### Wireless

| Tool | Description |
|------|-------------|
| aircrack-ng | WiFi security suite |
| reaver | WPS attacks |
| wifite | Automated wireless auditor |

### Post-Exploitation (via setup.sh)

| Tool | Description |
|------|-------------|
| crackmapexec | Network exploitation |
| impacket | Network protocols |
| bloodhound | AD enumeration |
| pypykatz | Mimikatz in Python |
| pwntools | CTF/exploit dev |

### Forensics & Reverse Engineering

| Tool | Description |
|------|-------------|
| binwalk | Firmware analysis |
| foremost | File carving |
| volatility | Memory forensics |
| radare2 | Reverse engineering |
| gdb | Debugger |

## Common Workflows

### Network Reconnaissance

```bash
# Quick scan
nmap -sn 192.168.1.0/24

# Service scan
nmap -sC -sV -oA scan 192.168.1.100

# Full port scan
nmap -p- --min-rate 1000 192.168.1.100
```

### Web Testing

```bash
# Directory enumeration
ffuf -u http://target/FUZZ -w /usr/share/wordlists/dirb/common.txt

# SQL injection
sqlmap -u "http://target/page?id=1" --batch

# WordPress scan
wpscan --url http://target --enumerate u,p,t
```

### Exploitation

```bash
# Start Metasploit
msfconsole

# Search exploits
searchsploit apache 2.4
```

### Password Cracking

```bash
# John the Ripper
john --wordlist=/usr/share/wordlists/rockyou.txt hashes.txt

# Hashcat (MD5)
hashcat -m 0 hashes.txt /usr/share/wordlists/rockyou.txt
```

## Wordlists

Common wordlists are located at:
- `/usr/share/wordlists/`
- `/usr/share/wordlists/rockyou.txt.gz` (extract first)
- `/usr/share/seclists/` (if installed)

```bash
# Extract rockyou
sudo gunzip /usr/share/wordlists/rockyou.txt.gz
```

## Note on Authorization

These tools are for authorized security testing only. Always ensure you have proper written authorization before testing any systems you do not own.
