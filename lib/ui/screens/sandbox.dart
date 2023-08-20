import 'package:flutter_neumorphic/flutter_neumorphic.dart';

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
      body: TextButton(onPressed: () {}, child: const Text('Auth')),
    );
  }
}
