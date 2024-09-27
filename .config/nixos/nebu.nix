{
  networking.hostName = "nebu";
  time.timeZone = null; # enable setting time zone on the road

  imports = [
    /etc/nixos/networks.nix
    ./configuration.nix 
   ];

  networking.wireless.enable = true;
  
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  system.stateVersion = "22.11"; # Do not change
}
