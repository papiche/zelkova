import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/node_list_cubit.dart';
import '../../../data/models/node_list_state.dart';
import '../../screens/node_list_page.dart';
import '../fifth_screen/info_card.dart';

class NodeListCard extends StatelessWidget {
  const NodeListCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NodeListCubit, NodeListState>(
        builder: (BuildContext nodeContext, NodeListState state) {
      return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute<VoidCallback>(
                  builder: (BuildContext context) => NodeListPage()),
            );
          },
          child: InfoCard(
              title: tr('nodes_tech_info'), translate: false, icon: Icons.hub));
    });
  }
}
