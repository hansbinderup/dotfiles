{ config, pkgs, lib, ... }:

{
    programs.tmux = {
        enable = true;
        extraConfig = ''
          run-shell "tmux source-file #{HOME}/repos/dotfiles/tmux.conf"
        '';
    };


    environment.systemPackages = with pkgs; [
        tmate
    ];

    systemd.tmpfiles.rules = lib.concatMap
        (user: [ "L ${user.home}/.tmate.conf - - - - ${user.home}/repos/dotfiles/tmux.conf" ])
        (lib.attrValues (lib.filterAttrs (_: u: u.isNormalUser) config.users.users));
}
