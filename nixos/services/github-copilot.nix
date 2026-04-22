{ config, pkgs, ... }:

{
  nixpkgs.config.packageOverrides = pkgs: {
    github-copilot-cli = pkgs.github-copilot-cli.overrideAttrs (oldAttrs: rec {
      version = "1.0.26";
      src = pkgs.fetchurl {
        url = "https://registry.npmjs.org/@github/copilot/-/copilot-${version}.tgz";
        sha256 = "1aiszf105x0a52xz41b32f30xjjyi7bg0jkz14x0qzhiairb9lyc";
      };
    });
  };

  environment.systemPackages = with pkgs; [
    github-copilot-cli
  ];
}
