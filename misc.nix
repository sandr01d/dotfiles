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
    ls = "ls -lh --color";
    gp = "git pull";
    gP = "git push";
    gS = "git status";
    gr = "git reset";
    gc = "git commit";
    gpp = "git pull && git push";
  }; 
}
