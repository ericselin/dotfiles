{
  networking.hostName = "zion";
  time.timeZone = "Europe/Stockholm";

  imports = [ ./configuration.nix  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices."luks-c9c2e2f7-b7c6-4af8-ab7b-7118f079c348".device = "/dev/disk/by-uuid/c9c2e2f7-b7c6-4af8-ab7b-7118f079c348";

  networking.networkmanager.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  system.stateVersion = "23.05"; # Do not change
}
