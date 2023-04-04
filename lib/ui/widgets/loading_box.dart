import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
        width: 100.0,
        height: 100.0,
        child: Center(
          child: CircularProgressIndicator(),
        ));
  }
}

class LoadingBox extends StatelessWidget {
  const LoadingBox({super.key, required this.simple});

  final bool simple;

  @override
  Widget build(BuildContext context) {
    return simple
        ? const LoadingWidget()
        : const Expanded(
            child: LoadingWidget(),
          );
  }
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
