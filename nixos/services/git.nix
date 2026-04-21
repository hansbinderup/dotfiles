{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;

    config = {
      user.name  = "Hans Binderup";
      user.email = "habi@bang-olufsen.dk";

      init.defaultBranch = "main";
    };
  };

  environment.systemPackages = with pkgs; [
    gh
    lazygit
  ];
}
