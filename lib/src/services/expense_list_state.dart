import 'package:eatsleeptravel/src/models/Category.dart';
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

  Future<void> setMainCategories(List<MainCategory> maincats) async {
    return Future.delayed(Duration(milliseconds: 1), () {
      Map<MainCategory, bool> tmp = {};
      maincats.forEach((mc) => tmp[mc] = true);
      filterMainCategories = tmp;
    });
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

  Map<MainCategory, bool> _filterMainCategories = {};
  Map<MainCategory, bool> get filterMainCategories => _filterMainCategories;
  set filterMainCategories(Map<MainCategory, bool> filterMainCategories) {
    _filterMainCategories = filterMainCategories;
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

  void updateFilterMainCategory(MainCategory maincat, bool value) {
    _filterMainCategories[maincat] = value;
    notifyListeners();
  }

  bool passesHashtagFilter(List<String> hts) {
    if (filterHashtags.isEmpty) return true;
    if (hts.isEmpty) return true;
    bool result = false;
    hts.forEach((ht) {
      if (filterHashtags.containsKey(ht)) {
        if (filterHashtags[ht]) result = true;
      }
    });
    return result;
  }

  bool passesMainCategoriesFilter(MainCategory mc) {
    if (filterMainCategories.isEmpty) return true;
    if (mc == null) return true;
    bool result = false;
    filterMainCategories.keys.forEach((fmc) {
      if (fmc.id == mc.id && filterMainCategories[fmc]) result = true;
    });
    return result;
  }

  Map<String, String> _orderBy = {'expenseDT': 'descending'};
  Map<String, String> get orderBy => _orderBy;
  set orderBy(Map<String, String> orderBy) {
    _orderBy = orderBy;
    notifyListeners();
  }

  reset() {
    // reset values
    notifyListeners();
  }
}
