import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:feedback/feedback.dart';

class CustomFeedbackLocalizations implements FeedbackLocalizations {
  @override
  String get submitButtonText => tr('feedback_submit');

  @override
  String get feedbackDescriptionText => tr('feedback_whats_wrong');

  @override
  String get draw => tr('feedback_draw');

  @override
  String get navigate => tr('feedback_navigate');
}

class CustomFeedbackLocalizationsDelegate
    extends GlobalFeedbackLocalizationsDelegate {
  @override
  // ignore: overridden_fields
  final Map<Locale, FeedbackLocalizations> supportedLocales =
  <Locale, FeedbackLocalizations>{
    const Locale('es', 'AST'): CustomFeedbackLocalizations(),
    const Locale('ca'): CustomFeedbackLocalizations(),
    const Locale('de'): CustomFeedbackLocalizations(),
    const Locale('en'): CustomFeedbackLocalizations(),
    const Locale('es'): CustomFeedbackLocalizations(),
    const Locale('eu'): CustomFeedbackLocalizations(),
    const Locale('fr'): CustomFeedbackLocalizations(),
    const Locale('gl'): CustomFeedbackLocalizations(),
    const Locale('it'): CustomFeedbackLocalizations(),
    const Locale('nl'): CustomFeedbackLocalizations(),
    const Locale('pt'): CustomFeedbackLocalizations(),
  };
}
