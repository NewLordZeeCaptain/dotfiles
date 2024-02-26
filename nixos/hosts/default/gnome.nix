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
    videoDriver = "amdgpu";
    displayManager.gdm.enable = true;
    displayManager.gdm.wayland = true;
    desktopManager.gnome.enable = true;
  };

# Disabling pulseaudio
hardware.pulseaudio.enable = false;

# Exclude useless packages
environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
    gedit
    ]) ++ (with pkgs.gnome; [
    gnome-music
    epiphany
    geary
    evince
    totem
    tali
    iagno
    hitori
    atomix
]);

  programs = {
    xwayland.enable = true;


  };

  # Xdg Protal
  xdg.portal = {
    enable = true;
    config.common.default = "pkgs.xdg-desktop-portal-gnome";
    extraPortals = [ pkgs.xdg-desktop-portal-gnome];
  };
  
  environment.systemPackages = with pkgs; [
	gnomeExtensions.appindicator 
	gnomeExtensions.toggle-proxy 
	gnomeExtensions.gsconnect 
	gnomeExtensions.gtk4-desktop-icons-ng-ding
  ];


}

