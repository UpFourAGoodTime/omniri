{
  inputs,
  ...
}:
{

  flake.homeModules.noctalia-stylix =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {

      imports = [
        inputs.noctalia.homeModules.default
      ];

      options.stylix.targets.omniri-noctalia.enable =
        config.lib.stylix.mkEnableTarget "omniri-Noctalia" true;

      config = lib.mkIf (config.stylix.enable && config.stylix.targets.omniri-noctalia.enable) {

        programs.noctalia = {
          enable = true;

          settings = { # This may also be a string or path to a .toml file.
            theme = {
              mode = lib.mkDefault "dark";
              source = lib.mkDefault "builtin";
              builtin = lib.mkDefault "Catppuccin";
            };

            shell = {
              polkit_agent = true;
            };

            wallpaper = {
              enabled = true;
              default.path = lib.mkDefault "${lib.getExe inputs.self.packages.${pkgs.stdenv.hostPlatform.system}.wallpapers}/share/wallpapers/pb293788xdcqhv8yhjan3w238dw724fr-files/wallhaven-k81776_2880x1620.png}";
            };
          };

      };
    };
    };


  flake.nixosModules.omniri-noctalia =
  {
    pkgs,
    ...
  }:
  {
    imports = [
      inputs.noctalia.nixosModules.default
      inputs.noctalia-greeter.nixosModules.default
    ];

    environment.systemPackages = [
      inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

    systemd.user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };

    security.pam.services.greetd.fprintAuth = false;

    services.displayManager.noctalia-greeter = {
      enable = true;
      settings = {
        cursor.size = 24;
        keyboard.layout = "us";
      };
      cursorTheme = {
        package = pkgs.bibata-cursors;
      };
    };

    programs.noctalia = {
      enable = true;

      # Enables NetworkManager, Bluetooth, UPower, and a power profile service.
      recommendedServices.enable = true;
    };
  };

}
