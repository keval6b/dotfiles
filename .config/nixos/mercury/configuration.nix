{ config, lib, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ../common.nix ];

  boot = {
    loader = {
      efi = {
        efiSysMountPoint = "/boot/efi";
        canTouchEfiVariables = true;
      };
      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
        # useOSProber = true;
      };
    };
  };

  hardware = {
    nvidia = {
      modesetting.enable = true;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
    bluetooth = {
      enable = true;
      settings.General.Enable = "Source,Sink,Media,Socket";
    };
  };

  networking = {
    hostName = "mercury";
    networkmanager.enable = true;
    firewall = {
      enable = true;
      # allowedUDPPorts = [ 51820 ];
    };
  };

  nixpkgs.config.allowUnfree = true;

  services = {
    xserver = {
      enable = true;
      displayManager.sddm.enable = true;
      desktopManager.plasma5.enable = true;
      videoDrivers = [ "nvidia" "amdgpu" ];
      excludePackages = [ pkgs.xterm ];
      libinput.enable = true;
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    supergfxd.enable = true;
    asusd = {
      enable = true;
      enableUserService = true;
    };
  };

  security.rtkit.enable = true;

  programs = {
    gnupg.agent.enable = true;
    kdeconnect.enable = true;
    partition-manager.enable = true;
  };

  virtualisation.docker.enable = true;

  environment = {
    plasma5.excludePackages = with pkgs.libsForQt5; [
      elisa
      khelpcenter
      konsole
    ];
    systemPackages = with pkgs; [
      alacritty
      bind
      brave
      btop
      discord
      filelight
      git
      git-lfs
      libsForQt5.kalk
      nixfmt
      docker-compose
      spotify
      vim
      virt-manager
      (vscode-with-extensions.override {
        vscodeExtensions = with vscode-extensions; [
          bbenoist.nix
          ms-vscode-remote.remote-ssh
        ];
      })
    ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
