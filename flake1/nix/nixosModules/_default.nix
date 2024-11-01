{ inputs, pkgs, ... }:

{
  environment.systemPackages = [
    inputs.self.packages.${pkgs.system}.hello1
  ];

  system.stateVersion = "24.11";
}
