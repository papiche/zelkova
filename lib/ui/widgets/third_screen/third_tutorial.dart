import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../../tutorial.dart';
import '../../tutorial_keys.dart';
import '../../tutorial_target.dart';

class ThirdTutorial extends Tutorial {
  ThirdTutorial(BuildContext context)
      : super(tutorialId: 'third_screen', context: context);

  @override
  List<TargetFocus> createTargets() {
    final List<TargetFocus> targets = <TargetFocus>[];
    targets.add(TutorialTarget(
        identify: 'contactsMainKey',
        keyTarget: contactsMainKey,
        align: ContentAlign.top));
    targets.add(TutorialTarget(
        identify: 'contactsQrKey', title: false, keyTarget: contactsQrKey));
    return targets;
  }
}
