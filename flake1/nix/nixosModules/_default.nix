{ inputs', ... }:

{
  environment.systemPackages = [
    inputs'.self.packages.hello1
  ];
}
