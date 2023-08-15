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
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: expandedHeight,
            pinned: true,
            flexibleSpace: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              // Calcula la proporción de la altura actual respecto a la altura expandida
              final double percent =
                  (expandedHeight - constraints.maxHeight) / expandedHeight;

              return Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  // CreditCard(),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: ClipRect(
                      child: AnimatedOpacity(
                        opacity: 1 - percent,
                        duration: const Duration(milliseconds: 200),
                        child: const Text('Test'), // CreditCard(),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    left: 36,
                    child: ClipRect(
                      child: AnimatedOpacity(
                        opacity: percent,
                        duration: const Duration(milliseconds: 200),
                        child: Text(
                          'Mi AppBar',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) => ListTile(
                title: Text('Item $index'),
              ),
              childCount: 50,
            ),
          ),
        ],
      ),
    );
  }
}
