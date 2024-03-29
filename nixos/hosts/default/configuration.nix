# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs,inputs, ... }:


{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # Includes Qtile Config
      inputs.home-manager.nixosModules.default
      # ./qtile.nix
      ./kde.nix

    ];

  # Bootloader.
  # boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    useOSProber = true;
    devices = [ "nodev" ];
  };

  # Enabling Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = "zeelinuxpc"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Athens";

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

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.zeekirill = {
    isNormalUser = true;
    description = "zeekirill";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [];
  };

  # Home-manager
  home-manager = {
    # inputs to home-manager modules
    extraSpecialArgs = {inherit inputs; };
    users = {
      "zeekirill" = import ./home.nix;
    };
  };

  # Docker
  virtualisation.docker = {
    enableNvidia = false;
    enable = true;
  };
  # Setting default shell
  programs.fish.enable = true;
  programs.zsh.enable = false;
  users.defaultUserShell = pkgs.fish;
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  # Android emulator
  virtualisation.waydroid.enable = true;

  # Configurating X-Ray
  services.xray = {
    enable = true;
    settingsFile = "/etc/xray/config.json";

    };
  programs.proxychains = {
  enable = true;
  proxies = {
  myproxy = {
    type = "socks5";
    host = "127.0.0.1";
    port = "10808";
  };
    };
  package = pkgs.proxychains;
  };
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    docker
    docker-compose
    waydroid
    fd
    go
    gopls
    insomnia
    beekeeper-studio
    nodePackages.vscode-json-languageserver
    nodePackages.vscode-css-languageserver-bin
    nodePackages.vscode-html-languageserver-bin
    proxychains
    xray
    ksshaskpass
    tree-sitter
    lazygit
    llvm
    clang
    gcc
    nodejs_21
     zsh
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    helix
    nil
    
    pyright
    ruff-lsp
    wget
    neovim
    emacs
    git
    curl
    tree-sitter
    lazygit
    llvm
    clang
    gcc
    python3
    nodejs_21
    rustup
    powerline
    brave
    shadowsocks-rust
    firefox
    neofetch
    dconf
    # blueman
    brightnessctl
    htop
    hwinfo
    strace
    lsof
    polkit
    unrar
    unzip
    p7zip
    ffmpeg
    gparted
    qbittorrent
    fish
    bottom
    ripgrep
    alacritty



    
  ];

# Network Manager Applet
#programs.nm-applet.enable = true;

# Bluetooth
#services.blueman.enable = true;
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
 (nerdfonts.override {fonts = [ "FiraCode" "DroidSansMono"]; })
];


  
  # OpenGL
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages =  [pkgs.vulkan-validation-layers pkgs.intel-media-driver pkgs.vaapiIntel pkgs.vaapiVdpau pkgs.libvdpau-va-gl];
  };

  
   

   # Pipewire Sound
  sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
    jack.enable = true;
  };

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
