{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  buildInputs = [
    pkgs.terraform
    pkgs.terraform-ls
  ];
}
