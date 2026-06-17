import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/app_cubit.dart';
import '../../data/models/bottom_nav_cubit.dart';
import '../../shared_prefs_helper_v2.dart';
import '../widgets/app_bar_gone.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/multipass_onboarding_dialog.dart';
import 'fifth_screen.dart';
import 'first_screen.dart';
import 'fourth_screen.dart';
import 'messages_screen.dart';
import 'second_screen.dart';
import 'third_screen.dart';

class SkeletonScreen extends StatefulWidget {
  const SkeletonScreen({super.key});

  @override
  State<SkeletonScreen> createState() => _SkeletonScreenState();
}

class _SkeletonScreenState extends State<SkeletonScreen> {
  bool _multipassChecked = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_multipassChecked) {
      _multipassChecked = true;
      _promptMultipassIfNeeded();
    }
  }

  Future<void> _promptMultipassIfNeeded() async {
    final AppCubit cubit = context.read<AppCubit>();
    // Only prompt once (persisted via tutorials map)
    if (cubit.wasTutorialShown('multipass_prompt')) {
      return;
    }

    final String? nsec = await SharedPreferencesHelperV2().getNostrNsec();
    if (nsec != null) {
      // Already has a MULTIPASS
      cubit.multipassPrompted();
      return;
    }

    // Show MULTIPASS dialog after a short delay
    if (!mounted) {
      return;
    }
    await Future<void>.delayed(const Duration(milliseconds: 600));
    if (!mounted) {
      return;
    }
    cubit.multipassPrompted();
    showMultipassOnboardingDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    const List<Widget> pageNavigation = <Widget>[
      FirstScreen(),
      SecondScreen(),
      ThirdScreen(),
      MessagesScreen(),
      FourthScreen(),
      FifthScreen(),
    ];

    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      appBar: const AppBarGone(),

      /// When switching between tabs this will fade the old
      /// layout out and the new layout in.
      body: BlocBuilder<BottomNavCubit, int>(
        builder: (BuildContext context, int state) {
          return AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: pageNavigation.elementAt(state));
        },
      ),

      bottomNavigationBar: const BottomNavBar(),
      backgroundColor: Theme.of(context).colorScheme.surface,
    );
  }
}
