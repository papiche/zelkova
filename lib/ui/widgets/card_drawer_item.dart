import 'package:flutter/material.dart';

import '../../data/models/cesium_card.dart';

class CardDrawerItem extends StatelessWidget {
  const CardDrawerItem({super.key, required this.cesiumCard});

  final CesiumCard cesiumCard;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        title: Text(cesiumCard.name),
        // subtitle: Text(cesiumCard.title),
      ),
    );
  }
}
