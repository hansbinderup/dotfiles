{ config, pkgs, ... }:

{
    programs.neovim = {
        enable = true;
        defaultEditor = true;
    };

    environment.systemPackages = with pkgs; [
        ripgrep
        fzf
        gnumake # required for telescope
        gcc # required for TS and telescope
    ];
}
