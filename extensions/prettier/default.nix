{
  pkgs,
  engines,
}: {
  data,
  type ? "default",
}:
with pkgs.lib;
  {
    inherit data;
    format = "json";
    output = ".prettierrc.json";
    engine = engines.cue {
      files = [./templates/default.cue];
    };
  }
  // optionalAttrs (type == "ignore") {
    data = {inherit data;};
    format = "text";
    output = ".prettierignore";
    engine = engines.cue {
      files = [./templates/ignore.cue];
      flags = {
        expression = "rendered";
      };
    };
  }
