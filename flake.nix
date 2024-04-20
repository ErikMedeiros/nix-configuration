{
  description = "my configuration flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    nix-vscode-extensions.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    nixpkgs,
    home-manager,
    nixvim,
    nix-vscode-extensions,
    ...
  }: let
    system = "x86_64-linux";
    extensions = nix-vscode-extensions.extensions.${system};
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [./configuration.nix];
    };

    homeConfigurations.erikm = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = {inherit extensions;};
      modules = [./home.nix nixvim.homeManagerModules.nixvim];
    };
  };
}
