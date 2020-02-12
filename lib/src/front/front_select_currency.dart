import 'package:eatsleeptravel/src/components/full_modal_ok.dart';
import 'package:eatsleeptravel/src/front/user_settings/set_home_currency.dart';
import 'package:eatsleeptravel/src/models/Currency.dart';
import 'package:eatsleeptravel/src/services/app_state.dart';
import 'package:eatsleeptravel/src/services/firestore_service.dart';
import 'package:eatsleeptravel/src/services/home_state.dart';
import 'package:eatsleeptravel/src/services/records.dart';
import 'package:eatsleeptravel/src/services/session_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FrontSelectCurrency extends StatefulWidget {
  const FrontSelectCurrency({Key key, this.currency}) : super(key: key);
  final Currency currency;

  @override
  _FrontSelectCurrencyState createState() => _FrontSelectCurrencyState();
}

class _FrontSelectCurrencyState extends State<FrontSelectCurrency> {
  FirestoreService firestore = FirestoreService();
  HomeState homeState;
  SessionData sessionData;
  Records records;
  AppState appState;
  String curId;

  @override
  void didChangeDependencies() {
    homeState = Provider.of<HomeState>(context);
    sessionData = Provider.of<SessionData>(context);
    records = Provider.of<Records>(context);
    appState = Provider.of<AppState>(context);
    super.didChangeDependencies();
  }

  onCurrencySelectTap() {
    _submitFunction() {
      var selectedId = homeState.currencyPickerValue;
      setState(() => curId = selectedId);
      Currency selectedCurrency = records.getCurrency(selectedId);
      firestore.setUserDisplayCurrency(
        currencyId: selectedId,
        screenName: 'home',
        userId: sessionData.user.id,
      );
      Navigator.pop(context);
    }

    Navigator.of(context).push(
      FullModalOk(
        header: SetDisplayCurrencyHeader(),
        body: SelectCurrency(initialCurrencyId: curId),
        buttonColor: appState.cols.content,
        onOkTap: _submitFunction,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '${widget.currency.namePlural} (${widget.currency.code})',
              style: TextStyle(
                color: appState.cols.content,
                fontSize: 16,
                letterSpacing: 1.2,
              ),
            ),
            SizedBox(width: 3),
            Icon(
              Icons.keyboard_arrow_down,
              color: appState.cols.content,
            ),
          ],
        ),
      ),
      onTap: onCurrencySelectTap,
    );
  }
}
