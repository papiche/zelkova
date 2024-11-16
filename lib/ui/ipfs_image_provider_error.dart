import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../data/models/node.dart';
import '../data/models/node_manager.dart';
import '../data/models/node_type.dart';
import 'basic_avatar.dart';

class IpfsImageProvider extends ImageProvider<IpfsImageProvider> {
  IpfsImageProvider(this.path);
  final String path;

  @override
  Future<IpfsImageProvider> obtainKey(ImageConfiguration configuration) {
    return SynchronousFuture<IpfsImageProvider>(this);
  }

  @override
  ImageStreamCompleter loadImage(
      IpfsImageProvider key, ImageDecoderCallback decode) {
    return MultiFrameImageStreamCompleter(
      codec: _loadImageFromIpfs(),
      scale: 1.0,
    );
  }

  Future<ui.Codec> _loadImageFromIpfs() async {
    final List<Node> ipfsNodes =
        NodeManager().nodesWorkingList(NodeType.ipfsGateway);
    int nodeIndex = 0;

    while (nodeIndex < ipfsNodes.length) {
      final String url = '${ipfsNodes[nodeIndex].url}/ipfs/$path';
      try {
        final http.Response response = await http.get(Uri.parse(url));
        if (response.statusCode == 200) {
          final Uint8List imageData = response.bodyBytes;
          return await ui.instantiateImageCodec(imageData);
        } else {
          NodeManager()
              .increaseNodeErrors(NodeType.ipfsGateway, ipfsNodes[nodeIndex]);
          nodeIndex++;
        }
      } catch (e) {
        NodeManager()
            .increaseNodeErrors(NodeType.ipfsGateway, ipfsNodes[nodeIndex]);
        nodeIndex++;
      }
    }

    throw StateError('No IPFS nodes available to load the image.');
  }
}

class IpfsImageWidget extends StatelessWidget {
  const IpfsImageWidget({
    super.key,
    required this.path,
    required this.width,
    required this.height,
  });
  final String path;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ui.Codec>(
      future: IpfsImageProvider(path)._loadImageFromIpfs(),
      builder: (BuildContext context, AsyncSnapshot<ui.Codec> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return Image(
            image: IpfsImageProvider(path),
            width: width,
            height: height,
            fit: BoxFit.cover,
          );
        } else if (snapshot.hasError) {
          return const BasicAvatar();
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
