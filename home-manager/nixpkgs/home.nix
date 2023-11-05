{config, pkgs, ... }: {

  home.packages = with pkgs; [
    
  firefox-bin

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
    postman
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
    kubernetes-helm-wrapped
kubernetes-helmPlugins.helm-cm-push
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
gnome-browser-connector
libreoffice-bin
gnome.gnome-terminal
  ];



  programs.firefox.enableGnomeExtensions = true;
  programs.firefox.enableBrowserpass = true;


  home.file.".mozilla/native-messaging-hosts/com.dannyvankooten.browserpass.json".source = "${pkgs.browserpass}/lib/mozilla/native-messaging-hosts/com.dannyvankooten.browserpass.json";
  home.file.".mozilla/native-messaging-hosts/org.gnome.chrome_gnome_shell.json".source = "${pkgs.chrome-gnome-shell}/lib/mozilla/native-messaging-hosts/org.gnome.chrome_gnome_shell.json";

  programs.zsh = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch";
    };

    history = {
      size = 10000;
      path = ".cache/history";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "robbyrussell";
    };
  };

  programs.git = {
    enable = true;
    userName = "xiashura";
    userEmail = "plexanov@protonmail.com";

    includes = [
      { path = "~/.gitconfig";}
    ];
  };

  nixpkgs.config.allowUnfree = true;

  home.sessionVariables = {
    GOBIN = "/home/xi/Projects/go/bin";
    GOPATH = "/home/xi/Projects/go";
    PATH = "$PATH:/home/xi/Projects/go/bin";
    EDITOR = "vim"
  };
  programs.tmux = {
    enable = true;
  };

}

