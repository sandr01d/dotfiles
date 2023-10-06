{ lib, ... }:

{
  programs.tmux = {
    enable = true;
    terminal = "tmux-256color";
    keyMode = "vi";
    newSession = true;
    clock24 = true;
    extraConfig = lib.fileContents ./tmux.conf;
  };
}

