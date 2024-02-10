# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Moscow";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;

    # setting videodriver
    videoDriver = "amdgpu";
    #enabling touchpad
    libinput.enable = true;
    displayManager.lightdm.enable = true;

    #displayManager.lightdm = {
    #  enable = true;
    #  wayland.enable = true;
    #  };
    # desktopmanager.deepin.enable = true;
};

  # Enabling Hyprland
  programs.hyprland = {
      # Install the packages from nixpkgs
      enable = true;
      # Whether to enable XWayland
      xwayland.enable = true;
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
  };
  
  environment.sessionVariables = {
   # If cursor becomes invisible
   WLR_NO_HARDWARE_CURSORS = "1";
   # Force electron apps to use wayland
   NIXOS_OZONE_WL = "1";
  };

  # Enabling Xdg Portal
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # AMDVLK GPU Driver
  hardware.opengl.enable = true;
  hardware.opengl.extraPackages = with pkgs; [
    amdvlk
];
  # For 32 bit applications 
  hardware.opengl.extraPackages32 = with pkgs; [
    driversi686Linux.amdvlk
  ];


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.zeekirill = {
    isNormalUser = true;
    description = "zeekirill";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;
    packages = with pkgs; [
      firefox
      brave
      thunderbird
      curl
      wget
      git
      shadowsocks-rust
    #  thunderbird
    ];
  };

  programs.fish.enable = true;
  # Setting Default User Shell
  users.defaultUserShell = pkgs.fish;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    neovim
    emacs
    wget
    curl
    fish
    powerline
    ripgrep
    tree-sitter
    lazygit
    bottom
    nodejs_21
    python3
    go
    rustup
    fish
    powerline
    gcc
    clang
    llvm
    blueman
    brightnessctl
    neofetch
    htop
    strace
    lsof
    polkit
    dconf
    unrar
    unzip
    p7zip
    peazip
    ffmpeg
    gparted
    dolphin # Gui file manager (For test)
    qbittorrent
    # For hyprland
    ranger
    waybar
    dunst
    libnotify
    hyprpaper #Wallpaper
    kitty # Default Terminal
    alacritty # Fav Terminal
    rofi-wayland
    wireplumber # Sound & Videosharing
    webcord
    telegram-desktop
    grim # Screenshot util
    slurp # Select Util
    wl-clipboard # xclip alternative
    mpd # Music Player Demon
    vlc # Video

  ];

  # Network Manager Applet
  programs.nm-applet.enable = true;

  #Bluetooth
  services.blueman.enable = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # Fonts
  fonts.packages = with pkgs; [
  noto-fonts
  noto-fonts-cjk
  noto-fonts-emoji
  liberation_ttf
  fira-code
  fira-code-symbols
  mplus-outline-fonts.githubRelease
  dina-font
  proggyfonts
  (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
