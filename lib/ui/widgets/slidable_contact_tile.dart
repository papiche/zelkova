import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../data/models/app_cubit.dart';
import '../../data/models/contact.dart';
import '../contact_list_item.dart';

class SlidableContactTile extends StatefulWidget {
  const SlidableContactTile(this.contact,
      {super.key,
      required this.index,
      required this.context,
      this.onTap,
      this.onLongPress,
      this.trailing});

  @override
  State<SlidableContactTile> createState() => _SlidableContactTile();

  final Contact contact;
  final int index;
  final BuildContext context;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final Widget? trailing;
}

class _SlidableContactTile extends State<SlidableContactTile> {
  late bool isV2;

  @override
  void initState() {
    super.initState();
    isV2 = context.read<AppCubit>().isV2;
    // Disable for now
    //   _start();
  }

  // Based in https://github.com/letsar/flutter_slidable/issues/288
  // ignore: unused_element
  Future<void> _start() async {
    if (widget.index == 0 &&
        !context.read<AppCubit>().wasTutorialShown(tutorialId)) {
      await Future<void>.delayed(const Duration(seconds: 1));
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(tr('slidable_tutorial')),
          action: SnackBarAction(
            label: 'OK',
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              context.read<AppCubit>().onFinishTutorial(tutorialId);
              // context.read<AppCubit>().warningViewed();
            },
          ),
        ),
      );
      final SlidableController? slidable = Slidable.of(context);

      slidable?.openEndActionPane(
        duration: const Duration(milliseconds: 300),
        curve: Curves.decelerate,
      );

      Future<void>.delayed(const Duration(seconds: 1), () {
        slidable?.close(
          duration: const Duration(milliseconds: 300),
          curve: Curves.bounceInOut,
        );
      });
    }
  }

  static String tutorialId = 'slidable_tutorial';

  @override
  Widget build(_) => ContactListItem(
      contact: widget.contact,
      index: widget.index,
      onTap: widget.onTap,
      onLongPress: widget.onLongPress,
      trailing: widget.trailing,
      isV2: isV2);
}
