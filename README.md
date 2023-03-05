# Ğ1nkgo

Ğ1nkgo is a lightweight Ĝ1 wallet for Duniter v1 written in Flutter. The app allows users to manage their Ĝ1 currency on their mobile device using just a browser.

## Features

* Introduction for beginners
* Generation of Cesium wallet and persistence (if you refresh the page, it should display the same wallet address).
* A point-of-sale device that generates a QR code for the public address and other QR codes with amounts (which lightweight wallets will understand).
* Internationalization (i18n)
* Some contextual help (for example, by tapping on "Validity").
* Connectivity detection (to retry transactions)
* QR code reader

## Work in progress

*   Send and receive Ĝ1 transactions
*   View transaction history
*   View Ĝ1 balance and currency conversion rate

## Demo

[https://g1demo.comunes.net/](https://g1demo.comunes.net/)

## Installation

This repository requires [Flutter](https://flutter.dev/docs/get-started/install) to be installed and
present in your development environment.

Clone the project and enter the project folder.

```sh
git clone https://git.duniter.org/vjrj/ginkgo.git
cd ginkgo
```

You can remove the screenshots located in [assets/img/](./assets/img).

Get the dependencies.

```sh
flutter pub get
```

Run the app via command line or through your development environment. (optional)

```sh
flutter run lib/main.dart
```

## Pub packages

This repository makes use of the following pub packages:

| Package                                                             | Version | Usage                                                |
|---------------------------------------------------------------------|---------|------------------------------------------------------|
| [Durt](https://pub.dev/packages/durt)                               | ^1.0.6  | Duniter crypto lib                                   |
| [Bloc](https://pub.dev/packages/bloc)                               | ^8.1.0  | State management                                     |
| [Flutter Bloc](https://pub.dev/packages/flutter_bloc)               | ^8.1.1  | State management                                     |
| [Hydrated Bloc](https://pub.dev/packages/hydrated_bloc)             | ^9.0.0  | Persists Bloc state with Hive                        |
| [Equatable](https://pub.dev/packages/equatable)                     | ^2.0.5  | Easily compare custom classes, used for Bloc states* |
| [Flutter Lints](https://pub.dev/packages/flutter_lints)             | ^2.0.1  | Stricter linting rules                               |
| [Path Provider](https://pub.dev/packages/path_provider)             | ^2.0.11 | Get the save path for Hive                           |
| [Flutter Displaymode](https://pub.dev/packages/flutter_displaymode) | ^0.5.0  | Support high refresh rate displays                   |
| [Easy Localization](https://pub.dev/packages/easy_localization)     | ^3.0.1  | Makes localization easy                              |
| [Hive](https://pub.dev/packages/hive)                               | ^2.2.3  | Platform independent storage.                        |
| [Url Launcher](https://pub.dev/packages/url_launcher)               | ^6.1.7  | Open urls in Browser                                 |
| [Ionicons](https://pub.dev/packages/ionicons)                       | ^0.2.2  | Modern icon library                                  |

#### Easy Localization

To add translations, add it to `assets/translations` and enable it in `main.dart`. Also go to [ios/Runner/Info.plist](./ios/Runner/Info.plist) and update the following code:

```
<key>CFBundleLocalizations</key>
<array>
	<string>en</string>
  <string>es</string>
</array>
```
``

## Screenshots

| Wallet                                                                         | Terminal card                                                                    |
|--------------------------------------------------------------------------------|-------------------------------------------------------------------------------|
| ![Card](./assets/img/card.png "A walled in form of credit card") | ![Terminal card](./assets/img/terminal.png "A terminal card metaphor") |

## Credits

- Ĝ1 logo from duniter.org used in the card
- undraw intro images: https://undraw.co/license 
- Chipcard https://commons.wikimedia.org/wiki/File:Chipcard.svg under the Creative Commons Attribution-Share Alike 3.0 Unported license.

Thanks!

## License

GNU AGPL v3 (see LICENSE)
