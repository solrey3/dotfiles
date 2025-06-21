# AGENTS Instructions

This repository contains various dotfile configurations and setup scripts.

## Code Style

- Format shell scripts using `shfmt -i 2`.
- Lint shell scripts using `shellcheck`.
- Format Lua files using `stylua`.

## Testing

Before committing changes to scripts or configs, run:

```bash
shfmt -d $(git ls-files '*.sh')
shellcheck $(git ls-files '*.sh')
```

If `nix/` or `flake.nix` is modified, attempt `nix flake check`.

## PR Guidelines

- Summaries should reference relevant files using repo-relative paths.
- Include testing results in the PR body. If commands fail due to environment limits, mention it.
