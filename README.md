# Ğ1nkgo

![Ğ1nkgo logo](./assets/img/logo.png 'Ğ1nkgo logo')

Ğ1nkgo (aka Ginkgo) is a lightweight, easy to use Ğ1 wallet for Duniter v1 written in Flutter. The app allows
users to manage their Ğ1 currency and it's focused in simplicity.


## Features

- Introduction for beginners
- Generation of Cesium wallet and persistence (if you refresh the page, it should display the same
  wallet address).
- A point-of-sale device that generates a QR code for the public address and other QR codes with
  amounts (which lightweight wallets will understand).
- Send Ğ1 transactions
- Transactions history page and Balance with persistence to load last transactions on boot
- Contact management and cache (to avoid too much API petitions)
- Internationalization (i18n)
- QR code reader
- Import/export of your wallet
- Automatic discover and selection of nodes, error recovery & retry
- Customizable via [env file](https://git.duniter.org/vjrj/ginkgo/-/blob/master/assets/env.production.txt)
- Inline tutorials
- Pagination of transactions
- Some contextual help (for example, by tapping on "Validity").

## Screenshots

| Wallet                                                           | Terminal card                                                          |
| ---------------------------------------------------------------- | ---------------------------------------------------------------------- |
| ![Card](./assets/img/card.png 'A walled in form of credit card') | ![Terminal card](./assets/img/terminal.png 'A terminal card metaphor') |

## Demo

This is a demo used for testing a development, please use a production server for stability:

[https://g1demo.comunes.net/](https://g1demo.comunes.net/)

## Ğ1nkgo in production

- [https://g1nkgo.comunes.org](https://g1nkgo.comunes.org)
- (...)

## Translations

First of all, you can contribute translating Ğ1nkgo to your language:

[https://weblate.duniter.org/projects/g1nkgo/g1nkgo/](https://weblate.duniter.org/projects/g1nkgo/g1nkgo/)

## Docker

mkdir -p ~/.ginkgo/nginx-conf
mkdir -p ~/.ginkgo/www

## Dev contributions

### Prerequisites

This repository requires [Flutter](https://flutter.dev/docs/get-started/install) to be installed and
present in your development environment.

Clone the project and enter the project folder.

```sh
git clone https://git.duniter.org/vjrj/ginkgo.git
cd ginkgo
```

Get the dependencies.

```sh
flutter pub get
```

### Launch all the tests

```sh
# Unit tests
flutter test

# Integration tests (requires Patrol CLI)
patrol test

# Integration test for specific file
patrol test integration_test/app_smoke_test.dart
```

**Note:** Integration tests use the [Patrol](https://pub.dev/packages/patrol) framework. See [integration_test/README.md](./integration_test/README.md) for detailed instructions.

### Build & deploy

#### Prerequisites

Create a `.env` configuration file (and `.env-dev` for development) in the root of the project. Use the `dot.env.sample` file as template.

See [this issue](https://github.com/frencojobs/envify/issues/6#issuecomment-966892148) if you try to change the `.env` and somehow is cached.

#### Build for web

Use first this command to enable web support:

```sh
flutter config --enable-web
```

Then, build the app:

```sh
flutter build web --no-tree-shake-icons
```

NB: Add `--release` for a production build.

If you are using a web browser different from Chrome, you should first find your browser's executable (example for Brave):

```sh
which brave-browser
```

Then, you should add the executable path to the environment variable `CHROME_EXECUTABLE` by typing the following command:

```sh
export CHROME_EXECUTABLE=/usr/bin/brave-browser
```

NB: This is a temporary solution that will be reset when you close your terminal. If you want to make it permanent, you should add this variable to your `.bashrc` or `.zshrc` file:

```sh
nano ~/.bashrc
```

Then, add the following line at the end of the file:

```sh
export CHROME_EXECUTABLE=/usr/bin/brave-browser
```

Finally, reload your terminal:

```sh
source ~/.bashrc
```

#### Build and deploy to your server

```sh
rsync --progress=info2 --delete -aH build/web/ youruser@yourserver:/var/www/ginkgo/
```

#### Build and deploy Android to Google Play

##### Prerequisites

Set up fastlane:

```sh
cd android
fastlane init
```

Configure your Google Play API key at `/home/vjrj/etc/ginkgo_play_api_key.json` or update the path in `android/fastlane/Fastfile`.

##### Build and upload to production

Build the app bundle (with 16KB page size support for Android 15+):

```sh
flutter clean
flutter pub get
flutter build appbundle --release
```

Then deploy to Google Play production track:

```sh
cd android
fastlane deploy_production_upload
```

This will upload the AAB to the production track with all metadata and assets.

##### Alternative: Deploy to internal testing first

To test on internal track before production:

```sh
cd android
fastlane deploy_internal
```

##### Validate Google Play API connection

To verify your API key is working:

```sh
cd android
fastlane validate
```

### Run dev environment

Run the app via command line or through your development environment. It will run the default built version.

```sh
flutter run
```

NB: If there are more than one built version, there will be a prompt asking for the version you want to use (for example, web or desktop)

If you want to directly run a specific version (for example, the web version), use:

```sh
flutter run -d "chrome"
```

In order to do gva operations, you should disable cors in the flutter run config:

```
--web-browser-flag "--disable-web-security"
```

![cors disable](./assets/img/cors.png 'CORS disabled')

### Linux Build

#### Prerequisites

Install `patchelf` before building Linux packages (required to fix [Flutter issue #65400](https://github.com/flutter/flutter/issues/65400)):

```sh
sudo apt-get install patchelf
```

#### Build Linux bundle and Debian package

```sh
./build.sh linux
```

This will:
1. Build the Linux release bundle
2. Fix RPATH in plugin libraries (Flutter bug #65400)
3. Create a tarball at `../builds-ginkgo/ginkgo-linux-$VERSION.tgz`
4. Build a Debian package at `../builds-ginkgo/g1nkgo-$VERSION-amd64.deb`

#### Known Issues

**Flutter bug #65400**: Flutter Linux builds embed the developer's absolute build path in plugin libraries. Without the RPATH fix, the application would only work on the build machine. Our build script automatically fixes this using `patchelf`.

### Debian package

We use [flutter_to_debian](https://pub.dev/documentation/flutter_to_debian/latest/)

**Note:** Use `./build.sh linux` to build the Debian package with automatic RPATH fixes. Manual builds can be done with:

```sh
flutter_to_debian
```

Expected output:

```
checking for debian 📦 in root project...  ✅

start building debian package... ♻️  ♻️  ♻️

No skeleton found
🔥🔥🔥 (debian 📦) build done successfully  ✅

😎 find your .deb at
build/linux/x64/release/debian/g1nkgo_2.0.3_amd64.deb
```

The version number in the filename will vary based on your current application version.

### Easy Localization

To add translations, add a .json translation file in the [assets/translations](./assets/translations)
folder, by prefixing the file with the language code (for example, `en.json` for English).
The file should be in the format:

```json
{
  "key": "value"
}
```

Then, add the language in the [main.dart](./lib/main.dart) file:

```dart
supportedLocales: const <Locale>[
    Locale('en', ''),
],
```

Go to [ios/Runner/Info.plist](./ios/Runner/Info.plist) and update the following code adding the language:

```

<key>CFBundleLocalizations</key>
<array>
    <string>en</string>
</array>

```

Finally, add the language to the User Interface in the [screen](./lib/fifth_screen.dart) file:

```dart
DropdownMenuItem<Locale>(
  value: Locale('en'),
  child: Text('English'),
),
```

## Troubleshooting

1. If you cannot build the app, try to run `flutter clean` and then `flutter pub get`.
2. If it still doesn't work, try to delete the `build` folder and run `flutter pub get` again.
3. At least, you can try to run `flutter pub upgrade` to upgrade all the dependencies.
4. And in last resort, you can try to delete the `pubspec.lock` file and run `flutter pub get` again.
5. Finally, there is a troubleshooting command in flutter: `flutter doctor -v`.

### Android 16KB Page Size Support

Since November 1st, 2025, Google Play requires all new and updated apps targeting Android 15+ devices to support 16KB memory page sizes. 

The app uses Flutter 3.41.2+, which includes automatic support for 16KB page size alignment. The build process handles this automatically when building with `flutter build appbundle --release`.

To verify 16KB alignment in the generated AAB:

```sh
/path/to/android-sdk/build-tools/36.0.0/zipalign -v -c -P 16 4 build/app/outputs/bundle/release/app-release.aab
```

A successful verification shows "Verification successful" at the end.

## Credits

### Translations

- ast: dixebral
- ca: calbasi
- da: Gerhard Pischinger
- de: anfeichtinger, Christophe Parot, FW, Ruten Rolf, Wahlen
- en: anfeichtinger, Daniel Bañobre Dopico
- eo: flodef, Solaiye, Yves Bachimont
- es: Aldara ES
- eu: Anna Ayala Alcalá, Gobtous, Goiztizar, Solaiye
- fr: Christophe Parot, Cristina Abella, d0p1, flodef, Gobtous, Hugo Trentesaux, italpaola, Maaltir, Michel_du_64, niko, Olivier Michel, poka, Solaiye, vincentux
- gl: Daniel Bañobre Dopico, Vijitâtman
- it: Alis0r, Anna Ayala Alcalá, italpaola
- nl: Maria Rosa Costa i Alandi
- pt: Carlos Neto, Christophe Parot

Thanks!

### Others

- Ğ1 logos from duniter.org
- undraw intro images: https://undraw.co/license
- Chipcard https://commons.wikimedia.org/wiki/File:Chipcard.svg under the Creative Commons
  Attribution-Share Alike 3.0 Unported license.
- [POS svg from wikimedia](https://commons.wikimedia.org/wiki/File:Card_Terminal_POS_Flat_Icon_Vector.svg) CC-BY-SA 4.0
- Open Sans: Copyright 2020 The Open Sans Project Authors (https://github.com/googlefonts/opensans) under the SIL Open Font License, Version 1.1.
- NotoEmoji: Copyright 2013 Google LLC under the SIL Open Font License, Version 1.1.
- Dejavu are (c) Bitstream  DejaVu changes are in public domain.

-----------------------------------------------------------
SIL OPEN FONT LICENSE Version 1.1 - 26 February 2007
-----------------------------------------------------------


### Pub packages used

This repository makes use of the following pub packages:

| Package                                                             | Version | Usage                                                 |
| ------------------------------------------------------------------- | ------- | ----------------------------------------------------- |
| [Durt](https://pub.dev/packages/durt)                               | ^0.1.6  | Duniter crypto lib                                    |
| [Bloc](https://pub.dev/packages/bloc)                               | ^8.1.0  | State management                                      |
| [Flutter Bloc](https://pub.dev/packages/flutter_bloc)               | ^8.1.1  | State management                                      |
| [Hydrated Bloc](https://pub.dev/packages/hydrated_bloc)             | ^9.0.0  | Persists Bloc state with Hive                         |
| [Equatable](https://pub.dev/packages/equatable)                     | ^2.0.5  | Easily compare custom classes, used for Bloc states\* |
| [Flutter Lints](https://pub.dev/packages/flutter_lints)             | ^2.0.1  | Stricter linting rules                                |
| [Path Provider](https://pub.dev/packages/path_provider)             | ^2.0.11 | Get the save path for Hive                            |
| [Flutter Displaymode](https://pub.dev/packages/flutter_displaymode) | ^0.5.0  | Support high refresh rate displays                    |
| [Easy Localization](https://pub.dev/packages/easy_localization)     | ^3.0.1  | Makes localization easy                               |
| [Hive](https://pub.dev/packages/hive)                               | ^2.2.3  | Platform independent storage.                         |
| [Url Launcher](https://pub.dev/packages/url_launcher)               | ^6.1.7  | Open urls in Browser                                  |
| [Ionicons](https://pub.dev/packages/ionicons)                       | ^0.2.2  | Modern icon library                                   |

Thanks!

## License

GNU AGPL v3 (see LICENSE)

```

```
