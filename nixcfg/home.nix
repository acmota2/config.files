{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "acmota2";
  home.homeDirectory = "/home/acmota2";
  # hyprland stuff
  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.extraConfig = builtins.readFile ./hypr/hyprland.conf;

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
  home.packages = [
    pkgs.gimp
    pkgs.nodePackages_latest.npm

  ];
  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".config/hypr" = {
      source = ./hypr;
      recursive = true;
    };
    ".config/rofi" = {
      source = ./rofi;
      recursive = true;
    };
    ".config/waybar" = {
      source = ./waybar;
      recursive = true;
    };
    ".config/dunst" = {
      source = ./dunst;
      recursive = true;
    };
    ".config/nvim" = {
      source = ./nvim;
      recursive = true;
    };
    ".zshrc".source = ../.zshrc;
  };


  programs.git = {
    enable = true;
    userName = "acmota2";
    userEmail = "acmota2@gmail.com";
    aliases = {
      
    };
  };

  programs.neovim = {
    enable = true;
    extraConfig = ''
        lua << EOF
            $(lib.strings.fileContents ./nvim/init.lua)
        EOF
    '';
    plugins = with pkgs.vimPlugins; [
      packer-nvim
      nvim-treesitter.withAllGrammars
    ];
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/acmota2/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
