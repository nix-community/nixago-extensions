# Nixago Extensions

<p align="center">
    <a href="https://github.com/nix-community/nixago-extensions/actions/workflows/ci.yml">
        <img src="https://img.shields.io/github/workflow/status/nix-community/nixago-extensions/CI?label=CI"/>
    </a>
    <a href="https://nix-community.github.io/nixago-extensions">
        <img src="https://img.shields.io/github/workflow/status/nix-community/nixago-extensions/CI?label=Docs"/>
    </a>
    <img src="https://img.shields.io/github/license/nix-community/nixago-extensions"/>
    <a href="https://builtwithnix.org">
        <img src="https://img.shields.io/badge/-Built%20with%20Nix-green">
    </a>
</p>

> Extensions for generating configurations with [Nixago][1].

This repository contains extensions for generating configuration files for
common development tools using [Nixago][1]. The extensions are designed to ease
the burden of managing multiple template definitions in your local repository.
They each take a simplified input and produce an output that can be directly
passed to the Nixago `make` function.

## Quick Start

Add the extensions to your flake.

```nix
{
  inputs = {
    # ...
    nixpkgs.url = "github:nixos/nixpkgs";
    nixago-exts.url = "github:nix-community/nixago-extensions";
    nixago-exts.inputs.nixpkgs.follows = "nixpkgs";
    # ...
  };
}
```

Call one of the extensions and pass the output to Nixago:

```nix
{
  result = nixago.lib.make (nixago-exts.prettier {
    data = {
      proseWrap = "always";
      };
    });
}
```

See [the docs][2] for information about each extension.

## Testing

Tests are run with:

```shell
nix flake check
```

## Contributing

Check out the [issues][3] for items needing attention or submit your own, and
then:

1. Fork the repo (<https://github.com/nix-community/nixago-extensions/fork>)
2. Create your feature branch (git checkout -b feature/fooBar)
3. Commit your changes (git commit -am 'Add some fooBar')
4. Push to the branch (git push origin feature/fooBar)
5. Create a new Pull Request

[1]: https://github.com/nix-community/nixago
[2]: https://nix-community.github.io/nixago-extensions/
[3]: https://github.com/nix-community/nixago-extensions/issues
