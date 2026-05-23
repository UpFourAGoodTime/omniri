{
  ...
}:
{
  perSystem =
    {
      pkgs,
      ...
    }:
    {

      packages.wallpapers = pkgs.stdenv.mkDerivation {
        name = "Wallpapers";

        src = ./files;

        phases = [
          "installPhase"
        ];

        installPhase = ''
          mkdir -p $out/share/wallpapers
          cd $src
          cp -r * $out/share/wallpapers
        '';
      };

    };
}
