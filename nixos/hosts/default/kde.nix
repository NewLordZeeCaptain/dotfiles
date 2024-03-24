{ config, pkgs, ... }:

{
imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # Importing Nvidia Modules
      # ../../modules/nixos/nvidia.nix
    ];
# Configure xserver
  services.xserver = {
    enable = true;
    videoDriver = "amdgpu";

    libinput.enable = true;
    displayManager.sddm.enable = true;

    desktopManager.plasma6.enable = true;
    displayManager.sddm.wayland.enable = true;
    };

  

  # Xdg Protal
  xdg.portal = {
    enable = true;
    config.common.default = "pkgs.xdg-desktop-portal-kde";
    extraPortals = [ pkgs.xdg-desktop-portal-kde];
  };
  
  environment.systemPackages = with pkgs; [
  # kdePackages.wayland
  # kdePackages.wayland-protocols
  # kdePackages.xdg-desktop-portal-kde
  # kdePackages.ark
  # kdePackages.dolphin
  # kdePackages.gwenview
  # kdePackages.spectacle
  ];

}
