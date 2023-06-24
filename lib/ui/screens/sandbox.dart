import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../../shared_prefs.dart';
import '../widgets/first_screen/card_name_editable.dart';

class Sandbox extends StatefulWidget {
  const Sandbox({super.key});

  @override
  State<Sandbox> createState() => _SandboxState();
}

class _SandboxState extends State<Sandbox> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Sandbox'),
        ),
        body: const CardNameEditable());
  }
}
