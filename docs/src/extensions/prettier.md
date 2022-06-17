# Prettier

This plugin generates the `.prettierrc.json` file for configuring [Prettier][1].
It provides two types: one that allows you to configure any [valid API
options][2] and another for generating an ignore file.

## Usage

The schema for the configuration file is [detailed here][3]. For example:

```nix
{
    config = {
      arrowParens = "always";
      bracketSpacing = true;
      tabWidth = 80;
    };
}
```

Produces the following `.prettierrc.json`:

```json
{
  "arrowParens": "always",
  "bracketSpacing": true,
  "tabWidth": 80
}
```

### Ignore type

The extension can also be configured to accept a list of glob patterns used to
determine which files are excluded when `prettier` is run:

```nix
{
  [
    ".direnv"
    ".conform.yaml"
    ".prettierrc.json"
    "tests"
    "CHANGELOG.md"
    "lefthook.yml"
  ]
}
```

When calling the extension, change the type to `ignore`:

```nix
prettier { configData = []; type = "ignore"; }
```

[1]: https://prettier.io/
[2]: https://prettier.io/docs/en/options.html
[3]: https://prettier.io/docs/en/configuration.html
