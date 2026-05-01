{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.segger-jlink.acceptLicense = true;

  nixpkgs.config.permittedInsecurePackages = [
      "segger-jlink-qt4-874"
  ];

  environment.systemPackages = with pkgs; [
      segger-jlink
  ];
}
