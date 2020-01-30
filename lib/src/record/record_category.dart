import 'package:eatsleeptravel/src/helpers/colors.dart';
import 'package:eatsleeptravel/src/helpers/utils.dart';
import 'package:eatsleeptravel/src/models/Category.dart';
import 'package:eatsleeptravel/src/services/app_state.dart';
import 'package:eatsleeptravel/src/services/record_state.dart';
import 'package:eatsleeptravel/src/services/records.dart';
import 'package:eatsleeptravel/src/services/session_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const Color col_content = col_main1;
const Color col_back = Colors.white;

class RecordCategory extends StatefulWidget {
  @override
  _RecordCategoryState createState() => _RecordCategoryState();
}

class _RecordCategoryState extends State<RecordCategory> {
  SessionData sessionData;
  AppState appState;
  RecordState recordState;
  Records records;
  List<String> smartCategories = [];
  List<CatButton> mainCatButtons = [];
  List<CatButton> subCatButtons = [];
  List<CatButton> smartCatButtons = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    sessionData = Provider.of<SessionData>(context);
    appState = Provider.of<AppState>(context);
    recordState = Provider.of<RecordState>(context);
    records = Provider.of<Records>(context);

    if (mainCatButtons.isEmpty) _buildMainCategoryButtons();
    if (subCatButtons.isEmpty) _buildSubCategoryButtons();
    smartCategories = _getSmartCategories();
  }

  _buildMainCategoryButtons() {
    mainCatButtons = sessionData.maincats.entries.map((c) {
      return CatButton(
        category: c.value,
        showLabel: false,
        isMainCat: true,
      );
    }).toList();

    // Add the 'quick' category to main categories
    mainCatButtons.insert(
        0,
        CatButton(
          category: MainCategory(
            icon: Icons.flash_on,
            name: 'Smart',
            id: 'quick',
          ),
          showLabel: true,
          isMainCat: true,
        ));
  }

  _buildSubCategoryButtons() {
    subCatButtons = sessionData.subcats.entries.map((c) {
      return CatButton(
        category: c.value,
        showLabel: false,
        isMainCat: false,
      );
    }).toList();
  }

  List<String> _getSmartCategories() {
    // build 8 buttons from the latest 30 days of expenses
    final now = DateTime.now();
    final expenseList = records.full
        .where((record) => now.difference(record.expenseDT).inDays.abs() <= 30)
        .toList();
    return Utils().getSmartCategories(expenseList, 8);
  }

  Widget build(BuildContext context) {
    // Sizing
    final h = appState.viewHeight;
    final w = appState.viewWidth;
    bool isShort = false;
    bool isNarrow = false;

    if (h < 735) {
      isShort = true;
    }

    if (w < 400) {
      isNarrow = true;
    }

    List<CatButton> contextCategoryButtons =
        recordState.selectedMainCategory == 'quick'
            ? subCatButtons
                .where((btn) => smartCategories.contains(btn.category.id))
                .toList()
            : subCatButtons
                .where((btn) =>
                    btn.category.groupId == recordState.selectedMainCategory)
                .toList();

    return Container(
      // padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: mainCatButtons,
          ),
          isShort ? SizedBox(height: 5) : SizedBox(height: 20),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            color: Colors.white.withOpacity(0.4),
            height: 1,
          ),
          isShort ? SizedBox(height: 5) : SizedBox(height: 20),
          // Smart suggestions
          SizedBox(
            height: 55,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: contextCategoryButtons,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            color: Colors.white.withOpacity(0.4),
            height: 1,
          ),
        ],
      ),
    );
  }
}

class CatButton extends StatefulWidget {
  CatButton(
      {Key key,
      this.category,
      this.isMainCat = false,
      // this.isDimmed = false,
      this.showLabel = true})
      : super(key: key);

  final Category category;
  final bool isMainCat;
  // bool isDimmed;
  final bool showLabel;

  @override
  _CatButtonState createState() => _CatButtonState();
}

class _CatButtonState extends State<CatButton> {
  AppState appState;
  RecordState recordState;
  SessionData sessionData;

  @override
  void didChangeDependencies() {
    appState = Provider.of<AppState>(context);
    recordState = Provider.of<RecordState>(context);
    sessionData = Provider.of<SessionData>(context);
    super.didChangeDependencies();
  }

  void handleTap() {
    if (widget.isMainCat) {
      // recordState.updateNewExpense('mainCategory', widget.category);
      recordState.selectedMainCategory = widget.category.id;
    }
    if (!widget.isMainCat) {
      // if sub category
      final MainCategory maincat =
          sessionData.maincats[widget.category.groupId];
      recordState.updateNewExpense('mainCategory', maincat);
      recordState.updateNewExpense('subCategory', widget.category);
    }
  }

  @override
  Widget build(BuildContext context) {
    var selectedMainCatId = recordState.selectedMainCategory;
    var selectedSubCatId = recordState.newExpense?.subCategory?.id ?? '';
    var selectedId = widget.isMainCat ? selectedMainCatId : selectedSubCatId;
    var isDimmed = widget.category.id != selectedId;
    var iconOpacity = isDimmed ? 0.8 : 1.0;
    var labelOpacity = isDimmed ? 0.8 : 1.0;
    var color = isDimmed
        ? appState.cols.content.withOpacity(0.9)
        : appState.cols.actionlight;
    if (widget.isMainCat && !widget.showLabel) labelOpacity = 0.0;
    return GestureDetector(
      onTap: handleTap,
      child: Container(
        width: widget.isMainCat ? null : 85,
        child: Column(
          verticalDirection:
              widget.isMainCat ? VerticalDirection.up : VerticalDirection.down,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Icon(
              widget.category.icon,
              size: 30,
              color: color,
            ),
            SizedBox(height: 5),
            Text(
              widget.category.name,
              style: TextStyle(color: color, fontSize: 12),
              maxLines: 1,
              overflow: TextOverflow.clip,
            ),
          ],
        ),
      ),
    );
  }
}
