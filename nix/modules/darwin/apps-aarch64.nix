{ pkgs, ... }: {

  # Homebrew must be installed manually for these apps to work; see https://brew.sh
  #
  # The apps installed by homebrew are not managed by nix, and not reproducible!
  # But on macOS, homebrew has a much larger selection of apps than nixpkgs, especially for GUI apps!
  homebrew = {

    # Applications to install from Mac App Store using mas.
    # You need to install all these Apps manually first so that your apple account have records for them.
    # otherwise Apple Store will refuse to install them.
    # For details, see https://github.com/mas-cli/mas
    # masApps = {
      # Add your favorite apps here.
      # Xcode = 497799835;
      # Wechat = 836500024;
      # NeteaseCloudMusic = 944848654;
      # QQ = 451108668;
      # WeCom = 1189898970;  # Wechat for Work
      # TecentMetting = 1484048379;
      # QQMusic = 595615424;
    # };

    # taps = [
      # "homebrew/services"
    # ];

    # `brew install`
    # Add your favorite apps here.
    # brews = [
    # ];

    # `brew install --cask`
    # Add your favorite apps here.
    casks = [
      "chatgpt"
    ];
  };
}
