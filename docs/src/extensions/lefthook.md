# Lefthook

This extension generates the `lefthook.yml` file for configuring [Lefthook][1].

## Usage

```nix
{
    data = {
        commit-msg = {
            scripts = {
                template_checker = { runner = "bash"; };
            };
        };
        pre-commit = {
            commands = {
                stylelint = {
                    tags = "frontend style";
                    glob = "*.js";
                    run = "yarn stylelint {staged_files}";
                };
                rubocop = {
                    tags = "backend style";
                    glob = "*.rb";
                    exclude = "application.rb|routes.rb";
                    run = "bundle exec rubocop --force-exclusion {all_files}";
                };
            };
            scripts = {
                "good_job.js" = { runner = "node"; };
            };
        };
    };
}
```

Produces the following `lefthook.yml`:

```yaml
commit-msg:
  scripts:
    template_checker:
      runner: bash
pre-commit:
  commands:
    rubocop:
      exclude: application.rb|routes.rb
      glob: "*.rb"
      run: bundle exec rubocop --force-exclusion {all_files}
      tags: backend style
    stylelint:
      glob: "*.js"
      run: yarn stylelint {staged_files}
      tags: frontend style
  scripts:
    good_job.js:
      runner: node
```

[1]: https://github.com/evilmartians/lefthook
[2]: https://github.com/evilmartians/lefthook/blob/master/docs/full_guide.md
