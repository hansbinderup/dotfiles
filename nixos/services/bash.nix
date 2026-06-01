{ config, pkgs, ... }:

{
  programs.bash = {
        enable = true;
        interactiveShellInit = ''
            if [ -f "$HOME/.secrets/github_token" ]; then
                export GITHUB_TOKEN="$(cat $HOME/.secrets/github_token)"
            fi
            if [ -d "$HOME/repos/beo-scripts" ]; then
                export PATH="$HOME/repos/beo-scripts:$PATH"
            fi
        '';
        shellAliases = {
            ls = "eza -F";
            la = "eza -la";
            grep = "grep --color=auto";
        };

        promptInit = ''
          _nix_shell_indicator() {
            if [ -n "$IN_NIX_SHELL" ]; then
              echo -n $'\001\e[1;36m\002(nix-shell) \001\e[0m\002'
            fi
          }
          PS1="\[\e]2;\h:\u:\w\a\]\$(_nix_shell_indicator)\[\e[1;32m\]\u@\h\[\e[0m\]:\[\e[1;34m\]\w\[\e[0m\]\$ "
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
