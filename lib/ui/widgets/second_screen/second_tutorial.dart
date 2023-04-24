import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../../tutorial.dart';
import '../../tutorial_keys.dart';
import '../../tutorial_target.dart';
import 'pos_widget.dart';

class SecondTutorial extends Tutorial {
  SecondTutorial(BuildContext context)
      : super(tutorialId: 'second_screen', context: context);

  @override
  List<TargetFocus> createTargets() {
    final List<TargetFocus> targets = <TargetFocus>[];
    targets.add(TutorialTarget(
        identify: 'receiveMainKey',
        keyTarget: receiveMainKey,
        align: ContentAlign.top,
        extraWidget: POSWidget(context: context)));
    targets.add(TutorialTarget(
        identify: 'receiveQrKey',
        keyTarget: receiveQrKey,
        title: false,
        shape: ShapeLightFocus.RRect));
    targets.add(TutorialTarget(
        identify: 'receiveAmountKey',
        keyTarget: receiveAmountKey,
        align: ContentAlign.top));
    targets.add(TutorialTarget(
        identify: 'receiveSumKey',
        keyTarget: receiveSumKey,
        align: ContentAlign.left));
    return targets;
  }
}
