import 'package:eatsleeptravel/src/models/Currency.dart';
import 'package:eatsleeptravel/src/services/app_state.dart';
import 'package:eatsleeptravel/src/services/firestore_service.dart';
import 'package:eatsleeptravel/src/services/records.dart';
import 'package:eatsleeptravel/src/services/session_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SetHomeCurrency extends StatefulWidget {
  @override
  _SetHomeCurrencyState createState() => _SetHomeCurrencyState();
}

class _SetHomeCurrencyState extends State<SetHomeCurrency> {
  SessionData sessionData;
  AppState appState;
  Records records;
  List<Currency> currencies;
  int selectedIndex = -1;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    appState = Provider.of<AppState>(context);
    sessionData = Provider.of<SessionData>(context);
    records = Provider.of<Records>(context);
    currencies = records.currencies;
    currencies.sort((a, b) => a.id.compareTo(b.id));
    if (selectedIndex == -1 && sessionData.user.homeCurrency.isNotEmpty) {
      selectedIndex = currencies
          .indexWhere((cur) => cur.id == sessionData.user.homeCurrency);
    }
  }

  _updateSelectedIndex(int index) {
    setState(() => selectedIndex = index);
  }

  onSubmitTap() async {
    if (selectedIndex < 0) return;

    var firestore = FirestoreService();
    await firestore.setUserHomeCurrency(
      userId: sessionData.user.id,
      currencyId: records.currencies[selectedIndex].id,
    );

    firestore.resetUserCurrencyValues(
      userId: sessionData.user.id,
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      color: appState.cols.content,
      width: 500,
      child: Column(
        children: <Widget>[
          Text(
            'Set your home currency',
            style: TextStyle(
                fontSize: 20,
                letterSpacing: 1.2,
                color: appState.cols.background2),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12),
          Text(
            'your travel budget\nis in this currency',
            style: TextStyle(
                fontSize: 14,
                letterSpacing: 1.2,
                color: appState.cols.background2),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 40),
          SizedBox(
            height: 300,
            child: ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                Color color = index == selectedIndex
                    ? Colors.green.withOpacity(0.6)
                    : Colors.transparent;
                return _buildCurrencyItem(
                  currency: currencies[index],
                  color: color,
                  onTap: () => _updateSelectedIndex(index),
                );
              },
              separatorBuilder: (BuildContext context, int index) => Divider(),
              itemCount: records.currencies.length,
            ),
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(360),
                ),
                materialTapTargetSize: MaterialTapTargetSize.padded,
                animationDuration: Duration(milliseconds: 300),
                elevation: 1,
                color: appState.cols.background2,
                child: Icon(
                  Icons.close,
                  color: appState.cols.content,
                  size: 28,
                ),
                onPressed: () => Navigator.pop(context),
              ),
              RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(360),
                  ),
                  materialTapTargetSize: MaterialTapTargetSize.padded,
                  animationDuration: Duration(milliseconds: 300),
                  elevation: 1,
                  color: appState.cols.background2,
                  child: Icon(
                    Icons.check,
                    color: appState.cols.content,
                    size: 34,
                  ),
                  onPressed: onSubmitTap),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCurrencyItem({Currency currency, Color color, Function onTap}) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: color,
        ),
        padding: EdgeInsets.symmetric(horizontal: 12),
        height: 42,
        child: Row(
          children: <Widget>[
            SizedBox(width: 50, child: Text(currency.id.toUpperCase())),
            Expanded(
              child: Text(
                currency.name,
                overflow: TextOverflow.clip,
              ),
            ),
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}
