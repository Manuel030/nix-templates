{
  description = "A nix flake to deliver flake templates";

  inputs = { 
    nixpkgs.url = "github:NixOS/nixpkgs"; 
    flake-utils.url = "github:numtide/flake-utils";
    };

  outputs = { self, nixpkgs, flake-utils }: { 
    templates = {
      rust-shell = {
        path = ./rust-shell;
        description = "Full Rust setup";
      };
      python-shell = {
        path = ./python-shell;
        description = "Full Python setup";
      };
    };
  };
}
