{
  description = "Python development environment";

  inputs = { 
    nixpkgs.url = "github:NixOS/nixpkgs"; 
    flake-utils.url = "github:numtide/flake-utils";
    };

  outputs = { self, nixpkgs, flake-utils }: 

    flake-utils.lib.eachDefaultSystem (system:
      let 
        pkgs = nixpkgs.legacyPackages.${system};
      in
        {
          devShell = pkgs.mkShell {
            packages = [
              (pkgs.python311.withPackages (ps: with ps; [
                virtualenv
                pip
              ]))
            ];
          };
        }
    );
}
