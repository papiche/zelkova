import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'node.dart';
import 'node_list_state.dart';

class NodeListCubit extends HydratedCubit<NodeListState> {
  NodeListCubit() : super(NodeListState());

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
