{ config, pkgs, ... }:

{
  # rtkit (optional, recommended) allows Pipewire to use the realtime scheduler for increased performance.
  security.rtkit.enable = true;
  services.pipewire = {
      enable = true;
      pulse.enable = true;
      alsa.enable = true;
      wireplumber.enable = true;
  };

  environment.systemPackages = with pkgs; [
      pavucontrol
      playerctl
      pamixer
  ];
}
