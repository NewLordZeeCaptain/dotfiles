{ config, pkgs, ... }:

{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-gtk;
  };

  services.emacs.enable = true;


  home.sessionVariables = {
    EMDOTDIR        = "${config.xdg.configHome}/emacs";
    DOOMDOTDIR      = "${config.xdg.configHome}/doom";
    DOOMLOCALDIR    = "${config.xdg.configHome}/doom-local";
  };

  home.sessionPath = [ "${config.xdg.configHome}/emacs/bin" ];

  xdg.configFile = {
    "doom" = {
        source = ../dotfiles/scripts/emacs.sh;
        recursive = true;
        onChange = builtins.readFile ../scripts/reload-doom.sh;
      };
  };
}
