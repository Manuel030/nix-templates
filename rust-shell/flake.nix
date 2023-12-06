{
  description = "Rust developtment environment";

  inputs = {
    nixpkgs.url      = "github:NixOS/nixpkgs/nixos-unstable";
    rust-overlay.url = "github:oxalica/rust-overlay";
    flake-utils.url  = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, rust-overlay, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        overlays = [ 
            (import rust-overlay) 
            (self: super: {
                rustToolchain = nixpkgs.rust-bin.selectLatestNightlyWith
                  (toolchain: toolchain.default.override { extensions = [ "rust-src" "rust-analyzer" ]; });                })
            ];
        pkgs = import nixpkgs {
          inherit system overlays;
        };
      in
      with pkgs;
      {
        devShells.default = mkShell {
            packages = (with pkgs; [
                rustToolchain
                openssl
                pkg-config
            ]);
            RUST_SRC_PATH = rustPlatform.rustLibSrc;
        };
      }
    );
}
