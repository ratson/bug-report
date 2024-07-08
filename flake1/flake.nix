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

      nixosConfigurations.vm3 = nixpkgs.lib.nixosSystem {
        inherit system;

        modules = [
          self.nixosModules.wrapped
        ];
      };

      nixosModules.wrapped = { ... }@args: import ./nix/nixosModules/_default.nix ({ inherit inputs; } // args);
    };
}

