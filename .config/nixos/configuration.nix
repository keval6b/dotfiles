{ config, pkgs, ... }:

{
  imports = [ ./hardware.nix ];

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  boot.loader = {
    efi = { efiSysMountPoint = "/boot/efi"; };
    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
      # useOSProber = true;
    };
  };
  boot.loader.efi.canTouchEfiVariables = true;

  time.timeZone = "Europe/London";

  i18n = { defaultLocale = "en_GB.UTF-8"; };

  services.xserver.enable = true;

  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  environment.plasma5.excludePackages = with pkgs.libsForQt5; [
    elisa
    khelpcenter
    krunner
  ];
  services.xserver.videoDrivers = [ "nvidia" "amdgpu" ];
  services.xserver.excludePackages = [ pkgs.xterm ];
  security.doas = {
    enable = true;
    extraRules = [{
      users = [ "keval" ];
      keepEnv = true;
      persist = true;
    }];
  };
  security.sudo.enable = false;

  networking.hostName = "mercury"; # Define your hostname.
  networking.networkmanager.enable = true;

  hardware.bluetooth = {
    enable = true;
    settings.General.Enable = "Source,Sink,Media,Socket";
  };
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  services.supergfxd.enable = true;
  services.asusd = {
    enable = true;
    enableUserService = true;
  };

  services.xserver.libinput.enable = true;

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
    '';
  };

  programs.gnupg.agent = { enable = true; };

  nixpkgs.config.allowUnfree = true;

  environment = {
    systemPackages = with pkgs; [
      vim
      btop
      git
      git-lfs
      brave
      alacritty
      virt-manager
      vscode
      spotify
      discord
      rofi
      kdeconnect
      nixfmt
    ];
    shells = with pkgs; [ fish ];
  };

  users.defaultUserShell = pkgs.fish;

  users.users.keval = {
    isNormalUser = true;
    description = "Keval Kapdee";
    extraGroups = [ "networkmanager" "libvirtd" "wheel" ];
  };

  networking.firewall.enable = false;

  virtualisation = {
    podman = {
      enable = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}

