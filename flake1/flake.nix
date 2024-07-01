{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    flakelight.url = "github:nix-community/flakelight";
  };
  outputs = { flakelight, nixpkgs, self, ... }@inputs:
    let
      system = "x86_64-linux";
    in
    flakelight ./. {
      inherit inputs;

      nixosConfigurations.vm2 = nixpkgs.lib.nixosSystem {
        inherit system;

        modules = [
          self.nixosModules.default
        ];
      };
    };
}
