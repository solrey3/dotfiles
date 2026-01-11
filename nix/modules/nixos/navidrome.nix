{ config, pkgs, ... }:

{

  services.navidrome = {
    enable = true;
    openFirewall = true;
    settings = {
      DataFolder = "/var/lib/navidrome"; # or a custom path where you want to store the config + DB
      MusicFolder = "/Volumes/T7/Jukebox/";         # replace with the path to your music
      # MusicFolder = "/mnt/sata8tb/Jukebox/Music";         # replace with the path to your music
      Address = "0.0.0.0";
      Port = 4533;
      Scanner.Schedule = "@hourly";  # optional: scan every hour
    };
  };

}
