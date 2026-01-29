{
  description = "Anton's entire existance as a flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim/nixos-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix.url = "github:Mic92/sops-nix";

    # stylix.url = "github:danth/stylix/release-24.11";
    # hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";
  };
  outputs =
    inputs@{
      nixpkgs,
      home-manager,
      nixvim,
      # stylix,
      # hyprpanel,
      sops-nix,
      ...
    }:
    let
      system = "x86_64-linux";
    in
    {
      homeConfigurations = {
        "anton" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            config = {
              allowUnfree = true;
            };
            overlays = [
              # hyprpanel.overlay
            ];
          };
          extraSpecialArgs = {
            inherit system;
            inherit inputs;
          };
          modules = [
            ./home.nix
            ./modules
            nixvim.homeModules.nixvim
            # stylix.homeManagerModules.stylix
            sops-nix.homeManagerModules.sops
          ];
        };
      };
    };
}
