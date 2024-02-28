{ config, pkgs, ... }:

{
imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # Importing Nvidia Modules
      ../../modules/nixos/nvidia.nix
    ];
# Configure xserver
  services.xserver = {
    enable = true;
    libinput.enable = true;
    displayManager.sddm.enable = true;
    videoDriver = "nvidia";
    desktopManager.plasma5.enable = true;
    };

  

  # Xdg Protal
  xdg.portal = {
    enable = true;
    config.common.default = "pkgs.xdg-desktop-portal-kde";
    extraPortals = [ pkgs.xdg-desktop-portal-kde];
  };
  
  environment.systemPackages = with pkgs; [
   
  ];

}
