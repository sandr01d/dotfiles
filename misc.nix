{ ... }:

{
  home.sessionVariables = {
    # Colored manpages using bat
    MANPAGER = "sh -c 'col -bx | bat -l man -p'";
  };

  home.shellAliases = {
    df = "df -h";
    free = "free -m";
    q = "exit";
    }; 
}
