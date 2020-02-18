import 'package:flutter/material.dart';

class ExpenseListState with ChangeNotifier {
  // ExpenseListState({@required List<String> htags}) {
  //   _hashtags = htags;
  // }

  List<String> _hashtags = [];
  List<String> get hashtags => _hashtags;
  set hashtags(List<String> hashtags) {
    _hashtags = hashtags;
    _hashtags.forEach((t) {
      _filterHashtags.putIfAbsent(t, () => true);
    });
    notifyListeners();
  }

  Future<void> setHashtags(List<String> htags) async {
    return Future.delayed(Duration(milliseconds: 1), () => hashtags = htags);
  }

  DateTime _filterStartDate;
  DateTime get filterStartDate => _filterStartDate;
  set filterStartDate(DateTime filterStartDate) {
    _filterStartDate = filterStartDate;
    notifyListeners();
  }

  DateTime _filterEndDate;
  DateTime get filterEndDate => _filterEndDate;
  set filterEndDate(DateTime filterEndDate) {
    _filterEndDate = filterEndDate;
    notifyListeners();
  }

  List<String> _filterMainCats;
  List<String> get filterMainCats => _filterMainCats;
  set filterMainCats(List<String> filterMainCats) {
    _filterMainCats = filterMainCats;
    notifyListeners();
  }

  Map<String, bool> _filterHashtags = {};
  Map<String, bool> get filterHashtags => _filterHashtags;
  set filterHashtags(Map<String, bool> filterHashtags) {
    _filterHashtags = filterHashtags;
    notifyListeners();
  }

  void updateFilterHashtag(String hashtag, bool value) {
    _filterHashtags[hashtag] = value;
    notifyListeners();
  }

  reset() {
    // reset values
    notifyListeners();
  }
}
