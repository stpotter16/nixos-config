{
  description = "Nix config for server";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

    biodata.url = "path:/home/balrog/biodata";
  };

  outputs = {
    self,
    nixpkgs,
    biodata,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
  in {
    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      porphyrion = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        # > Our main nixos configuration file <
        modules = [
          ./nixos/configuration.nix
          biodata.nixosModules.default
        ];
      };
    };
  };
}
