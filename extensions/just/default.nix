{
  pkgs,
  engines,
}: {
  head ? "",
  tasks,
}: let
  # Expand configuration data
  data = {
    data = {
      inherit head tasks;
    };
  };

  # Run the formatter since the output from the Go template engine is ugly
  postHook = ''
    cat $out
    ${pkgs.just}/bin/just --unstable --fmt -f $out
  '';

  # Need to explicitly tell cue what expression to render as text output
  flags = {
    expression = "rendered";
    out = "text";
  };
in {
  inherit data;
  format = "text";
  output = ".justfile";
  engine = engines.cue {
    inherit flags postHook;
    files = [./templates/default.cue];
  };
}
