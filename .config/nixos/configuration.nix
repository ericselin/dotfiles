# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:
let
  unstableTarball =
    fetchTarball
      https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz;

  # bash script to let dbus know about important env variables and
  # propagate them to relevent services run at the end of sway config
  # see
  # https://github.com/emersion/xdg-desktop-portal-wlr/wiki/"It-doesn't-work"-Troubleshooting-Checklist
  # note: this is pretty much the same as  /etc/sway/config.d/nixos.conf but also restarts  
  # some user services to make sure they have the correct environment variables
  dbus-sway-environment = pkgs.writeTextFile {
    name = "dbus-sway-environment";
    destination = "/bin/dbus-sway-environment";
    executable = true;

    text = ''
      dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
      systemctl --user restart pipewire xdg-desktop-portal xdg-desktop-portal-wlr
    '';
  };

  # currently, there is some friction between sway and gtk:
  # https://github.com/swaywm/sway/wiki/GTK-3-settings-on-Wayland
  # the suggested way to set gtk settings is with gsettings
  # for gsettings to work, we need to tell it where the schemas are
  # using the XDG_DATA_DIR environment variable
  # run at the end of sway config
  configure-gtk = pkgs.writeTextFile {
    name = "configure-gtk";
    destination = "/bin/configure-gtk";
    executable = true;
    text = let
      schema = pkgs.gsettings-desktop-schemas;
      datadir = "${schema}/share/gsettings-schemas/${schema.name}";
    in ''
      export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
      gnome_schema=org.gnome.desktop.interface
      gsettings set $gnome_schema gtk-theme 'Nordic'
      gsettings set $gnome_schema color-scheme 'prefer-dark'
    '';
  };
in

{
  imports = [ /etc/nixos/hardware-configuration.nix ];

  users.users.eric = {
    isNormalUser = true;
    description = "Eric Selin";
    extraGroups = [ "networkmanager" "wheel" "audio" "docker" "fuse" "lp" "scanner" ];
    packages = with pkgs; [
      firefox
      chromium
      alacritty
      unstable.helix
      fzf
      gopass
      bat
      aerc # email client
      pandoc # viewing html emails
      jq
      lynx
      khal # CLI calendar
      khard # contact management
      isync # email receiving / syncing
      msmtp # email sending, includes queing version msmtpq
      notmuch # email indexing / searching
      vdirsyncer # colendar syncing
      unstable.nextcloud-client # file syncing
      libreoffice
      unzip
      ldns # dns tools, i.e. drill
      fd # for better fzf
      go
      gopls
      marksman # markdown lang server
    ];
  };

  programs = {
    sway = {
      enable = true;
      wrapperFeatures.gtk = true;
      extraPackages = with pkgs; [
        waybar
        wl-clipboard
        dbus-sway-environment
        configure-gtk
        wayland
        xdg-utils # for opening default programs when clicking links
        glib # gsettings
        nordic # nord theme
        adwaita-icon-theme  # default gnome cursors
        swaylock
        swayidle
        brightnessctl
        grim # screenshot functionality
        slurp # screenshot functionality
        mako # notification system developed by swaywm maintainer
        libnotify # notify-send, needed for pomodoro notifications
        simple-scan
      ];
    };
    direnv.enable = true;
    git.enable = true; 
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      pinentryPackage = pkgs.pinentry-gnome3;
    };
  };

  # xdg-desktop-portal works by exposing a series of D-Bus interfaces
  # known as portals under a well-known name
  # (org.freedesktop.portal.Desktop) and object path
  # (/org/freedesktop/portal/desktop).
  # The portal interfaces include APIs for file access, opening URIs
  # printing and others.
  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    # gtk portal needed to make gtk apps happy
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  fonts.packages = with pkgs; [
    inter
    source-code-pro
    noto-fonts
    noto-fonts-color-emoji
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
  # live restore is incompatible with swarm mode,
  # which is useful to enable for testing purposes
  virtualisation.docker.daemon.settings.live-restore = false;

  # mdns for local name resolution
  # mdns doesn't work very well with CUPS
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    # openFirewall = true;
  };

  # per nixos wiki printing article
  services.printing.enable = true;
  
  # scanning per nixos wiki
  hardware.sane = {
    enable = true; # enables support for SANE scanners
    extraBackends = [ pkgs.sane-airscan ];
  };

  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: {
      unstable = import unstableTarball {
        config = config.nixpkgs.config;
      };
    };
  };


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
}
