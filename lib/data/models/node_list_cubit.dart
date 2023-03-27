import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'node.dart';
import 'node_list_state.dart';
import 'node_type.dart';

class NodeListCubit extends HydratedCubit<NodeListState> {
  NodeListCubit() : super(NodeListState());

  void shuffle(NodeType type) {
    switch (type) {
      case NodeType.duniter:
        emit(state.copyWith(duniterNodes: shuffleFirstN(state.duniterNodes)));
        break;
      case NodeType.cesiumPlus:
        emit(state.copyWith(
            cesiumPlusNodes: shuffleFirstN(state.cesiumPlusNodes)));
        break;
      case NodeType.gva:
        emit(state.copyWith(gvaNodes: shuffleFirstN(state.gvaNodes)));
        break;
    }
  }

  // shuffle fist n nodes
  List<Node> shuffleFirstN(List<Node> list, [int n = 5]) {
    if (list.length <= n) {
      list.shuffle();
    } else {
      final List<Node> subList = list.sublist(0, n);
      subList.shuffle();
      for (int i = 0; i < n; i++) {
        list[i] = subList[i];
      }
    }
    return list;
  }

  void setDuniterNodes(List<Node> nodes) {
    emit(state.copyWith(duniterNodes: nodes));
  }

  void setCesiumPlusNodes(List<Node> nodes) {
    emit(state.copyWith(cesiumPlusNodes: nodes));
  }

  void setGvaNodes(List<Node> nodes) {
    emit(state.copyWith(gvaNodes: nodes));
  }

  List<Node> get duniterNodes => state.duniterNodes;

  List<Node> get cesiumPlusNodes => state.cesiumPlusNodes;

  List<Node> get gvaNodes => state.gvaNodes;

  @override
  NodeListState? fromJson(Map<String, dynamic> json) =>
      NodeListState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(NodeListState state) {
    return state.toJson();
  }
}
