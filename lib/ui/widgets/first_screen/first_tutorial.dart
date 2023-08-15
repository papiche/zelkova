import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../../tutorial.dart';
import '../../tutorial_keys.dart';
import '../../tutorial_target.dart';

class FirstTutorial extends Tutorial {
  FirstTutorial(BuildContext context, this.onPress)
      : super(tutorialId: 'first_screen', context: context);
  final bool onPress;

  @override
  List<TargetFocus> createTargets() {
    final List<TargetFocus> targets = <TargetFocus>[];
    targets.add(TutorialTarget(
      identify: onPress
          ? !kIsWeb
              ? 'creditCardKey_button'
              : 'creditCardKey_button_web'
          : !kIsWeb
              ? 'creditCardKey'
              : 'creditCardKey_web',
      keyTarget: creditCardKey,
      shape: ShapeLightFocus.RRect,
    ));
    targets.add(TutorialTarget(
        identify: 'creditCardPubKey',
        keyTarget: creditCardPubKey,
        align: ContentAlign.right));
    targets.add(TutorialTarget(
        identify: 'paySearchUserKey',
        keyTarget: paySearchUserKey,
        align: ContentAlign.top,
        shape: ShapeLightFocus.RRect));
    targets.add(TutorialTarget(
        identify: 'payAmountKey',
        keyTarget: payAmountKey,
        align: ContentAlign.top,
        shape: ShapeLightFocus.RRect));
    targets.add(TutorialTarget(
      identify: 'paySentKey',
      keyTarget: paySentKey,
      align: ContentAlign.top,
    ));
    return targets;
  }
}
