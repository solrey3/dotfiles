# AGENTS Instructions

This repository contains Nix configurations and development environments.

## Formatting and Style

- Indent all Nix files using **two spaces**. Avoid tabs.
- Ensure every file ends with a trailing newline.
- Run `nix fmt` before committing to format Nix sources.

## Programmatic Checks

Before submitting a change, run the following commands:

1. `nix fmt` – formats all Nix files.
2. `nix flake check` – verifies the flake evaluates correctly.

If these commands fail due to missing dependencies or network restrictions,
use `scripts/setup_testing_tools.sh` to install the necessary tools. Note this in the PR under the **Testing** section.

## Commit Guidelines

- Make small, focused commits with clear messages describing the change.
- Do not amend or rebase existing commits in the pull request.

## Pull Request Guidelines

Include a summary of your changes referencing file paths and line numbers
where appropriate. Provide a **Testing** section describing which commands
were run and their results.

