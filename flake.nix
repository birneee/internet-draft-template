{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      ...
    }@inputs:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
      in
      rec {
        packages = {
          default = pkgs.stdenvNoCC.mkDerivation {
            name = "draft-todo-yourname-protocol";
            src = pkgs.lib.cleanSource ./.;
            nativeBuildInputs = with pkgs; [
              python3Packages.weasyprint
              rubyPackages.kramdown-rfc2629
              xml2rfc
            ];
            buildPhase = ''
              make
            '';
            installPhase = ''
              install -D out/*.xml -t $out/
              install -D out/*.txt -t $out/
              install -D out/*.html -t $out/
              install -D out/*.pdf -t $out/
            '';
          };
        };
      }
    );
}
