import 'package:flutter/foundation.dart';

bool get onlyInDevelopment => !inProduction;

bool get inDevelopment => !inProduction;

bool get onlyInProduction => kReleaseMode;

bool get inProduction => onlyInProduction;
