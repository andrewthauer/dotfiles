# Experimental WIP

{ config, pkgs, ... }:

let
  pkgsUnstable = import <nixpkgs-unstable> { };

  dotfiles = {
    baseDir = "${config.home.homeDirectory}/.dotfiles";
    modulesDir = "${dotfiles.baseDir}/modules";
  };

  shell = rec {
    initNix = ''
      if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
        . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
      fi
    '';
    sourceLib = ''
      source "${dotfiles.baseDir}/lib/init.sh"
    '';
    sourcePlugins = ''
      source_files_in ${config.xdg.configHome}/shell.d/*.sh
    '';
    profileExtra = ''
      ${initNix}
      ${sourceLib}
      # source "${config.xdg.configHome}/profile"
    '';
  };

  shellAliases = {
    l = "ls -la";
    ll = "ls -la";
    g = "git";
  };

  sessionVariables = {
    DIRENV_LOG_FORMAT = "";
  };

  zshHistorySubstringSearchInit = ''
    #
    # History Substring Search
    # - https://github.com/zsh-users/zsh-history-substring-search
    # - NOTE: The plugin must be sourced after compinit
    #

    # Binding ^[[A/^[[B manually mean up/down works with history-substring-search both before and after zle-line-init
    bindkey '^[[A' history-substring-search-up
    bindkey '^[[B' history-substring-search-down

    # Bind up and down keys
    zmodload -F zsh/terminfo +p:terminfo
    bindkey "\$\{terminfo[kcuu1]}" history-substring-search-up
    bindkey "\$\{terminfo[kcud1]}" history-substring-search-down

    zle -N history-substring-search-up
    zle -N history-substring-search-down
  '';
in
{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = builtins.getEnv "USER";
  home.homeDirectory = builtins.getEnv "HOME";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Packages to install
  home.packages = with pkgsUnstable; [
    # bats
    comma
    # neovim
    niv
    nixpkgs-fmt
    nix-zsh-completions
    ripgrep
    shellcheck
    # shfmt
    stow
    zoxide
  ];

  xdg.enable = true;

  home.file = {
    #
    # base config
    #

    ".hushlogin".source = "${dotfiles.baseDir}/etc/.hushlogin";
    ".stow-global-ignore".source = "${dotfiles.baseDir}/etc/.stow-global-ignore";
    ".stowrc".source = "${dotfiles.baseDir}/etc/.stowrc";

    # shell environment
    # ".config/environment".source = "${dotfiles.baseDir}/etc/.config/environment";
    # ".config/profile".source = "${dotfiles.baseDir}/etc/.config/profile";

    # general utils
    # ".config/shell.d/utility.sh".source = "${dotfiles.baseDir}/shell/.config/shell.d/utility.sh";

    #
    # Modules
    #

    # starship prompt
    ".config/starship.toml".source = "${dotfiles.modulesDir}/starship/.config/starship.toml";

    # git
    ".config/git/aliases".source = "${dotfiles.modulesDir}/git/.config/git/aliases";
    ".config/git/config".source = "${dotfiles.modulesDir}/git/.config/git/config";
    ".config/git/ignore".source = "${dotfiles.modulesDir}/git/.config/git/ignore";

    # github
    ".config/gh/config.yml".source = "${dotfiles.modulesDir}/github/.config/gh/config.yml";

    # xodize
    ".config/shell.d/zoxide.sh".source = "${dotfiles.modulesDir}/zoxide/.config/shell.d/zoxide.sh";

    # neovim
    ".config/nvim".source = "${dotfiles.modulesDir}/vim/.config/nvim";
    ".config/shell.d/nvim.sh".source = "${dotfiles.modulesDir}/vim/.config/shell.d/nvim.sh";

    # other
    ".config/shell.d/docker.sh".source = "${dotfiles.modulesDir}/docker/.config/shell.d/docker.sh";
  };

  home.sessionVariables = {
    DOTFILES_HOME = "${dotfiles.baseDir}";
  } // sessionVariables;

  programs.bash = {
    enable = true;
    historyFile = "${config.xdg.dataHome}/bash/history";
    historyControl = [ "ignoredups" "ignorespace" ];
    historyIgnore = [ "ls" "cd" "exit" ];
    historySize = 1000;
    historyFileSize = 2000;
    shellAliases = shellAliases;
    profileExtra = ''
      ${shell.profileExtra}
      source "${config.xdg.configHome}/environment"
    '';
    initExtra = ''
      ${shell.sourceLib}
      ${shell.sourcePlugins}
    '';
    bashrcExtra = ''
    '';
  };

  programs.zsh = {
    enable = true;

    dotDir = ".config/zsh";

    enableCompletion = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;

    autocd = true;
    # completionInit = "autoload -U compinit && compinit";
    # defaultKeyMap = null;
    # dirHashes = { };

    history = {
      path = "${config.xdg.dataHome}/zsh/history";
      expireDuplicatesFirst = true;
      extended = true;
      ignoreDups = true;
      ignoreSpace = true;
      share = true;
      ignorePatterns = [ "ls" "rm *" "pkill *" ];
      save = 10000;
      size = 10000;
    };

    # localVariables = { };
    # plugins = [ ];
    # sessionVariables = { };
    # loginExtra = "";
    # logoutExtra = "";

    profileExtra = ''
      ${shell.profileExtra}
    '';

    envExtra = ''
      # source "${config.xdg.configHome}/environment"
    '';

    initExtraFirst = ''
      # Enable zprof performance profiling
      [ -n $PROFILE_STARTUP ] && zmodload zsh/zprof
    '';

    initExtra = ''
      fpath=(${config.xdg.configHome}/zsh/plugins/zsh-completions/src \
         ${config.xdg.configHome}/zsh/plugins/nix-zsh-completions \
         $fpath)
    '';

    initExtraBeforeCompInit = ''
      ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#555555,bold,underline"
      ${zshHistorySubstringSearchInit}
      ${shell.sourcePlugins}
    '';

    shellAliases = shellAliases;
    shellGlobalAliases = { };

    plugins = [
      {
        name = "zsh-history-substring-search";
        file = "zsh-history-substring-search.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-history-substring-search";
          rev = "v1.0.2";
          sha256 = "0y8va5kc2ram38hbk2cibkk64ffrabfv1sh4xm7pjspsba9n5p1y";
        };
      }
      {
        name = "zsh-completions";
        file = "zsh-completions.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-completions";
          rev = "0.33.0";
          sha256 = "0vs14n29wvkai84fvz3dz2kqznwsq2i5fzbwpv8nsfk1126ql13i";
        };
      }
    ];
  };

  # programs.git = {
  #   enable = true;
  #   userName = "<username>";
  #   userEmail = "<email>";
  #   aliases = {
  #     st = "status";
  #   };
  # };

  programs.bat = {
    enable = true;
  };

  programs.dircolors = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.neovim = {
    enable = true;
  };

  programs.gpg = {
    enable = true;
    homedir = "${config.xdg.dataHome}/gnupg";
  };

  programs.jq.enable = true;

  programs.starship = {
    enable = true;
    package = pkgsUnstable.starship;
    enableBashIntegration = true;
    enableZshIntegration = true;
    # settings = { };
  };
}
