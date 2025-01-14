# SPDX-FileCopyrightText: 2023 Technology Innovation Institute (TII)
#
# SPDX-License-Identifier: Apache-2.0
{
  self,
  inputs,
  lib,
  ...
}: {
  flake.nixosModules = {
    # shared modules
    azure-common = import ./azure-common.nix;
    common = import ./common.nix;
    generic-disk-config = import ./generic-disk-config.nix;
    # host modules
    host-build01 = import ./build01;
    host-ghafhydra = import ./ghafhydra;
  };

  flake.nixosConfigurations = let
    # make self and inputs available in nixos modules
    specialArgs = {inherit self inputs;};
  in {
    build01 = lib.nixosSystem {
      inherit specialArgs;
      modules = [self.nixosModules.host-build01];
    };
    ghafhydra = lib.nixosSystem {
      inherit specialArgs;
      modules = [self.nixosModules.host-ghafhydra];
    };
  };
}
