import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../widgets/fifth_screen/import_dialog.dart';

class Sandbox extends StatefulWidget {
  const Sandbox({super.key});

  @override
  State<Sandbox> createState() => _SandboxState();
}

class _SandboxState extends State<Sandbox> {
  final double expandedHeight = 500;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TextButton(
          onPressed: () {
            showImportCesiumWalletDialog(
                context, '6DrGg8cftpkgffv4Y4Lse9HSjgc8coEQor3yvMPHAnVH:HCT');
          },
          child: const Text('Auth')),
    );
  }
}
