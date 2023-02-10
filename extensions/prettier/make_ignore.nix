{
  pkgs,
  lib,
}: userData: let
  flags = {
    expression = "rendered";
    out = "text";
  };
  data = {inherit data;};
in {
  inherit data;
  cue = {
    inherit flags;
  };
}
