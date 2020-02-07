class Currency {
  String id, symbol, name, symbolNative, code, namePlural = '';
  int decimals = 2;
  double rounding = 0.0;

  Currency();

  Currency.fromMap(Map<String, Map<String, dynamic>> cur) {
    id = cur.keys.toList().first;
    code = cur[id]['code'] ?? '';
    symbol = cur[id]['symbol'] ?? '';
    name = cur[id]['name'] ?? '';
    symbolNative = cur[id]['symbol_native'] ?? '';
    namePlural = cur[id]['name_plural'] ?? '';
    decimals = cur[id]['decimal_digits'] ?? 2;
    rounding = double.tryParse(cur[id]['rounding'].toString()) ?? 0.0;
    id = id.toLowerCase();
  }
}
