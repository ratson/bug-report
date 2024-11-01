{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake1.url = "path:../flake1";
  };
  outputs = { nixpkgs, flake1, ... }@inputs:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations.vm2 = nixpkgs.lib.nixosSystem {
        inherit system;

        modules = [
          flake1.nixosModules.default
        ];
      };

      packages.${system}.hello2 = flake1.packages.${system}.hello1;
    };
}
