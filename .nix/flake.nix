{
  description = "A very basic flake";

  inputs = {
    # nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
  };

  outputs = { self, nixpkgs }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    
    devShells.${system}.default = pkgs.mkShell {
      packages = with pkgs; [
        jdk
        python3
        clang-tools
        clang
        cmake
        gnumake
      ];

      shellHook = ''
        export PATH="$PATH:$HOME/code/dsa/algorithms/external/mybin:$HOME/code/dsa/algorithms/external/lift"
        export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$HOME/code/dsa/algorithms/external/mybin:$HOME/code/dsa/algorithms/external/lift"
      '';
    };

  };
}
