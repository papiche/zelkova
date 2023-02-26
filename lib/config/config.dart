import 'package:flutter_dotenv/flutter_dotenv.dart';

String get duniterNet {
  return dotenv.get('NET');
}
