# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
let
  unstableTarball =
    fetchTarball
      https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz;
in

{
  imports = [ ./hardware-configuration.nix ./networks.nix ];

  users.users.eric = {
    isNormalUser = true;
    description = "Eric Selin";
    extraGroups = [ "networkmanager" "wheel" "audio" "docker" ];
    packages = with pkgs; [
      firefox
      unstable.luakit
      alacritty
      unstable.helix
      fzf
      gopass
      bat
      mutt
      lynx
      khal
      isync
      vdirsyncer
      direnv
      libreoffice
    ];
  };

  programs = {
    sway = {
      enable = true;
      extraPackages = with pkgs; [
        waybar wofi wl-clipboard
        swaylock swayidle
      ];
    };
    git = {
      enable = true;
    }; 
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      pinentryFlavor = "gnome3";
    };
  };

  environment.systemPackages = with pkgs; [
  ];

  fonts.fonts = with pkgs; [
    inter
    source-code-pro
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
    font-awesome
  ];

  console.keyMap = "dvorak-programmer";

  virtualisation.docker.enable = true;

  # per nixos wiki printing article
  services.printing.enable = true;
  services.avahi.enable = true;
  services.avahi.openFirewall = true;
  # ipv6 mdns doesn't work properly at knackeriet
  services.avahi.nssmdns = true;
  # system.nssModules = pkgs.lib.optional (!config.services.avahi.nssmdns) pkgs.nssmdns;
  # system.nssDatabases.hosts = with pkgs.lib; optionals (!config.services.avahi.nssmdns) (mkMerge [
  #   (mkBefore [ "mdns4_minimal [NOTFOUND=return]" ]) # before resolve
  #   (mkAfter [ "mdns4" ]) # after dns
  # ]);
  
  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: {
      unstable = import unstableTarball {
        config = config.nixpkgs.config;
      };
    };
  };

  hardware.pulseaudio = {
    enable = true;
    daemon.config = { default-sample-rate = 48000; };
  };
  nixpkgs.config.pulseaudio = true;

  time.timeZone = null;
  networking.hostName = "nixos"; # Define your hostname.
  networking.wireless = {
    enable = true;  # Enables wireless support via wpa_supplicant.
  };
  
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "sv_SE.UTF-8";
    LC_IDENTIFICATION = "sv_SE.UTF-8";
    LC_MEASUREMENT = "sv_SE.UTF-8";
    LC_MONETARY = "sv_SE.UTF-8";
    LC_NAME = "sv_SE.UTF-8";
    LC_NUMERIC = "sv_SE.UTF-8";
    LC_PAPER = "sv_SE.UTF-8";
    LC_TELEPHONE = "sv_SE.UTF-8";
    LC_TIME = "sv_SE.UTF-8";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
}
