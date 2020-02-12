import 'package:eatsleeptravel/src/components/dialog_header.dart';
import 'package:eatsleeptravel/src/models/Currency.dart';
import 'package:eatsleeptravel/src/services/app_state.dart';
import 'package:eatsleeptravel/src/services/firestore_service.dart';
import 'package:eatsleeptravel/src/services/home_state.dart';
import 'package:eatsleeptravel/src/services/records.dart';
import 'package:eatsleeptravel/src/services/session_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SetHomeCurrencyHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: appState.cols.content.withOpacity(0.4),
          ),
        ),
      ),
      height: 120,
      child: DialogHeader(
        mainHeader: 'Set your home currency',
        subHeader: 'This is your currency of reference',
        color: appState.cols.content,
      ),
    );
  }
}

class SetBudgetCurrencyHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: appState.cols.content.withOpacity(0.4),
          ),
        ),
      ),
      height: 120,
      child: DialogHeader(
        mainHeader: 'Set your budget currency',
        subHeader:
            'For most, the best choice is\nthe currency of their home country',
        color: appState.cols.content,
      ),
    );
  }
}

class SetDisplayCurrencyHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: appState.cols.content.withOpacity(0.4),
          ),
        ),
      ),
      height: 120,
      child: DialogHeader(
        mainHeader: 'Set display currency',
        subHeader: 'Amounts are displayed in this currency',
        color: appState.cols.content,
      ),
    );
  }
}

class SelectCurrency extends StatefulWidget {
  const SelectCurrency({Key key, this.initialCurrencyId}) : super(key: key);
  final String initialCurrencyId;

  @override
  _SelectCurrencyState createState() => _SelectCurrencyState();
}

class _SelectCurrencyState extends State<SelectCurrency> {
  SessionData sessionData;
  AppState appState;
  Records records;
  HomeState homeState;
  // List<Currency> currencies = [];
  int selectedIndex = -1;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    appState = Provider.of<AppState>(context);
    sessionData = Provider.of<SessionData>(context);
    records = Provider.of<Records>(context);
    homeState = Provider.of<HomeState>(context);
    // records.currencies.addAll(records.currencies);
    // records.currencies.sort((a, b) => a.id.compareTo(b.id));
    if (selectedIndex == -1 &&
        widget.initialCurrencyId != null &&
        widget.initialCurrencyId.isNotEmpty) {
      selectedIndex = records.currencies
          .indexWhere((cur) => cur.id == widget.initialCurrencyId);
    }
  }

  _updateSelectedIndex(int index) {
    setState(() => selectedIndex = index);
    homeState.currencyPickerValue = records.currencies[index].id;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(14),
      itemBuilder: (BuildContext context, int index) {
        Color color = index == selectedIndex
            ? Colors.green.withOpacity(0.6)
            : Colors.transparent;
        return _buildCurrencyItem(
          currency: records.currencies[index],
          color: color,
          onTap: () => _updateSelectedIndex(index),
        );
      },
      separatorBuilder: (BuildContext context, int index) => Divider(),
      itemCount: records.currencies.length,
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
            SizedBox(
              width: 50,
              child: Text(
                currency.id.toUpperCase(),
                style: TextStyle(color: appState.cols.content, fontSize: 16),
              ),
            ),
            Expanded(
              child: Text(
                currency.name,
                style: TextStyle(color: appState.cols.content, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}
