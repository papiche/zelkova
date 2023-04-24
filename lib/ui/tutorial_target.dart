import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class TutorialTarget extends TargetFocus {
  TutorialTarget(
      {required String super.identify,
      super.color = Colors.black,
      required GlobalKey super.keyTarget,
      super.shape = ShapeLightFocus.Circle,
      super.enableOverlayTab = true,
      super.enableTargetTab = true,
      bool? title = true,
      ContentAlign align = ContentAlign.bottom,
      Widget? extraWidget})
      : super(contents: <TargetContent>[
          TargetContent(
              align: align,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  if (title!)
                    Text(
                      tr('${identify}_title'),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20.0),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      tr('${identify}_desc'),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  if (extraWidget != null)
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                        child: extraWidget)
                ],
              ))
        ]);
}
