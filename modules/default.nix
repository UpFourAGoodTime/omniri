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
        self.nixosModules.omniri-niri
        self.nixosModules.plymouth
        self.nixosModules.omniri-noctalia
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
        self.homeModules.desktop-entries-stylix
        self.homeModules.omniri-niri
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
