import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'node.dart';
import 'node_list_state.dart';

class NodeListCubit extends HydratedCubit<NodeListState> {
  NodeListCubit() : super(NodeListState());

  void addDuniterNode(Node node) {
    final Node? nFound = _find(node);
    if (nFound == null) {
      // Does not exists, so add it
      emit(state.copyWith(duniterNodes: <Node>[...state.duniterNodes, node]));
    } else {
      // it exists
      updateDuniterNode(node);
    }
  }

  Node? _find(Node node) =>
      state.duniterNodes.firstWhere((Node n) => n.url == node.url);

  void insertDuniterNode(Node node) {
    final Node? nFound = _find(node);
    if (nFound == null) {
      emit(state.copyWith(duniterNodes: <Node>[node, ...state.duniterNodes]));
    } else {
      // it exists
      updateDuniterNode(node);
    }
  }

  void updateDuniterNode(Node updatedNode) {
    final List<Node> updatedDuniterNodes = state.duniterNodes.map((Node n) {
      return n.url == updatedNode.url ? updatedNode : n;
    }).toList();
    emit(state.copyWith(duniterNodes: updatedDuniterNodes));
  }

  void setDuniterNodes(List<Node> nodes) {
    emit(state.copyWith(
        duniterNodes: nodes, lastFetchNodesTime: DateTime.now()));
  }

  void cleanDuniterErrorStats() {
    emit(state.copyWith(
        duniterNodes: duniterNodes
            .map((Node node) => node.copyWith(errors: 0))
            .toList()));
  }

  void addCesiumPlusNode(Node node) {
    emit(state
        .copyWith(cesiumPlusNodes: <Node>[...state.cesiumPlusNodes, node]));
  }

  List<Node> get duniterNodes => state.duniterNodes;

  List<Node> get cesiumPlusNodes => state.cesiumPlusNodes;

  DateTime get lastFetchNodesTime => state.lastFetchNodesTime;

  @override
  NodeListState? fromJson(Map<String, dynamic> json) =>
      NodeListState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(NodeListState state) {
    return state.toJson();
  }
}
