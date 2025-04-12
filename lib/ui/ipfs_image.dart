import 'package:flutter/material.dart';

import '../data/models/node.dart';
import '../data/models/node_manager.dart';
import '../data/models/node_type.dart';
import 'basic_avatar.dart';
import 'logger.dart';

class IpfsImage extends StatefulWidget {
  const IpfsImage({
    super.key,
    required this.path,
  });

  final String path;

  @override
  State<IpfsImage> createState() => _IpfsImageState();
}

class _IpfsImageState extends State<IpfsImage> {
  late String _currentUrl;
  late List<Node> _ipfsNodes;
  int _currentNodeIndex = 0;

  @override
  void initState() {
    super.initState();
    _ipfsNodes = NodeManager().nodesWorkingList(NodeType.ipfsGateway);
    _updateUrl();
  }

  void _updateUrl() {
    if (_currentNodeIndex < _ipfsNodes.length) {
      final String baseUrl = _ipfsNodes[_currentNodeIndex].url;
      setState(() {
        _currentUrl = '$baseUrl/ipfs/${widget.path}';
      });
    } else {
      setState(() {
        _currentUrl = '';
      });
    }
  }

  void _switchToNextUrl() {
    if (_currentNodeIndex < _ipfsNodes.length) {
      NodeManager().increaseNodeErrors(
          NodeType.ipfsGateway, _ipfsNodes[_currentNodeIndex]);
      _currentNodeIndex++;
      _updateUrl();
    }
  }

  @override
  Widget build(BuildContext context) {
    loggerDev('Loading image from IPFS $_currentUrl');
    return _currentUrl.isNotEmpty
        ? Image.network(
            _currentUrl,
            fit: BoxFit.cover,
            errorBuilder:
                (BuildContext context, Object error, StackTrace? stackTrace) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _switchToNextUrl();
              });
              return const BasicAvatar();
            },
          )
        : const BasicAvatar();
  }
}
