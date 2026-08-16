# Getting Started

## Prerequisites

Install Flutter. See the [official setup guide](https://flutter.dev/setup/).

You also need an editor. See the [Flutter docs](https://flutter.dev/docs/get-started/editor) for setup.

## Run an example app

Clone this repository and install packages:

```bash
git clone https://github.com/nisrulz/flutter-examples.git
cd flutter-examples
make packages
```

Open any example folder in your editor, then run the app on a device or emulator:

```bash
cd <example-folder>
flutter run
```

For example:

```bash
cd simple_material_app
flutter run
```

## Useful links

- [Flutter Widgets Catalog](https://flutter.dev/widgets/)
- [Learn Dart](https://dart.dev/guides)

## Download a single example

The repository is large. If you only want one example, use `svn`:

1. Install `svn` (macOS / Linux):
   ```bash
   brew install svn
   ```
2. Replace `example_folder` in the command below with the example folder name:
   ```bash
   svn checkout https://github.com/nisrulz/flutter-examples/trunk/example_folder
   ```
3. Example:
   ```bash
   svn checkout https://github.com/nisrulz/flutter-examples/trunk/simple_material_app
   ```

That's it. You now have the single example checked out.
