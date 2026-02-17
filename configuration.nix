{ config, pkgs,pkgs-unstable, lib, modulesPath, ... }:

{

  nixpkgs.hostPlatform = "x86_64-linux";
  
  networking.hostName = "nixos-mtk"; 

  # Enable networking
  networking.networkmanager.enable = true;

  # Gnome

  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;


  services.gnome = {
    core-apps.enable = false;
    core-developer-tools.enable = false;
    games.enable = false;
  };
  environment.gnome.excludePackages = with pkgs; [ gnome-tour gnome-user-docs ];
  
  
  services.displayManager.autoLogin = {
    enable = true;
    user = "mtkclient";
  };

  
  boot.loader = {
    grub = {
      enable = true;
      efiSupport = true;   
      device = "nodev";          
      timeoutStyle = "hidden";      
    };
    timeout = lib.mkForce 0;                 
  };


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
      gnome-terminal
      gnome-text-editor
      gnomeExtensions.dash-to-dock

    ])

    ++

    (with pkgs-unstable; [
      mtkclient
    ]);

  programs.adb.enable = true;
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "25.11"; 

}
