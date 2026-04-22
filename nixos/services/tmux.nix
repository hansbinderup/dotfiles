{ config, pkgs, ... }:

{
    programs.tmux = {
        enable = true;
        extraConfig = ''
          run-shell "tmux source-file #{HOME}/repos/dotfiles/tmux.conf"
        '';
    };
}
