{ inputs, pkgs, ... }:

{
  environment.systemPackages = [
    inputs.self.packages.${pkgs.system}.hello1
  ];
}
