{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    meslo-lgs-nf

    prettyping
    lsd
    bat
    fd

    asdf-vm

    python3
    poetry

    nodejs
    yarn
  ];

  xdg.configFile."bat/config".text = ''--style="numbers,changes"'';

  xdg.configFile."lsd/config.yaml".source = ./lsd-config.yaml;

  xdg.configFile."asdf-vm/.asdfrc".text = ''legacy_version_file = yes'';

  home.file.".digrc".text = ''+noall +answer'';

  programs.ripgrep.enable = true;
  programs.bottom.enable = true;
  programs.jq.enable = true;

  home.sessionPath = [ "/opt/homebrew/bin" ];

  programs.zsh = {
    enable = true;

    enableCompletion = true;

    enableVteIntegration = true;

    dotDir = ".config/zsh";

    defaultKeymap = "emacs";

    syntaxHighlighting = {
      enable = true;
    };

    history = {
      extended = true;
      ignoreDups = true;
      ignoreAllDups = true;
      expireDuplicatesFirst = true;
      share = true;
    };

    initExtra = ''
      setopt EXTENDED_GLOB
      autoload -U select-word-style && select-word-style bash

      zstyle ':completion:*' completer _extensions _complete _approximate

      zstyle ':completion:*' use-cache on
      zstyle ':completion:*' cache-path "''${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompcache"

      zstyle ':completion:*:*:*:*:descriptions' format '%F{green}-- %d%f'
      zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e)%f'

      zstyle ':completion:*' group-name '''

      zstyle ':completion:*:default' list-colors ''${(s.:.)LS_COLORS}

      zstyle ':autocomplete:*' groups 'always'
    '';

    # important to define this before zplug
    initExtraBeforeCompInit = ''
      if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi

      # zstyle ":zplug:tag" defer 1
    '';


    zplug = {
      enable = true;

      zplugHome = "${config.xdg.dataHome}/zplug";

      plugins = [
        # { name = toString ./p10k; tags = [ from:local use:p10k-instant-prompt.zsh defer:0 ]; }
        { name = "zsh-users/zsh-autosuggestions"; tags = [ depth:1 ]; }
        { name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ]; }
        # { name = "plugins/asdf"; tags = [ from:oh-my-zsh depth:1 ]; }
        { name = "plugins/docker-compose"; tags = [ from:oh-my-zsh depth:1 ]; }
        { name = "plugins/yarn"; tags = [ from:oh-my-zsh depth:1 ]; }
        { name = toString ./p10k; tags = [ from:local use:p10k.zsh defer:1 ]; }
      ];
    };

    sessionVariables = {
      # colorful manpages
      MANPAGER = "sh -c 'col -bx | bat --language=man --plain'";
      MANROFFOPT = "-c";

      PIP_REQUIRE_VIRTUALENV = "true";
      AWS_SDK_LOAD_CONFIG = "1";

      ASDF_DIR = "${pkgs.asdf-vm}/share/asdf-vm";
      ASDF_CONFIG_FILE = "${config.xdg.configHome}/asdf-vm/.asdfrc";
      ASDF_DATA_DIR = "${config.xdg.dataHome}/asdf-vm";

      DIRENV_LOG_FORMAT = "";
    };

    shellAliases = {
      ping = "${pkgs.prettyping}/bin/prettyping --nolegend";
      top = "${pkgs.bottom}/bin/bottom";
      cat = "${pkgs.bat}/bin/bat";
      ls = "${pkgs.lsd}/bin/lsd";
    };
  };
}
