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
    kernel.sysctl = {
      "net.ipv4.ip_unprivileged_port_start" = 80;
    };
  };

  networking = {
    hostName = "jupiter";
    interfaces.enp0s25.ipv4.addresses = [{
      address = "192.168.16.3";
      prefixLength = 24;
    }];
    defaultGateway = "192.168.16.1";
    nameservers = [ "192.168.16.2" "1.1.1.1" ];
    firewall = {
      enable = true;
      allowedTCPPorts = [
        22 # ssh
        25 # smtp
        53 # dns
        67 # dhcp
        80 # http
        143 # imap
        443 # https internal
        465 # smtps
        587 # smtp
        993 # imaps
        1443 # https external
        # 2080 # pihole http
        # 25565 # minecraft
      ];
      allowedUDPPorts = [
        51820 # wireguard
      ];
    };
  };

  environment = {
    systemPackages = with pkgs; [
      vim
      btop
      git
      git-lfs
      docker-compose
      nixfmt
      bind
      nmap
    ];
  };

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  virtualisation = {
    docker = {
      enable = true;
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
