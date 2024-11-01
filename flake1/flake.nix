{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flakelight.url = "github:ratson/flakelight/fix-module-args";
  };
  outputs = { flakelight, nixpkgs, self, ... }@inputs:
    let
      system = "x86_64-linux";
    in
    flakelight ./. ({ lib, ... }: {
      inherit inputs;

      nixosConfigurations.vm2 = nixpkgs.lib.nixosSystem {
        inherit system;

        modules = [
          self.nixosModules.default
        ];
      };

      nixosConfigurations.vm3 = nixpkgs.lib.nixosSystem {
        inherit system;

        modules = [
          self.nixosModules.wrapped
        ];
      };

      nixosModules.wrapped =
        let
          f = lib.toFunction import ./nix/nixosModules/_default.nix;
          g = args: f (args // { inherit inputs; });
        in
        lib.setFunctionArgs g (lib.functionArgs f);
    });
}
