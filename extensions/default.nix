{ pkgs, engines, data-merge }:
with pkgs.lib;
let

  # Build a list of all local directory names (same as extension name)
  exts = builtins.attrNames
    (filterAttrs (n: v: v == "directory") (builtins.readDir ./.));

  # Create a list of extension name => import for each extension
  extList = builtins.map
    (p: {
      "${p}" =
        let
          ext = import (builtins.toPath ./. + "/${p}") { inherit pkgs engines; };
        in
        {
          # Implement as functor to allow downstream users
          # to cleanly extend // override a partial config
          # Store args in a transparent accumulator
          __args = { };
          __functor = self: args:
            let
              # Implement with `data-merge` to handle list merging appropriately
              __args = data-merge.merge self.__args args;
            in
            self // (ext __args) // { inherit __args; };
        };
    })
    exts;
in
fold pkgs.lib.recursiveUpdate { } extList
