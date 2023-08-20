{ config, options, pkgs, ...}:

{
  time.timeZone = "Europe/London";

  i18n.defaultLocale = "en_GB.UTF-8";

  ## Doas
  security = {
    sudo.enable = false;
    doas = {
      enable = true;
      extraRules = [{
        users = [ "keval" ];
        keepEnv = true;
        persist = true;
      }];
    };
  };

  ## Fish
  users.defaultUserShell = pkgs.fish;
  environment.shells = [ pkgs.fish ];

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
    '';
  };

  ## Users
  users = {
    users.keval = {
      isNormalUser = true;
      description = "Keval Kapdee";
    };
  };
}
