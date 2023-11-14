import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../data/models/app_cubit.dart';

abstract class Tutorial {
  Tutorial({
    required this.tutorialId,
    required this.context,
  }) {
    _tutorial = TutorialCoachMark(
      targets: createTargets(),
      // colorShadow: Colors.red,
      textSkip: tr('skip').toUpperCase(),
      // hideSkip: true,
      // paddingFocus: 10,
      // opacityShadow: 0.8,
      onFinish: () {
        context.read<AppCubit>().onFinishTutorial(tutorialId);
      },
      onClickTarget: (TargetFocus target) {},
      onClickTargetWithTapPosition:
          (TargetFocus target, TapDownDetails tapDetails) {},
      onClickOverlay: (TargetFocus target) {},
      onSkip: () {
        return context.read<AppCubit>().onFinishTutorial(tutorialId);
      },
    );
  }

  late TutorialCoachMark _tutorial;
  final BuildContext context;
  final String tutorialId;

  List<TargetFocus> createTargets();

  void showTutorial({bool showAlways = false}) {
    if (showAlways || !context.read<AppCubit>().wasTutorialShown(tutorialId)) {
      _tutorial.show(context: context);
    }
  }
}
