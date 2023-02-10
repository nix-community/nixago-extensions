{
  pkgs,
  engines,
}: data: {
  inherit data;
  format = "yaml";
  output = ".github/settings.yml";
  hook.mode = "copy";
  engine = engines.cue {
    files = [./templates/default.cue];
  };
}
