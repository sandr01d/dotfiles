{ pkgs, ... }:

{
  home.packages = with pkgs; [
    zsh-forgit
  ];

  home.sessionVariables = {
    FORGIT_CHECKOUT_BRANCH_BRANCH_GIT_OPTS = "--all --sort=-committerdate";
    FORGIT_BLAME_GIT_OPTS = "--date=iso8601";
  };
  
  programs.git = {
    enable = true;
    diff-so-fancy.enable = true;
    signing.key = "91418C9982B8B76E";
    userName = "sandroid";
    extraConfig = {
      core = {
        autocrlf = "input";
        quotePath = false;
      };
      # color for diff-so-fancy hunk header
      "color \"diff\"" = {
        meta = "blue";
      };
      # use github-cli as credential manager for github
      "credential \"https://github.com\"".helper = "${pkgs.gh}/bin/gh auth git-credential";
      "credential \"https://gist.github.com\"".helper = "${pkgs.gh}/bin/gh auth git-credential";
    };
  };

  home.shellAliases = {
    gp = "git pull";
    gP = "git push";
    gS = "git status";
    gr = "git reset";
    gc = "git commit";
    gpp = "git pull && git push";
    gf = "git fetch";
  };

  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
  };
}

