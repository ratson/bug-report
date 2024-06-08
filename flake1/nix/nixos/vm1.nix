{ inputs, ... }:

{
  system = "x86_64-linux";

  modules = [
    inputs.self.nixosModules.default
  ];
}
