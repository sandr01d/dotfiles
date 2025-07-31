{ pkgs, ... }:

{
  home.packages = with pkgs; [
    eza # ls replacement
    erdtree
  ];

  home.sessionVariables = {
    # Colored manpages using bat
    MANPAGER = "sh -c 'col -bx | bat -l man -p'";
    MANROFFOPT="-c";
  };

  home.shellAliases = {
    df = "df -h";
    free = "free -m";
    q = "exit";
    ll = "eza --icons=always -l";
    e = "erd --human --icons --layout=inverted";
  }; 
}
