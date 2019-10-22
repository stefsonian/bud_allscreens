import 'dart:convert';

import 'package:flutter/material.dart';

const currenciesStart = [
  {
    "USD": {
      "symbol": "\$",
      "name": "US Dollar",
      "symbol_native": "\$",
      "decimal_digits": 2,
      "rounding": 0,
      "code": "USD",
      "name_plural": "US dollars"
    }
  }
];

class CurrencySelector extends StatefulWidget {
  @override
  _CurrencySelectorState createState() => _CurrencySelectorState();
}

class _CurrencySelectorState extends State<CurrencySelector> {
  Future<List<Map>> currencies;

  @override
  void didChangeDependencies() {
    // loadCurrencies();
    super.didChangeDependencies();
  }

  Future<List<Map>> loadCurrencies() async {
    String data = await DefaultAssetBundle.of(context)
        .loadString("assets/currencies.json");
    Map currencyMap = json.decode(data);
    List<Map> cur = [];
    currencyMap.forEach((k, v) => cur.add({k: v}));

    print(cur);
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
        initialData: currenciesStart,
        builder: (BuildContext context, AsyncSnapshot<List<Map>> snapshot) {
          return ListView.separated(
            shrinkWrap: true,
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 100,
                child: Text(snapshot.data[index].toString()),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider();
            },
          );
        },
      ),

      // child: ListView.separated(
      //   shrinkWrap: true,
      //   itemCount: currencies.length,
      //   itemBuilder: (BuildContext context, int index) {
      //     return Container(
      //       height: 150,
      //       child: Text(currencies[index]),
      //     );
      //   },
      //   separatorBuilder: (BuildContext context, int index) {
      //     return Divider();
      //   },
      // ),
    );
  }
}
