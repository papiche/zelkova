enum Currency { G1, DU }

extension CurrencyExtension on Currency {
  String name() {
    switch (this) {
      case Currency.G1:
        return 'Ğ1';
      case Currency.DU:
        return 'DU';
    }
  }
}

final List<String> currencyNames =
    Currency.values.map((Currency c) => c.name()).toList();
