{ pkgs, ... }:

{
  programs.git = {
    enable = true;

    userName = "Paulius Kigas";

    extraConfig = {
      user = {
        useConfigOnly = true;
      };

      push = {
        default = "simple";
      };

      core = {
        editor = "vi";
        excludesFile = toString ./gitignore_global;
      };

      rebase = {
        autosquash = "true";
      };

      merge = {
        conflictStyle = "diff3";
      };

      rerere = {
        enabled = true;
      };

      pull = {
        ff = "only";
      };

      advice = {
        detachedHead = false;
      };
    };

    delta = {
      enable = true;

      options = {
        navigate = true;
        line-numbers = true;
        side-by-side = true;
      };
    };

    aliases = {
      f = "fetch --prune --tags";

      branch-name = "!git rev-parse --abbrev-ref HEAD";

      diffc = "diff --cached";

      publish = "!git push --set-upstream origin `git branch-name`";

      co = "checkout";
      st = "status --short";
      br = "branch";
      rmb = "!f() { git branch -D \"$1\" ; git push origin --delete \"$1\" ; } ; f";

      ls = "log --pretty=format:\"%C(yellow)%h%C(red)%d\\ %C(reset)%s%C(blue)\\ [%an]\" --decorate";
      ll = "log --pretty=format:\"%C(yellow)%h%C(red)%d\\ %C(reset)%s%C(blue)\\ [%an]\" --decorate --numstat";
      ld = "log --pretty=format:\"%C(yellow)%h\\ %ad%C(red)%d\\ %C(reset)%s%C(blue)\\ [%an]\" --decorate --date=relative";
      le = "log --oneline --decorate";

      filelog = "log -u";

      sshow = "!f() { git stash show stash^{/$@} --patch ; } ; f";
      sapply = "!f() { git stash apply stash^{/$@} ; } ; f";
      ssave = "!f() { git stash save \"$@\" ; } ; f";

      refresh = "!f() { git fetch && git rebase origin/master ; } ; f";
      sw = "switch";
    };
  };

  programs.gh = {
    enable = true;

    settings = {
      git_protocol = "ssh";
    };
  };
}

# TODO:
# - interactive-rebase-tool
# - global excludes
