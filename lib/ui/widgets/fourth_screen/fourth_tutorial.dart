import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../../tutorial.dart';
import '../../tutorial_keys.dart';
import '../../tutorial_target.dart';

class FourthTutorial extends Tutorial {
  FourthTutorial(BuildContext context)
      : super(tutorialId: 'fourth_screen', context: context);

  @override
  List<TargetFocus> createTargets() {
    final List<TargetFocus> targets = <TargetFocus>[];
    targets.add(TutorialTarget(
      identify: 'txMainKey',
      keyTarget: txMainKey,
      shape: ShapeLightFocus.RRect,
    ));
    targets
        .add(TutorialTarget(identify: 'txRefreshKey', keyTarget: txRefreshKey));
    targets
        .add(TutorialTarget(identify: 'txBalanceKey', keyTarget: txBalanceKey));
    return targets;
  }
}
