{ config, lib, pkgs, ... }:
let vimConfig = builtins.readFile "/home/xi/.config/home-manager/neovim.vim";
in {
  home.username = "xi";
  home.homeDirectory = "/home/xi";

  home.stateVersion = "23.11"; # Please read the comment before changing.

  home.packages = with pkgs; [
    neofetch
    tmux
    unzip
    htop
    git
    ranger
    sshfs
    delve
    gcc
    docker-compose
    python39Packages.docker ansible
    terraform_1
    terraform-ls
		terraform-lsp
		tflint
    kubectl
    nixfmt
    kind
    go_1_21
		gopls
    kubernetes-helm-wrapped
    jq
    nodePackages.yaml-language-server
    ansible-lint
    python39
    k9s
    operator-sdk
    gnumake
    fzf
		ripgrep
		openssl
		lsd
  ];

  programs.zsh = {
    enable = true;
    shellAliases = {
			ls = "lsd";
      ll = "ls -l";
      update = "sudo nixos-rebuild switch";
			vim = "nvim";
			v = "nvim";
			neofetch = "neofetch --kitty ~/Pictures/avatar/Asahi_Linya.png --size 550px";
    };

    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/.cache/history";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "kubectl" "kubectx" ];
      custom = "$HOME/.config/zsh";
      extraConfig = ''
        RPS1='🔮%F{white}$(kubectx_prompt_info)'
      '';
      theme = "gentoo";
    };
  };

  programs.neovim = {
    enable = true;
    withNodeJs = true; # for coc.nvim
    withPython3 = true; # for plugins
    extraConfig = builtins.readFile "/home/xi/.config/home-manager/neovim.vim";
    plugins = with pkgs.vimPlugins; [
      vim-multiple-cursors
      nerdtree
      vim-devicons
      coc-nvim
      vim-commentary
      nerdtree-git-plugin
      vim-gitgutter
      vim-fugitive
      vim-signify
      fzf-vim
			nvim-dap
			nvim-dap-virtual-text
			nvim-dap-ui
			nvim-dap-go
			molokai
			comment-nvim
			vim-colorschemes
    ];
  };

  programs.git = {
    enable = true;
    userName = "xiashura";
    userEmail = "plexanov@protonmail.com";
  };

  nixpkgs.config.allowUnfree = true;

  home.sessionVariables = {
    GOBIN = "/home/xi/Projects/go/bin";
    GOPATH = "/home/xi/Projects/go";
    PATH = "$PATH:/home/xi/Projects/go/bin";
    EDITOR = "noevim";
  };
  programs.tmux = { enable = true; };
  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/xi/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    # EDITOR = "vim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
