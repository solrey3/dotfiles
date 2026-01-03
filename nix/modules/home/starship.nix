
{
  programs.starship = {
    enable = true;
    settings = {
      format = "$all";

      username = {
        style_user = "bold fg:#b8bb26";
        show_always = true;
        format = "$user";
      };

      hostname = {
        ssh_only = false;
        format = "@$hostname";  # Combines with username using '@'
        style = "bold fg:#fabd2f";
      };

      directory = {
        format = ":[$path](bold fg:#83a598) ";
        style = "bold fg:#83a598";
        truncation_length = 3;
        truncation_symbol = "…/";
      };

      git_branch = {
        symbol = " ";
        style = "bold fg:#8ec07c";
        format = "on [$branch]($style) ";
      };

      package = {
        symbol = " ";
        style = "bold fg:#fabd2f";
        disabled = false;
      };

      nodejs = {
        symbol = " ";
        style = "bold fg:#b8bb26";
        disabled = false;
      };

      rust = {
        symbol = " ";
        style = "bold fg:#d3869b";
        disabled = false;
      };

      golang = {
        symbol = " ";
        style = "bold fg:#fabd2f";
        disabled = false;
      };

      php = {
        symbol = " ";
        style = "bold fg:#d3869b";
        disabled = false;
      };

      gcloud = {
        symbol = " ";
        style = "bold fg:#fabd2f";
        disabled = false;
      };

      conda = {
        symbol = " ";
        style = "bold fg:#d3869b";
        disabled = false;
      };

      nix_shell = {
        symbol = " ";
        style = "bold fg:#d3869b";
        disabled = false;
      };

      time = {
        format = "[$time](bold fg:#d3869b) ";
        time_format = "%F %T";
        style = "bold fg:#d3869b";
      };

      character = {
        success_symbol = "➜ ";
        error_symbol = "✗ ";
      };
    };
  };
}
