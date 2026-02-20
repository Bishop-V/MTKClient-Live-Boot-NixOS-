{ config, pkgs,pkgs-unstable, lib, modulesPath, ... }:

{

  networking.hostName = "nixos-mtk"; 

  # Enable networking
  networking.networkmanager.enable = true;

  i18n.defaultLocale = "en_US.UTF-8";
  
  services = {
    xserver = {
      enable = true;
      desktopManager = {
        xterm.enable = false;
        xfce.enable = true;
      };
    };
    displayManager.autoLogin = {
      enable = true;
      user = "mtkclient";
    };
  };

    
  image.modules.iso = {
    isoImage.squashfsCompression = "zstd -Xcompression-level 6";
    # faster
    #isoImage.squashfsCompression = "zstd -Xcompression-level 3";
    # fastest
    #isoImage.squashfsCompression = "lz4";
  };

  boot.loader = {
    systemd-boot.enable = lib.mkForce true;
    grub.enable = lib.mkForce false;
  };

  environment.xfce.excludePackages = with pkgs.xfce; [
    #mousepad
    parole
    #ristretto
    #xfce4-appfinder
    #xfce4-notifyd
    #xfce4-screenshooter
   # xfce4-session
   # xfce4-settings
   # xfce4-taskmanager
   # xfce4-terminal 
  ];

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  users.users."mtkclient" = {
    isNormalUser = true;
    description = "mtkclient";
    extraGroups = [ "networkmanager" "wheel" ];
    password = "1234";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = 
    (with pkgs; [
      neovim 
      librewolf
    ])

    ++

    (with pkgs-unstable; [
      mtkclient
    ]);

  programs.adb.enable = true;

  home-manager.users.mtkclient = { ... }: {
    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "text/html" = "librewolf.desktop";
        "x-scheme-handler/http" = "librewolf.desktop";
        "x-scheme-handler/https" = "librewolf.desktop";
        "x-scheme-handler/about" = "librewolf.desktop";
        "x-scheme-handler/unknown" = "librewolf.desktop";
      };
    };
  home.sessionVariables.BROWSER = "librewolf";
  };

  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "25.11"; 

}
