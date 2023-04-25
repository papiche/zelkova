import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../../tutorial.dart';
import '../../tutorial_keys.dart';
import '../../tutorial_target.dart';

class FifthTutorial extends Tutorial {
  FifthTutorial(BuildContext context)
      : super(tutorialId: 'fifth_screen', context: context);

  @override
  List<TargetFocus> createTargets() {
    final List<TargetFocus> targets = <TargetFocus>[];
    targets
        .add(TutorialTarget(identify: 'infoMainKey', keyTarget: infoMainKey));
    targets.add(TutorialTarget(
        identify: 'exportMainKey',
        keyTarget: exportMainKey,
        align: ContentAlign.right,
        shape: ShapeLightFocus.RRect));
    return targets;
  }
}
