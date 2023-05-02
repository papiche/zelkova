import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/bottom_nav_cubit.dart';
import '../tutorial_keys.dart';

class BottomNavBar extends StatefulWidget {
  /// It is okay not to use a const constructor here.
  /// Using const breaks updating of selected BottomNavigationBarItem.
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  /* late Tutorial sndTutorial;*
  late Tutorial trdTutorial;
  late Tutorial fifthTutorial; */

  @override
  void initState() {
    /* if (context.read<BottomNavCubit>().state == 1) {
      sndTutorial = SecondTutorial(context);
      Future<void>.delayed(Duration.zero, () => sndTutorial.showTutorial());
    }
    if (context.read<BottomNavCubit>().state == 2) {
      trdTutorial = ThirdTutorial(context);
      Future<void>.delayed(Duration.zero, () => trdTutorial.showTutorial());
    }
    if (context.read<BottomNavCubit>().state == 4) {
      fifthTutorial = FifthTutorial(context);
      Future<void>.delayed(Duration.zero, () => fifthTutorial.showTutorial());
    } */
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 1, right: 4, left: 4),
      elevation: 4,
      shadowColor: Theme.of(context).colorScheme.shadow,
      color: Theme.of(context).colorScheme.surfaceVariant,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: BlocBuilder<BottomNavCubit, int>(
          builder: (BuildContext context, int state) {
        return BottomNavigationBar(
          currentIndex: state,
          onTap: (int index) =>
              context.read<BottomNavCubit>().updateIndex(index),
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          backgroundColor: Colors.transparent,
          selectedItemColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor: Theme.of(context).textTheme.bodySmall!.color,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: const Icon(Icons.credit_card),
              label: tr('bottom_nav_first'),
            ),
            BottomNavigationBarItem(
              icon: Icon(key: receiveMainKey, Icons.payments),
              label: tr('bottom_nav_second'),
            ),
            BottomNavigationBarItem(
              icon: Icon(key: contactsMainKey, Icons.contacts),
              label: tr('bottom_nav_trd'),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.savings),
              label: tr('bottom_nav_frd'),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.info),
              label: tr('bottom_nav_fifth'),
            ),
          ],
        );
      }),
    );
  }
}
