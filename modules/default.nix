{
  self,
  ...
}:
{
  flake.nixosModules.default =
    {
      ...
    }:
    {
      imports = [
        self.nixosModules.niri
        self.nixosModules.plymouth
      ];
    };

  flake.homeModules.default =
    {
      ...
    }:
    {
      imports = [
        self.homeModules.niri-stylix
        self.homeModules.noctalia-stylix
        self.homeModules.alacritty-stylix
      ];
    };
}
