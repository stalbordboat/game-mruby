### game-mruby

`game-mruby` is a build and packaging repo for a customized mruby distribution used by [`Game`](https://github.com/stalbordboat/Game).

### What it does?

1. Cloning the official `mruby` repository.
2. Applying a custom build configuration (`game.rb`).
3. Building `mruby` with that configuration.
4. Installing the resulting library, headers, tools, and `pkg-config` metadata.

### Build Process

```sh
MRUBY_CONFIG="build_config/game.rb" rake
```
Or if you want to build on a specific branch:
```sh
rake all[master]
```
You can see the list of all the tasks like this:
```sh
rake -T
```
