{
  networking.hostName = "nebu";
  networking.wireless.enable = true;
  imports = [
    /etc/nixos/networks.nix
    ./configuration.nix 
   ];

  # enable setting time zone on the road
  time.timeZone = null;
  
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };
  # pulseaudio doesn't work when enabled via pipewire
  # hardware.pulseaudio = {
  #   enable = true;
  #   daemon.config = { default-sample-rate = 48000; };
  # };
  # nixpkgs.config.pulseaudio = true;

  system.stateVersion = "22.11"; # Do not change
}
