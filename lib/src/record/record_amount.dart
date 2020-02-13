import 'dart:math';

import 'package:eatsleeptravel/src/components/divider_grid.dart';
import 'package:eatsleeptravel/src/components/full_modal_ok.dart';
import 'package:eatsleeptravel/src/components/option_button.dart';
import 'package:eatsleeptravel/src/front/user_settings/set_home_currency.dart';
import 'package:eatsleeptravel/src/helpers/utils.dart';
import 'package:eatsleeptravel/src/models/Currency.dart';
import 'package:eatsleeptravel/src/models/Numpad_input.dart';
import 'package:eatsleeptravel/src/models/Payment_type.dart';
import 'package:eatsleeptravel/src/record/numpad.dart';
import 'package:eatsleeptravel/src/services/app_state.dart';
import 'package:eatsleeptravel/src/services/record_state.dart';
import 'package:eatsleeptravel/src/services/records.dart';
import 'package:eatsleeptravel/src/services/session_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecordAmount extends StatefulWidget {
  @override
  _RecordAmountState createState() => _RecordAmountState();
}

class _RecordAmountState extends State<RecordAmount> {
  AppState appState;
  RecordState recordState;
  Records records;
  SessionData sessionData;
  NumpadInput numpad = NumpadInput();
  String amount = '0.00';
  PaymentType paymentType;
  Currency currency;
  bool allowDecimals = true;

  @override
  void didChangeDependencies() {
    appState = Provider.of<AppState>(context);
    recordState = Provider.of<RecordState>(context);
    records = Provider.of<Records>(context);
    sessionData = Provider.of<SessionData>(context);
    _initialiseVariables();
    super.didChangeDependencies();
  }

  onNumberTap(String value) {
    numpad.updateValue(value);
    setState(() => amount = numpad.displayValue());
    recordState.updateNewExpense('amount', numpad.valueDouble);
    recordState.updateNewExpense('currencyId', 'AUD');
  }

  _initialiseVariables() {
    if (paymentType == null) {
      final latestUsed = records.latestPaymentType.toLowerCase();
      paymentType = sessionData.paymentTypes[latestUsed];
      // recordState.updateNewExpense('paymentType', paymentType.id);
    }
    if (currency == null) {
      currency = records.getCurrency(records.latestCurrencyId);
      recordState.newExpense.update('currency', currency);
      _setAllowDecimals();
    }
  }

  onPaymentTypeTap() {
    // cycle state of paymentType to the next payment type
    final types = sessionData.paymentTypes.keys.toList();
    final currentIndex = types.indexOf(paymentType.id);
    final nextTypeId = currentIndex == types.length - 1 ? 0 : currentIndex + 1;
    setState(() => paymentType = sessionData.paymentTypes[types[nextTypeId]]);
    recordState.updateNewExpense('paymentType', paymentType.id);
  }

  _setAllowDecimals() {
    var usdRate = Utils().convertAmount(
      amount: 1.0,
      fromCurrency: 'usd',
      toCurrency: currency.id,
      xRates: records.latestXrates(),
    );
    if (usdRate > 100) allowDecimals = false;
  }

  onCurrencyTap() {
    _submitFunction() {
      var selectedId = recordState.currencyPickerValue;
      Currency selectedCurrency = records.getCurrency(selectedId);
      setState(() => currency = selectedCurrency);
      recordState.newExpense.update('currency', selectedCurrency);
      _setAllowDecimals();
      Navigator.pop(context);
    }

    Navigator.of(context).push(
      FullModalOk(
        header: SetRecordCurrencyHeader(),
        body: SelectCurrency(
          initialCurrencyId: currency.id,
          stateToUpdate: 'record',
        ),
        buttonColor: appState.cols.content,
        onOkTap: _submitFunction,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Sizing
    final h = appState.viewHeight;
    final w = appState.viewWidth;
    double amountBoxHeight = 80.0;
    double boxSpace = 10.0;
    double amountMargin = 20.0;
    bool isShort = false;
    bool isNarrow = false;

    if (h < 735) {
      amountBoxHeight = 58.0;
      isShort = true;
    }

    if (w < 373) {
      boxSpace = 7.0;
      isNarrow = true;
    }

    if (w < 400) amountMargin = 6.0;
    // ------

    final BoxDecoration optionDecor = BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      // color: appState.cols.action,
      // boxShadow: kElevationToShadow[4],
      border: Border.all(
        width: 2,
        color: appState.cols.content.withOpacity(0.3),
      ),
    );
    // final circleDiameter = max((screenHeight - 270))
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.symmetric(horizontal: amountMargin),
            child: Row(
              children: <Widget>[
                Container(
                  height: amountBoxHeight,
                  width: amountBoxHeight,
                  decoration: optionDecor,
                  padding: EdgeInsets.all(2),
                  child: DisplayPart(
                    appState: appState,
                    onTap: onPaymentTypeTap,
                    icon: paymentType.icon,
                    label: paymentType.name,
                    isSmall: isShort,
                  ),
                ),
                SizedBox(width: boxSpace),
                Container(
                  height: amountBoxHeight,
                  width: amountBoxHeight,
                  decoration: optionDecor,
                  padding: EdgeInsets.all(2),
                  child: DisplayPart(
                    appState: appState,
                    onTap: onCurrencyTap,
                    iconReplacement: currency.symbolNative,
                    label: currency.code,
                    isSmall: isShort,
                  ),
                ),
                SizedBox(width: boxSpace),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(right: 12),
                    height: amountBoxHeight,
                    decoration: optionDecor,
                    alignment: Alignment.centerRight,
                    child: Text(
                      amount,
                      style: TextStyle(
                        color: appState.cols.content,
                        fontSize: isNarrow ? 24 : 30,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: isShort
                ? EdgeInsets.fromLTRB(10, 14, 10, 10)
                : EdgeInsets.fromLTRB(20, 40, 20, 20),
            height: isShort ? 180 : 220,
            child: Stack(
              children: <Widget>[
                Numpad(onTap: onNumberTap, hasDecimalPoint: allowDecimals),
                DividerGrid(
                  horizontalDividers: 3,
                  verticalDividers: 2,
                  color1: appState.cols.content.withOpacity(0.3),
                  color2: appState.cols.content.withOpacity(0.25),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DisplayPart extends StatelessWidget {
  const DisplayPart(
      {Key key,
      @required this.appState,
      this.onTap,
      this.icon,
      this.label,
      this.isSmall,
      this.iconReplacement})
      : super(key: key);

  final AppState appState;
  final Function onTap;
  final IconData icon;
  final String label;
  final bool isSmall;
  final String iconReplacement;

  @override
  Widget build(BuildContext context) {
    Widget textWidget = Container();
    if (iconReplacement != null) {
      textWidget = Container(
        alignment: Alignment.center,
        height: 28,
        width: 28,
        // padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(360),
            color: appState.cols.content),
        child: Center(
          child: Text(
            iconReplacement,
            style: TextStyle(
              color: appState.cols.background2,
              fontSize: 16,
            ),
          ),
        ),
      );
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            icon == null
                ? textWidget
                : Container(
                    height: 28,
                    width: 28,
                    child: FittedBox(
                      child: Icon(
                        icon,
                        color: appState.cols.content,
                        size: 24,
                      ),
                    ),
                  ),
            Text(
              label,
              style: TextStyle(
                color: appState.cols.content,
                fontSize: isSmall ? 12 : 17,
              ),
            )
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}
