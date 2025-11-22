import 'package:flutter/foundation.dart';

import '../generated/gtest/pallets/certification.dart' as cert;

bool get onlyInDevelopment => !inProduction;

bool get inDevelopment => !inProduction;

bool get onlyInProduction => kReleaseMode;

bool get inProduction => onlyInProduction;

// Flag to test maxByIssuer limit with a lower value during development
// Set this to true to test the "reached maxByIssuer limit" behavior
const bool testMaxByIssuerLimit = false;

// Test value for maxByIssuer (used only when testMaxByIssuerLimit is true)
const int testMaxByIssuerValue = 2;

/// Get the maxByIssuer limit, optionally using a test value in development
int getMaxByIssuer() {
  if (inDevelopment && testMaxByIssuerLimit) {
    return testMaxByIssuerValue;
  }
  return cert.Constants().maxByIssuer;
}
