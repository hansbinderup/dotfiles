{ config, pkgs, ... }:

{
  programs.bash = {
        enable = true;
        interactiveShellInit = ''
            if [ -f "$HOME/.secrets/github_token" ]; then
                export GITHUB_TOKEN="$(cat $HOME/.secrets/github_token)"
            fi
        '';
        shellAliases = {
            ls = "eza -F";
            la = "eza -la";
            grep = "grep --color=auto";
        };
        promptInit = ''
          PS1="\[\e]2;\h:\u:\w\a\]\[\e[1;32m\]\u@\h\[\e[0m\]:\[\e[1;34m\]\w\[\e[0m\]\$ "
        '';
  };

  environment.systemPackages = with pkgs; [
    eza
  ];

  # pragmatic exception to nixos' store philosophy
  # otherwise we'll get bad interpretation issues..
  # seems like the "standard" fix
  system.activationScripts.binbash = {
    deps = [ "binsh" ];
    text = ''
      ln -sf ${pkgs.bash}/bin/bash /bin/bash
    '';
  };
}
