{
  description = "My macOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-26.05-darwin";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      nix-darwin,
      home-manager,
    }:
    let
      pkgs = nixpkgs.legacyPackages.aarch64-darwin;
      pkgs-unstable = nixpkgs-unstable.legacyPackages.aarch64-darwin;
    in
    {
      formatter.aarch64-darwin = pkgs.writeShellApplication {
        name = "formatter";
        runtimeInputs = [ pkgs.nixfmt ];
        text = ''
          find "''${1:-.}" -name '*.nix' -print0 | xargs -0 nixfmt
        '';
      };

      darwinConfigurations."M5MBA" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./modules/system.nix
          ./modules/homebrew.nix
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit pkgs-unstable; };
            home-manager.users.syon = import ./modules/home.nix;
          }
        ];
      };
    };
}
