{
  pkgs,
  engines,
}: {
  commit ? {},
  license ? {},
}:
with pkgs.lib; let
  # Expand out the configuration
  data = {
    policies =
      (optional
        (commit != {})
        {
          type = "commit";
          spec = commit;
        })
      ++ (optional
        (license != {})
        {
          type = "license";
          spec = license;
        });
  };
in {
  inherit data;
  format = "yaml";
  output = ".conform.yaml";
  engine = engines.cue {
    files = [./templates/default.cue];
  };
}
