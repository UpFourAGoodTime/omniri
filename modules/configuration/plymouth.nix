{
  ...
}:
{

  flake.nixosModules.plymouth =
    {
      pkgs,
      ...
    }:
    let
      mac-style-src = pkgs.fetchFromGitHub {
        owner = "SergioRibera";
        repo = "s4rchiso-plymouth-theme";
        rev = "bc585b7f42af415fe40bece8192d9828039e6e20";
        sha256 = "sha256-yOvZ4F5ERPfnSlI/Scf9UwzvoRwGMqZlrHkBIB3Dm/w=";
      };

      mac-style-plymouth = pkgs.callPackage mac-style-src { };
    in
    {
      boot = {
        plymouth = {
          enable = true;
          theme = "mac-style";
          themePackages = [ mac-style-plymouth ];
        };

        # Enable "Silent boot"
        consoleLogLevel = 3;
        initrd.verbose = false;
        kernelParams = [
          "quiet"
          "udev.log_level=3"
          "systemd.show_status=auto"
        ];
        # Hide the OS choice for bootloaders.
        # It's still possible to open the bootloader list by pressing any key
        # It will just not appear on screen unless a key is pressed
        loader.timeout = 0;

      };
    };
}
