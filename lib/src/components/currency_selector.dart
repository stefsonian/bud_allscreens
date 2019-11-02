import 'dart:convert';

import 'package:allscreens/src/components/loading_spinner.dart';
import 'package:flutter/material.dart';

class CurrencySelector extends StatefulWidget {
  @override
  _CurrencySelectorState createState() => _CurrencySelectorState();
}

class _CurrencySelectorState extends State<CurrencySelector> {
  Future<List<Currency>> loadCurrencies() async {
    // Load currencies from json file, convert to list, sort alphabetically, as Currency
    String data = await DefaultAssetBundle.of(context)
        .loadString("assets/currencies.json");
    List<Currency> cur = [];
    Map currencyMap = json.decode(data);
    currencyMap.forEach((k, v) => cur.add(Currency.fromMap({k: v})));
    cur.sort((Currency a, Currency b) => a.id.compareTo(b.id));
    return cur;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      height: 500,
      width: 300,
      color: Colors.white,
      child: FutureBuilder(
        future: loadCurrencies(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Currency>> snapshot) {
          if (!snapshot.hasData) return LoadingSpinner();
          return ListView.separated(
            shrinkWrap: true,
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              var isSelected = index == 4;
              Currency currency = snapshot.data[index];
              return Container(
                // height: 16,
                child: _currencyTile(currency, isSelected),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider();
            },
          );
        },
      ),
    );
  }

  Widget _currencyTile(Currency cur, bool isSelected) {
    return Container(
      padding: EdgeInsets.fromLTRB(8, 4, 0, 4),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  cur.name,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'USD \$1 = ${cur.code} ${cur.symbolNative} 1.34',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 38,
            margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: Row(
              children: <Widget>[
                FloatingActionButton(
                  child: Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                  backgroundColor: Colors.blueGrey,
                  onPressed: () {},
                ),
                SizedBox(width: 5),
                FloatingActionButton(
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                  backgroundColor: isSelected ? Colors.green : Colors.grey,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Currency {
  var id, symbol, name, symbolNative, code, namePlural = '';
  var decimals = 2;
  var rounding = 0.0;

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
  }
}
