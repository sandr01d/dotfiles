{ ... }:

{
  imports = [
    ./git/git.nix
    ./misc.nix
    ./nvim/nvim.nix
    ./tmux/tmux.nix
    ./zsh/zsh.nix
  ];

  home.username = "sandroid";
  home.homeDirectory = "/home/sandroid";

  home.stateVersion = "23.05";
}

