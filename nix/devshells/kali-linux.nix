{ pkgs }:

pkgs.mkShell {
  packages = with pkgs; [
    nmap          # Network exploration tool and security/port scanner
    wireshark     # Network protocol analyzer
    john          # Password cracker
    aircrack-ng   # Network software suite for WiFi security auditing
    thc-hydra     # Network logon cracker
    sqlmap        # Automatic SQL injection and database takeover tool
    metasploit    # Penetration testing framework
    nikto         # Web server scanner
    gobuster      # Directory/file & DNS busting tool
    hashcat       # Advanced password recovery utility
    burpsuite     # Integrated platform for performing security testing of web applications
    dirb          # Web content scanner
    enum4linux    # Tool for enumerating information from Windows and Samba systems
    hydra         # Network logon cracker
    netcat        # Utility for reading from and writing to network connections
    openvpn       # Open-source VPN software
    smbclient     # Samba client
    tcpdump       # Command-line packet analyzer
    zaproxy       # OWASP Zed Attack Proxy, a security tool for finding vulnerabilities in web applications
    # Add more tools as needed
  ];

  shellHook = ''
    echo "Kali Linux environment activated"
    echo "Starting PostgreSQL service for Metasploit"
    sudo service postgresql start
    echo "Initializing Metasploit database"
    msfdb init
  '';
}
