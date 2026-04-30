{
  description = "NixOS dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, disko, ... }: {
    nixosConfigurations.nixos-work = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { username = "habi"; };
      modules = [
        disko.nixosModules.disko
        ./nixos/disko.nix
        ./nixos/configuration.nix
      ];
    };

    nixosConfigurations.iso = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit self; };
      modules = [
        "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
        disko.nixosModules.disko
        ./nixos/iso.nix
      ];
    };
  };
}
