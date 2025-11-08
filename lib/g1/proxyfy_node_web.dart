import 'package:web/web.dart' as web;

import '../ui/in_dev_helper.dart';

String proxyfyNode(String nodeUrl) {
  final String url = inProduction
      ? '${web.window.location.protocol}//${web.window.location.hostname}/proxy/${nodeUrl.replaceFirst('https://', '').replaceFirst('http://', '')}/'
      : nodeUrl;
  return url;
}
