# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "TheLightBeast"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_PT.UTF-8";
    LC_IDENTIFICATION = "pt_PT.UTF-8";
    LC_MEASUREMENT = "pt_PT.UTF-8";
    LC_MONETARY = "pt_PT.UTF-8";
    LC_NAME = "pt_PT.UTF-8";
    LC_NUMERIC = "pt_PT.UTF-8";
    LC_PAPER = "pt_PT.UTF-8";
    LC_TELEPHONE = "pt_PT.UTF-8";
    LC_TIME = "pt_PT.UTF-8";
  };

  # Configure console keymap
  console.keyMap = "pt-latin1";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.acmota2 = {
    isNormalUser = true;
    description = "acmota2";
    extraGroups = [ "docker" "networkmanager" "wheel" ];
    packages = with pkgs; [
      pkgs.macchina
      pkgs.grimblast
    ];
    shell = pkgs.zsh;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = [
    pkgs.neovim
    pkgs.curl
    pkgs.git
    pkgs.kitty
    pkgs.zsh
    pkgs.brave
    pkgs.rofi
    pkgs.pipewire
    pkgs.hyprpaper
    pkgs.discord
    pkgs.pulseaudio
    pkgs.brightnessctl
    pkgs.vscodium
    pkgs.tlp
    pkgs.docker
    pkgs.coreutils-full
    pkgs.libgcc
    pkgs.gdb
    pkgs.go
    pkgs.cargo
    pkgs.python3
    pkgs.elixir
  ];

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  programs.waybar.enable = true;
  programs.zsh.enable = true;
  programs.neovim = {
    enable = true;
    configure.customRC = ''
    	" encoding
	:set encoding=utf-8
	:set fileencoding=utf-8
	:set number

	" tab config

	:set tabstop=4
	:set shiftwidth=4
	:set expandtab

	" syntax
	syntax on
	''
    ;
  };

  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    wireplumber.enable = true;
  };
 
  virtualisation.docker.enable = true;

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-emoji
    fira-code
    fira-code-symbols
    font-awesome
    nerdfonts
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
  system.stateVersion = "23.11"; # Did you read the comment?

}
