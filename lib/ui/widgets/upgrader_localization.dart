import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:upgrader/upgrader.dart';

/// Custom upgrader messages that integrate with easy_localization.
///
/// This class bridges the upgrader package with Ginkgo's translation system,
/// ensuring update dialogs respect the user's language preference.
///
/// All UI strings are translated using the key-value pairs defined in
/// assets/translations/en.json and assets/translations/es.json
class GinkgoUpgraderMessages extends UpgraderMessages {
  @override
  String get buttonTitleIgnore => tr('update_ignore_button');

  @override
  String get buttonTitleLater => tr('update_later_button');

  @override
  String get buttonTitleUpdate => tr('update_button');

  @override
  String get prompt => tr('update_prompt');

  @override
  String get title => tr('update_available_title');

  @override
  String get body {
    final message = tr('update_available_message');

    // In debug mode with empty versions, provide test versions
    if (kDebugMode && message.contains('{{')) {
      return message
          .replaceAll('{{currentAppStoreVersion}}', '1.5.8')
          .replaceAll('{{currentInstalledVersion}}', '1.5.7');
    }

    return message;
  }
}
