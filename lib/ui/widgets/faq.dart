import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class FAQ extends StatefulWidget {
  const FAQ({super.key});

  @override
  State<FAQ> createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
  int? _currentIndex;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 5,
      itemBuilder: (BuildContext context, int index) {
        final String question = tr('faq_${index}_title');
        final String answer = tr('faq_${index}_desc');
        return ExpansionTile(
            key: Key('builder $_currentIndex'),
            title: Text(question),
            initiallyExpanded: _currentIndex == index,
            onExpansionChanged: (bool newState) {
              if (newState)
                setState(() {
                  _currentIndex = index;
                });
              else
                setState(() {
                  _currentIndex = -1;
                });
            },
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(answer),
              ),
            ]);
      },
    );
  }
}
