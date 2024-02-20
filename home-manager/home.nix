{ config, lib, pkgs, ... }:
let vimConfig = builtins.readFile "/home/xi/.config/home-manager/neovim.vim";
in {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "xi";
  home.homeDirectory = "/home/xi";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    firefox
    tdesktop
    neofetch
    vscode
    tmux
    unzip
    htop
    git
    pass
    ranger
    gnupg
    wl-clipboard
    sshfs
    pam_gnupg
    spotify
    zoom-us
    flameshot
    transmission
    #postman
    dbeaver
    celluloid
    gimp
    pavucontrol
    delve
    zsh
    gcc
    docker-compose
    tor-browser-bundle-bin
    skypeforlinux
    lens
    element-desktop
    xonotic
    mongodb-compass
    virt-manager
    transmission-remote-gtk
    mpv
    python39Packages.docker
    ansible
    terraform_1
    terraform-ls
    logseq
    kubectl
    nixfmt
    kind
    go_1_20
		gopls
    kubernetes-helm-wrapped
    jq
    nodePackages.yaml-language-server
    ansible-lint
    python39
    gnome.nautilus
    gnome-photos
    gnome.gnome-calendar
    shotwell
    evince
    resp-app
    gnome.gnome-terminal
    k9s
    operator-sdk
    gnumake
    fzf
		ripgrep
  ];

  programs.zsh = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch";
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
