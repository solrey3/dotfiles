{ pkgs }:

let
  pkgsWithConfig = import pkgs.path {
    config = {
      allowUnfree = true;
    };
    inherit (pkgs) system;
  };
in
pkgsWithConfig.mkShell {
  name = "python-youtube-downloader-shell";
  packages = with pkgsWithConfig; [
    python310
    python310Packages.pandas
    python310Packages.frontmatter
    python310Packages.mutagen
    python310Packages.yt_dlp
    ffmpeg
  ];

  shellHook = ''
    echo "Python YouTube Downloader Development Shell"
    echo "Make sure to activate virtualenv if needed."
  '';
}
