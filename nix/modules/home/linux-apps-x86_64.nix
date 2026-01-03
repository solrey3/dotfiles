{ pkgs, ... }:

{
  home.packages = with pkgs; [

    ### darwin or x86_64-linux
    chromedriver
    google-chrome
    # synology-drive-client
    #### x86_64-linux only
    # soulseekqt

  ];
}
