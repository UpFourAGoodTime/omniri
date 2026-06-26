{
  self,
  ...
}:
{
  flake.nixosModules.default =
    {
      config,
      lib,
      ...
    }:
    {
      imports = [
        self.nixosModules.niri
        self.nixosModules.plymouth
      ];

      config = lib.mkMerge [
        (lib.mkIf config.stylix.enable {
          stylix.targets = {
            plymouth.enable = false;
          };
        })

      ];

    };

  flake.homeModules.default =
    {
      lib,
      config,
      ...
    }:
    {
      imports = [
        self.homeModules.niri-stylix
        self.homeModules.noctalia-stylix
        self.homeModules.alacritty-stylix
      ];

      config = lib.mkMerge [
        (lib.mkIf config.stylix.enable {
          stylix.targets = {
            alacritty.enable = false;
          };
        })

      ];

    };
}
