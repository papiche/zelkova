enum Currency { G1, DU, ZEN }

extension CurrencyExtension on Currency {
  String name() {
    switch (this) {
      case Currency.G1:
        return 'Ğ1';
      case Currency.DU:
        return 'DU';
      case Currency.ZEN:
        return 'Ẑ';
    }
  }

  String longName() {
    switch (this) {
      case Currency.G1:
        return 'Ğ1';
      case Currency.DU:
        return 'DU';
      case Currency.ZEN:
        return 'ẐEN';
    }
  }

  /// True if this currency displays like G1 (fixed decimals, not UD-relative)
  bool get isG1Like => this == Currency.G1 || this == Currency.ZEN;
}

final List<String> currencyNames =
    Currency.values.map((Currency c) => c.name()).toList();
