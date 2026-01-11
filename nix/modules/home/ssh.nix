{ ... }: {

  programs.ssh = {
    enable = true; # Ensure SSH is enabled.
    startAgent = true; # Start the ssh-agent on login.
    addKeys = [
      "~/.ssh/id_ed25519"
      "~/.ssh/google_compute_engine"
    ];
    extraConfig = ''
      AddKeysToAgent yes
      IdentityFile ~/.ssh/id_ed25519

      Host github.com
        User git
        IdentitiesOnly yes
        StrictHostKeyChecking no
        UserKnownHostsFile=/dev/null

      Host alpha
        HostName alpha.local
        User budchris

      Host bravo
        HostName bravo.local
        User budchris

    '';
  };

  services.ssh-agent.enable = true; # Enable the ssh-agent service.appstream

  programs.keychain = {
    enable = true; # Enable keychain for managing SSH keys.enable
    keys = [ "id_ed25519"];
  };

}
