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
    displayManager.lightdm.enable = true;
    videoDriver = "nvidia";
    # Enabling Qtile
    windowManager.qtile.enable = true;
        # extraPackages = if hasNvidia then [ pkgs.cudaPackages.nvidia_driver pkgs.nvidia-vaapi-driver] else [];
  };

  

  # Xdg Protal
  xdg.portal = {
    enable = true;
    config.common.default = "pkgs.xdg-desktop-portal-kde";
    extraPortals = [ pkgs.xdg-desktop-portal-kde];
  };
  
  environment.systemPackages = with pkgs; [
    # For Qtile
    dunst # Notification
    libnotify
    wireplumber # Sound & Videosharing
    grim
    slurp
    xclip
    mpd
    vlc
    picom # Compositor
    rofi # Launcher
    nitrogen # Wallpaper




  ];

}
