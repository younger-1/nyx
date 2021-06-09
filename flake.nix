{
  description = ''
    Nyx is the personal configuration for James Simpson. This repository holdes .dotfile configuration as well as both
    nix (with home-manager) and nixos configurations.
  '';

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    flake-compat.url = "github:edolstra/flake-compat";
    flake-compat.flake = false;

    # Overlays
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
  };


  outputs = { self, ... }@inputs:
  with inputs.nixpkgs.lib;
  let
    inherit (lib.my) mkHomeConfig mkHostConfig mkSystemConfig;

    system = "x86_64-linux";

    lib = inputs.nixpkgs.lib.extend
        (self: super: { my = import ./lib { inherit inputs; lib = self; }; });
  in {
    lib = lib.my;

    internal = {
      overlays = [
        # (self.overlay)
        (inputs.neovim-nightly.overlay)
      ];

      hostConfigurations = inputs.nixpkgs.lib.mapAttrs' mkHostConfig {
        eden = { inherit system; config = ./home/hosts/eden.nix; };
        wsl  = { inherit system; config = ./home/hosts/wsl.nix; };
      };
    };

    homeManagerConfigurations = mapAttrs' mkHomeConfig {
      eden = { inherit system; };
    };

    nixosConfigurations = mapAttrs' mkSystemConfig {
      wsl = { inherit system; config = ./nixos/hosts/wsl; };
    };


    top = let
      nixtop = genAttrs
          (builtins.attrNames inputs.self.nixosConfigurations)
          (attr: inputs.self.nixosConfigurations.${attr}.config.system.build.toplevel);

      hometop = genAttrs
          (builtins.attrNames inputs.self.homeManagerConfigurations)
          (attr: inputs.self.homeManagerConfigurations.${attr}.activationPackage);
    in
    nixtop // hometop;
  };
}
