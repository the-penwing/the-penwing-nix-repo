# the-penwing-nix-repo

A single, central place to get all the software I build via Nix —
like a personal nixpkgs. Instead of adding a separate flake input for
every individual project of mine, or digging through my GitHub account
to find what you want, this repo aggregates everything in one spot.

This isn't an open/community package collection - every
package here is my own software. That said, PRs that improve how
something is built or packaged (not new/unrelated software) are
welcome.

## Usage

    nix run github:the-penwing/the-penwing-nix-repo#blackjack-rs
    nix build github:the-penwing/the-penwing-nix-repo#lua-dungeon-crawler

Or add it as a flake input to your own config:

    inputs.the-penwing.url = "github:the-penwing/the-penwing-nix-repo";

then reference `the-penwing.packages.<system>.<name>` or apply
`the-penwing.overlays.default` to your own `pkgs`.

## Adding a package

Each file in `pkgs/` is self-contained: it fetches that project's source
with `fetchgit` (pinned to a real commit, Nix
resolves `rev` as a git object, not a ref) and reimplements the build
logic itself, rather than importing the project's own `flake.nix`. This
keeps this repo's lockfile small and independent of every sub-project's
own dependency tree, at the cost of some duplicated build logic between
a project's own flake and its entry here.

Drop a new `pkgs/<name>.nix` file in and it's picked up automatically —
no `flake.nix` edits needed.
