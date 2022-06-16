{ pkgs, engines }:
with pkgs.lib;
let
  # Build a list of all local directory names (same as extension name)
  exts = builtins.attrNames
    (filterAttrs (n: v: v == "directory") (builtins.readDir ./.));

  # Create a list of extension name => import for each extension
  extList = builtins.map
    (p: {
      "${p}" = import
        (builtins.toPath ./. + "/${p}")
        { inherit pkgs engines; };
    })
    exts;
in
fold (x: y: pkgs.lib.recursiveUpdate x y) { } extList
