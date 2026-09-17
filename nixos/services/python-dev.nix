{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    python3Packages.python-lsp-server
    python3Packages.uv
  ];
}
