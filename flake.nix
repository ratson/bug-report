{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    flakelight.url = "github:nix-community/flakelight";
    flakelight.inputs.nixpkgs.follows = "nixpkgs";
    emacs-ng = {
      url = "github:emacs-ng/emacs-ng";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { flakelight, ... }@inputs:
    flakelight ./. {
      inherit inputs;
      package = { inputs' }: inputs'.emacs-ng.packages.default;
    };
}
