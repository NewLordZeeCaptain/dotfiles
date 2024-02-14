{ config, pkgs, ...}:

{
  programs.neovim = {
    enable = true;

  };

  # home.sessionVariables = {
  #   ZSHRC = "$HOME/.zshrc"
  # };
  #
  xdg.configFile = {
    "zsh" = {
        source = ../dotfiles/scripts/zsh.sh;
        recursive = true;
        onChange = builtins.readFile ../scripts/reload-doom.sh;
      };
  };
  
}
