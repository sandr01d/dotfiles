{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    diff-so-fancy # used in zsh function in zshrc
    nix-zsh-completions
  ];
  programs.zsh = {
    enable = true;
    # Enter into a directory if typed directly into shell.
    autocd = true;
    syntaxHighlighting.enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    historySubstringSearch = { enable = true; };
    history = {
      # If a new command is a duplicate, remove the older one
      # ignoreAllDups = true;
      # Share history between multiple running instances
      share = true;
      size = 2500;
      save = 3000;
    };
    initExtra = lib.fileContents ./zshrc;
  };
  
  # Enable dircolors for colored ls output
  programs.dircolors = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    # Sets FZF_TMUX=1 for shell integration using fzf-tmux
    tmux.enableShellIntegration = true;
  };
}

