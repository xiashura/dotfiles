# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];


  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.supportedFilesystems = [ "btrfs" ];
  hardware.enableAllFirmware = true;
  nixpkgs.config.allowUnfree = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub = {
    enable = true;
    version = 2;
    device = "nodev";
    efiSupport = true;
    enableCryptodisk = true;
  };
boot.initrd.luks.devices = {
      root = {
        # Use https://nixos.wiki/wiki/Full_Disk_Encryption
        device = "/dev/disk/by-uuid/bf7ae8d2-a926-42b6-980f-32b86e1c2e20";
        preLVM = true;
      };
  };
  powerManagement.powerUpCommands = with pkgs;''
    ${bash}/bin/bash -c "echo 'RP01      S4    *disabled   pci:0000:00:1c.0' >> /proc/acpi/wakeup"
  '';

  networking.hostName = "thinkpad-nano"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
   time.timeZone = "Asia/Yekaterinburg";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
 #networking.interfaces.enp0s13f0u3u1.useDHCP = true;
  networking.interfaces.wlp0s20f3.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  # Enable the X11 windowing system.
  services.xserver.enable = true;


  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;
  # fix zsh gnome
  environment.pathsToLink = [ "/share/zsh" ];
  environment.shells = [ pkgs.zsh ];
  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.xi = {
     isNormalUser = true;
     shell = pkgs.zsh;
     useDefaultShell = false;
     extraGroups = [ "wheel" "docker" ]; # Enable ‘sudo’ for the user.
   };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
   environment.systemPackages = with pkgs; [
     vim  
     wget
     docker
     kvm
     firefox
     thinkfan
     fwupd
     fprintd
     lm_sensors
     tlp
     gnome.gnome-tweaks
     pinentry-curses
   ];

services.pcscd.enable = true;
programs.gnupg.agent = {
   enable = true;
   pinentryFlavor = "curses";
   enableSSHSupport = true;
};

virtualisation.libvirtd.enable = true;
virtualisation.docker.enable = true;

services.fwupd.enable = true;

services.fprintd.enable = true;
security.pam.services.login.fprintAuth = true;
security.pam.services.xscreensaver.fprintAuth = true;

services.thinkfan = {
  enable = true; 
  levels = [
  [0 0 45]
  ["level auto" 45 60]
  [7 60 255]
  ];
};
  systemd.services.thinkfan.preStart = "
    /run/current-system/sw/bin/modprobe  -r thinkpad_acpi && /run/current-system/sw/bin/modprobe thinkpad_acpi
  ";

services.power-profiles-daemon.enable = false;
services.tlp = {
      enable = true;
      settings = {
	      WIFI_PWR_ON_AC = false;
	      WIFI_PWR_ON_BAT = false;
	      SOUND_POWER_SAVE_CONTROLLER = false;
	      RUNTIME_PM_ON_AC = true;
	      RUNTIME_PM_ON_BAT = true;
	      START_CHARGE_THRESH_BAT0= 75;
	      STOP_CHARGE_THRESH_BAT0 = 80;
      };
    };

fonts.fonts = with pkgs; [
  noto-fonts
  noto-fonts-cjk
  noto-fonts-emoji
(nerdfonts.override { fonts = [ "FiraCode" ]; })
];

  system.stateVersion = "21.11"; # Did you read the comment?

}

