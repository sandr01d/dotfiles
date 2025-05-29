{ ... }:

{
  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      theme = "autumn_night";
      editor = {
        true-color = true;
        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        }; 
        # Only available in helix v25.01+
        # inline-diagnostics = {
        #   cursor-line = "hint";
        #   other-lines = "hint";
        # };
      lsp.display-inlay-hints = true;
      };
    };
  };
}
