import 'package:eatsleeptravel/src/components/dialog_header.dart';
import 'package:eatsleeptravel/src/models/Currency.dart';
import 'package:eatsleeptravel/src/services/app_state.dart';
import 'package:eatsleeptravel/src/services/firestore_service.dart';
import 'package:eatsleeptravel/src/services/home_state.dart';
import 'package:eatsleeptravel/src/services/record_state.dart';
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

class SetRecordCurrencyHeader extends StatelessWidget {
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
        mainHeader: 'Set expense currency',
        subHeader: '',
        color: appState.cols.content,
      ),
    );
  }
}

class SelectCurrency extends StatefulWidget {
  const SelectCurrency(
      {Key key, this.initialCurrencyId, this.stateToUpdate = 'home'})
      : super(key: key);
  final String initialCurrencyId;
  final String stateToUpdate; // which state to update of ('home', 'record')

  @override
  _SelectCurrencyState createState() => _SelectCurrencyState();
}

class _SelectCurrencyState extends State<SelectCurrency> {
  SessionData sessionData;
  AppState appState;
  Records records;
  HomeState homeState;
  RecordState recordState;
  List<Currency> currencies = [];
  int selectedIndex = -1;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    appState = Provider.of<AppState>(context);
    sessionData = Provider.of<SessionData>(context);
    records = Provider.of<Records>(context);
    homeState = Provider.of<HomeState>(context);
    recordState = Provider.of<RecordState>(context);
    // records.currencies.addAll(records.currencies);
    // records.currencies.sort((a, b) => a.id.compareTo(b.id));
    _initialiseCurrencies();
  }

  _initialiseCurrencies() {
    if (currencies.isNotEmpty) return; // only run once
    // throw away currencies with no exchange rate
    var latestX = records.latestXrates();
    currencies.addAll(records.currencies);
    currencies.retainWhere((c) => latestX.containsKey(c.id));
    // add recently used currencies. start list with usd and eur.
    var recent = records.recentlyUsedCurrencies();
    // var latestDisplayed = sessionData.user.displayCurrencies.values
    //     .toList()
    //     .map((cId) => records.getCurrency(cId))
    //     .toList();
    // latestDisplayed.removeWhere(
    //     (c) => c.id == 'usd' || c.id == 'eur'); // avoid duplicates in recent
    // var latestDisplayedIds = latestDisplayed.map((c) => c.id).toList();
    // recent.removeWhere(
    //     (c) => latestDisplayedIds.contains(c.id)); // avoid duplicates in recent
    recent.removeWhere(
        (c) => c.id == 'usd' || c.id == 'eur'); // avoid duplicates in recent
    // recent.insertAll(0, latestDisplayed);
    currencies.insertAll(0, recent);
    currencies.insert(0, records.getCurrency('eur'));
    currencies.insert(0, records.getCurrency('usd'));

    // set starting selection
    if (selectedIndex == -1 &&
        widget.initialCurrencyId != null &&
        widget.initialCurrencyId.isNotEmpty) {
      selectedIndex =
          currencies.indexWhere((cur) => cur.id == widget.initialCurrencyId);
    }
  }

  _updateSelectedIndex(int index) {
    setState(() => selectedIndex = index);
    if (widget.stateToUpdate == 'home')
      homeState.currencyPickerValue = currencies[index].id;
    if (widget.stateToUpdate == 'record')
      recordState.currencyPickerValue = currencies[index].id;
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
          currency: currencies[index],
          color: color,
          onTap: () => _updateSelectedIndex(index),
        );
      },
      separatorBuilder: (BuildContext context, int index) => Divider(),
      itemCount: currencies.length,
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
