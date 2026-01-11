{ pkgs }:

pkgs.mkShell {
  name = "github-pages";
  packages = with pkgs; [
    ruby
    bundler
    jekyll
  ];

  shellHook = ''
    bundle install
  '';
}
