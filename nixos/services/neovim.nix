{ config, pkgs, ... }:

{
    programs.neovim = {
        enable = true;
        defaultEditor = true;
    };

    environment.systemPackages = with pkgs; [
        ripgrep
        fzf
        llvmPackages_21.clang-unwrapped
        gnumake # required for telescope
        gcc # required for TS and telescope
    ];
}
