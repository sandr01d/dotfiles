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
    # git
    gp = "git pull";
    gP = "git push";
    gS = "git status";
    gr = "git reset";
    gc = "git commit";
    gpp = "git pull && git push";
    gf = "git fetch";
    # forgit
    ga = "git forgit add";
    grh = "git forgit reset_head";
    glo = "git forgit log";
    grl = "git forgit reflog";
    gd = "git forgit diff";
    gso = "git forgit show";
    gi = "git forgit ignore";
    gat = "git forgit attributes";
    gcf = "git forgit checkout_file";
    gcb = "git forgit checkout_branch";
    gco = "git forgit checkout_commit";
    gct = "git forgit checkout_tag";
    gbd = "git forgit branch_delete";
    grc = "git forgit revert_commit";
    gcl = "git forgit clean";
    gclean = "git forgit clean";
    gss = "git forgit stash_show";
    gsp = "git forgit stash_push";
    gcp = "git forgit cherry_pick";
    grb = "git forgit rebase";
    gfu = "git forgit fixup";
    gsq = "git forgit squash";
    grw = "git forgit reword";
    gbl = "git forgit blame";
  };

  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
  };
}

