#!/usr/bin/env bash

set -ex

nix run ./flake1#hello1
nix build ./flake1#nixosConfigurations.vm1.config.system.build.vm
nix build ./flake1#nixosConfigurations.vm2.config.system.build.vm

nix run ./flake2#hello2
nix build ./flake2#nixosConfigurations.vm2.config.system.build.vm
