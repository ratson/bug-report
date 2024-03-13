{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    flakelight.url = "github:nix-community/flakelight";
    flakelight.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = { flakelight, ... }@inputs:
    flakelight ./. {
      inherit inputs;

      perSystem = pkgs: {
        packages = {
          hello2 = pkgs.hello;
        };
      };
    };
}
