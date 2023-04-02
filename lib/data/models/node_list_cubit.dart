import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'node.dart';
import 'node_list_state.dart';
import 'node_type.dart';

class NodeListCubit extends HydratedCubit<NodeListState> {
  NodeListCubit() : super(NodeListState());

  void shuffle(NodeType type, bool withPenalty) {
    switch (type) {
      case NodeType.duniter:
        if (withPenalty) {
          emit(state.copyWith(
              duniterNodes: shuffleFirstNWithPenalty(state.duniterNodes)));
        } else {
          emit(state.copyWith(duniterNodes: shuffleFirstN(state.duniterNodes)));
        }
        break;
      case NodeType.cesiumPlus:
        if (withPenalty) {
          emit(state.copyWith(
              cesiumPlusNodes: shuffleFirstNWithPenalty(
                  state.cesiumPlusNodes)));
        } else {
          emit(state.copyWith(
              cesiumPlusNodes: shuffleFirstN(state.cesiumPlusNodes)));
        }
        break;
      case NodeType.gva:
        if (withPenalty) {
          emit(state.copyWith(
              gvaNodes: shuffleFirstNWithPenalty(state.gvaNodes)));
        } else {
          emit(state.copyWith(gvaNodes: shuffleFirstN(state.gvaNodes)));
        }
        break;
    }
  }

  // shuffle first n nodes, keeping the first node last
  List<Node> shuffleFirstNWithPenalty(List<Node> list, [int n = 5]) {
    if (list.length <= n) {
      final Node firstElement = list.removeAt(0);
      list.shuffle();
      list.add(firstElement);
    } else {
      final List<Node> subList = list.sublist(0, n);
      final Node firstElement = subList.removeAt(0);
      subList.shuffle();
      subList.add(firstElement);
      for (int i = 0; i < n; i++) {
        list[i] = subList[i];
      }
    }
    return list;
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
