import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'node.dart';
import 'node_list_state.dart';

class NodeListCubit extends HydratedCubit<NodeListState> {
  NodeListCubit() : super(NodeListState());

  @override
  String get storagePrefix => 'NodeListCubit';

  bool get isLoading => state.isLoading;

  Node? get currentGvaNode => state.currentGvaNode;

  void setCurrentGvaNode(Node node) {
    emit(state.copyWith(currentGvaNode: node));
  }

  void setLoading(bool isLoading) {
    emit(state.copyWith(isLoading: isLoading));
  }

  void setDuniterNodes(List<Node> nodes) {
    emit(state.copyWith(duniterNodes: nodes));
  }

  void setDuniterIndexerNodes(List<Node> nodes) {
    emit(state.copyWith(duniterIndexerNodes: nodes));
  }

  void setCesiumPlusNodes(List<Node> nodes) {
    emit(state.copyWith(cesiumPlusNodes: nodes));
  }

  void setGvaNodes(List<Node> nodes) {
    emit(state.copyWith(gvaNodes: nodes));
  }

  void setEndpointNodes(List<Node> nodes) {
    emit(state.copyWith(endpointNodes: nodes));
  }

  List<Node> get duniterNodes => state.duniterNodes;

  List<Node> get cesiumPlusNodes => state.cesiumPlusNodes;

  List<Node> get gvaNodes => state.gvaNodes;

  List<Node> get endpointNodes => state.endpointNodes;

  List<Node> get duniterIndexerNodes => state.duniterIndexerNodes;

  @override
  NodeListState? fromJson(Map<String, dynamic> json) =>
      NodeListState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(NodeListState state) {
    return state.toJson();
  }

  void resetCurrentGvaNode() {
    emit(NodeListState(
        gvaNodes: state.gvaNodes,
        duniterNodes: state.duniterNodes,
        cesiumPlusNodes: state.cesiumPlusNodes,
        endpointNodes: state.endpointNodes,
        duniterIndexerNodes: state.duniterIndexerNodes,
        isLoading: state.isLoading));
  }
}
