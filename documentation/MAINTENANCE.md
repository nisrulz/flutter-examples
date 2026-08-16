# Repository Maintenance

All maintenance commands are available through the `Makefile` at the repository root. Run `make help` to see the full list.

## Available commands

| Command | Description |
| --- | --- |
| `make help` | Show all available commands |
| `make packages` | Run `flutter packages get` for all example apps |
| `make clean-builds` | Move all build folders to trash |
| `make gradle-update` | Upgrade Gradle wrappers to the latest version |

## Update Gradle wrappers

`make gradle-update` upgrades the Gradle wrapper of every example app.

| Option | Description |
| --- | --- |
| `VERSION=<x.y.z>` | Target a specific Gradle version. Default: latest from GitHub |
| `FORCE=1` | Upgrade even when the app is already on the target version |

Examples:

```bash
make gradle-update                             # latest version
make gradle-update VERSION=9.7.0               # specific version
make gradle-update FORCE=1                     # latest version, force update
make gradle-update VERSION=9.7.0 FORCE=1       # specific version, force update
```

## Requirements

- `make` (preinstalled on macOS and most Linux systems)
- `trash` (required by `make clean-builds`): `brew install trash`
