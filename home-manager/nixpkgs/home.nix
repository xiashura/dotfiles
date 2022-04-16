{ config, lib, pkgs, ... }: 

 {

   #imports =
   # [ # Include the results of the hardware scan.
   #   ./doom.nix
   # ];

  home.packages = with pkgs; [
    tdesktop
    neofetch
    vscode
    tmux	
    unzip
    htop
    git
    discord
    #discord-canary
    pass
    ranger
    gnupg
    wl-clipboard
    sshfs
    pam_gnupg
    spotify
    zoom-us
    flameshot
    vlc 
    transmission
    postman
    dbeaver
    celluloid
    gimp
    pavucontrol
    go_1_17
    delve
    zsh
    gcc
    docker-compose
    tor-browser-bundle-bin 
    libreoffice
    skypeforlinux
    lens
    element-desktop
    xonotic
#transmission-gtk
gnome.gnome-boxes
binance
#emacs-all-the-icons-fonts
ansible
ripgrep
mongodb-compass
  ];


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
    userName  = "xiashura";
    userEmail = "plexanov@protonmail.com";
  };

  nixpkgs.config.allowUnfree = true;

  home.sessionVariables  = { 
    GOBIN = "/home/xi/Projects/go/bin";
    GOPATH = "/home/xi/Projects/go";
  };
 

 
}


