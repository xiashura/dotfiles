# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:
let
nixpkgs = import <nixpkgs> { overlays = [ 
(self: super: {
  # elements of pkgs.gnome must be taken from gself and gsuper
  gnome = super.gnome.overrideScope' (gself: gsuper: {
    mutter = gsuper.mutter.override {
	 version = "42.0";
    };
  });
})

 ]; };
in 
{



  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];


  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.supportedFilesystems = [ "btrfs" ];
  hardware.enableAllFirmware = true;
  nixpkgs.config.allowUnfree = true;

#  boot.loader.systemd-boot.enable = true;
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


  powerManagement.resumeCommands = with pkgs;''
    ${bash}/bin/bash -c "echo 'RP01      S4    *disabled   pci:0000:00:1c.0' >> /proc/acpi/wakeup"
  '';


  #powerManagement.powerDownCommands = with pkgs;''
    #${bash}/bin/bash -c "echo 'RP01      S4    *disabled   pci:0000:00:1c.0' >> /proc/acpi/wakeup"
  #'';


  networking.hostName = "thinkpad-nano"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
networking.networkmanager.enable = true;
  # Set your time zone.
   time.timeZone = "Europe/Moscow";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
 #networking.interfaces.enp0s13f0u3u1.useDHCP = true;
  networking.interfaces.wlp0s20f3.useDHCP = true;

  networking.extraHosts = ''
    127.0.0.1 docker.loc
    127.0.0.1 api.docker.loc
  '';

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
   i18n.defaultLocale = "en_US.UTF-8";
   console = {
     font = "Lat2-Terminus16";
     keyMap = "us";
   };

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
     extraGroups = [ "wheel" "docker" "video" "audio" "libvirtd" ]; # Enable ‘sudo’ for the user.
   };

   nix = {
    package = pkgs.nixFlakes; # or versioned attributes like nixVersions.nix_2_8
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
   };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
   environment.systemPackages = with pkgs; [
     vim  
     wget
     docker
     qemu_kvm
     firefox
     thinkfan
     fwupd
     fprintd
     lm_sensors
     tlp
     gnome.gnome-tweaks
     docker-compose
     pinentry-curses
     sof-firmware
     pipewire
     helvum
     throttled
# vulkan-tools
#     lutris
thermald
transmission-gtk
gnome.zenity
#    wine
#cabextract
#linuxKernel.packages.linux_zen.xmm7360-pci
   ];
#  hardware.opengl.enable = true;
#  hardware.pulseaudio.support32Bit = true;
#hardware.opengl.driSupport32Bit = true;

      services.flatpak.enable = true;

#networking.firewall.extraCommands = ''
#  iptables -A nixos-fw -p udp --source 192.168.0.0/24 --dport 20594:20596 -j nixos-fw-accept
#'';

 services.throttled  = { 
	enable = true;
        extraConfig = ''
[GENERAL]
# Enable or disable the script execution
Enabled: True
# SYSFS path for checking if the system is running on AC power
Sysfs_Power_Path: /sys/class/power_supply/AC*/online
# Auto reload config on changes
Autoreload: True

## Settings to apply while connected to Battery power
[BATTERY]
# Update the registers every this many seconds
Update_Rate_s: 30
# Max package power for time window #1
PL1_Tdp_W: 29
# Time window #1 duration
PL1_Duration_s: 28
# Max package power for time window #2
PL2_Tdp_W: 44
# Time window #2 duration
PL2_Duration_S: 0.002
# Max allowed temperature before throttling
Trip_Temp_C: 85
# Set cTDP to normal=0, down=1 or up=2 (EXPERIMENTAL)
cTDP: 0
# Disable BDPROCHOT (EXPERIMENTAL)
Disable_BDPROCHOT: False

## Settings to apply while connected to AC power
[AC]
# Update the registers every this many seconds
Update_Rate_s: 5
# Max package power for time window #1
PL1_Tdp_W: 44
# Time window #1 duration
PL1_Duration_s: 28
# Max package power for time window #2
PL2_Tdp_W: 44
# Time window #2 duration
PL2_Duration_S: 0.002
# Max allowed temperature before throttling
Trip_Temp_C: 95
# Set HWP energy performance hints to 'performance' on high load (EXPERIMENTAL)
# Uncomment only if you really want to use it
# HWP_Mode: False
# Set cTDP to normal=0, down=1 or up=2 (EXPERIMENTAL)
cTDP: 0
# Disable BDPROCHOT (EXPERIMENTAL)
Disable_BDPROCHOT: False

# All voltage values are expressed in mV and *MUST* be negative (i.e. undervolt)! 
[UNDERVOLT.BATTERY]
# CPU core voltage offset (mV)
CORE: 0
# Integrated GPU voltage offset (mV)
GPU: 0
# CPU cache voltage offset (mV)
CACHE: 0
# System Agent voltage offset (mV)
UNCORE: 0
# Analog I/O voltage offset (mV)
ANALOGIO: 0

# All voltage values are expressed in mV and *MUST* be negative (i.e. undervolt)!
[UNDERVOLT.AC]
# CPU core voltage offset (mV)
CORE: 0
# Integrated GPU voltage offset (mV)
GPU: 0
# CPU cache voltage offset (mV)
CACHE: 0
# System Agent voltage offset (mV)
UNCORE: 0
# Analog I/O voltage offset (mV)
ANALOGIO: 0

# [ICCMAX.AC]
# # CPU core max current (A)
# CORE: 
# # Integrated GPU max current (A)
# GPU: 
# # CPU cache max current (A)
# CACHE: 

# [ICCMAX.BATTERY]
# # CPU core max current (A)
# CORE: 
# # Integrated GPU max current (A)
# GPU: 
# # CPU cache max current (A)
# CACHE
'';
};


hardware.pulseaudio.enable = false;
security.rtkit.enable = true;
services.pipewire = {
  enable = true;
  alsa.enable = true;
  alsa.support32Bit = true;
  pulse.enable = true;
  # If you want to use JACK applications, uncomment this
  #jack.enable = true;

  # use the example session manager (no others are packaged yet so this is enabled by default,
  # no need to redefine it in your config for now)
  #media-session.enable = true;
};

services.pcscd.enable = true;
programs.gnupg.agent = {
   enable = true;
   pinentryFlavor = "curses";
   enableSSHSupport = true;
};



virtualisation.libvirtd.enable = true;
services.qemuGuest.enable=true;
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
	CPU_SCALING_GOVERNOR_ON_AC= "performance";
	#CPU_SCALING_GOVERNOR_ON_AC= "powersave";
	CPU_SCALING_GOVERNOR_ON_BAT= "powersave";
	#CPU_ENERGY_PERF_POLICY_ON_AC= "powersave";
	CPU_ENERGY_PERF_POLICY_ON_AC= "performance";

	WIFI_PWR_ON_AC = false;
	WIFI_PWR_ON_BAT = false;
	SOUND_POWER_SAVE_CONTROLLER = false;
	RUNTIME_PM_ON_AC = true;
	RUNTIME_PM_ON_BAT = true;
	START_CHARGE_THRESH_BAT0= 75;
	STOP_CHARGE_THRESH_BAT0 = 80;
      };
    };

 #systemd.services.thinkpad-nano-fix = {
 #   enable = true;
 #   description = "fix thinkpad nano";
 #   serviceConfig = {
 #     ExecStart = ''${pkgs.bash}/bin/bash -c 'echo "RP01      S4    *disabled   pci:0000:00:1c.0" >> /proc/acpi/wakeup' '';
 #   };
 #       wantedBy = [ "multi-user.target" "sleep.target" ];
 # };


fonts.fonts = with pkgs; [
  noto-fonts
  noto-fonts-cjk
  noto-fonts-emoji
(nerdfonts.override { fonts = [ "FiraCode" ]; })
];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "unstable"; # Did you read the comment?

}
