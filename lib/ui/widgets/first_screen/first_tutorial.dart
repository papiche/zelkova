import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../../tutorial.dart';
import '../../tutorial_keys.dart';
import '../../tutorial_target.dart';

class FirstTutorial extends Tutorial {
  FirstTutorial(BuildContext context)
      : super(tutorialId: 'first_screen', context: context);

  @override
  List<TargetFocus> createTargets() {
    final List<TargetFocus> targets = <TargetFocus>[];
    targets.add(TutorialTarget(
      identify: 'creditCardKey',
      keyTarget: creditCardKey,
      shape: ShapeLightFocus.RRect,
    ));
    targets.add(TutorialTarget(
        identify: 'creditCardPubKey',
        keyTarget: creditCardPubKey,
        shape: ShapeLightFocus.RRect,
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
   /* targets.add(TutorialTarget(
        identify: 'paySentKey',
        keyTarget: paySentKey,
        align: ContentAlign.top,
        shape: ShapeLightFocus.RRect));*/
    return targets;
  }
}
