import 'package:eatsleeptravel/src/helpers/colors.dart';
import 'package:eatsleeptravel/src/models/Category.dart';
import 'package:eatsleeptravel/src/services/app_state.dart';
import 'package:eatsleeptravel/src/services/record_state.dart';
import 'package:eatsleeptravel/src/services/session_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const Color col_content = col_main1;
const Color col_back = Colors.white;

class RecordCategory extends StatelessWidget {
  // static const IconData tags =
  //     const IconData(0xe801, fontFamily: 'MyFlutterApp');
  @override
  Widget build(BuildContext context) {
    final sessionData = Provider.of<SessionData>(context);
    final appState = Provider.of<AppState>(context);
    final recordState = Provider.of<RecordState>(context);
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
    // ------
    // Make catButtons from main categories
    var selectedMainCatId = recordState.newExpense?.mainCategory?.id ?? 'quick';
    var selectedSubCatId = recordState.newExpense?.subCategory?.id ?? '';
    List<CatButton> mainCatButtons = sessionData.maincats.entries.map((c) {
      return CatButton(
        category: c.value,
        showLabel: false,
        isMainCat: true,
        isDimmed: c.value.id != selectedMainCatId,
      );
    }).toList();

    // Add the 'quick' category to main categories
    mainCatButtons.insert(
        0,
        CatButton(
          category: MainCategory(
            icon: Icons.flash_on,
            name: '',
            id: 'quick',
          ),
          showLabel: false,
          isMainCat: true,
          isDimmed: selectedMainCatId != 'quick',
        ));

    // Make CatButtons from subcategories belonging to the selected main category
    List<CatButton> subCatButtons = sessionData.subcats.entries
        .where((c) => c.value.groupId == selectedMainCatId)
        .map((c) {
      return CatButton(
        category: c.value,
        showLabel: false,
        isMainCat: false,
        isDimmed: c.value.id != selectedSubCatId,
      );
    }).toList();

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
              children: subCatButtons,
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
  const CatButton(
      {Key key,
      this.category,
      this.isMainCat = false,
      this.isDimmed = false,
      this.showLabel = true})
      : super(key: key);

  final Category category;
  final bool isMainCat;
  final isDimmed;
  final showLabel;

  @override
  _CatButtonState createState() => _CatButtonState();
}

class _CatButtonState extends State<CatButton> {
  AppState appState;
  RecordState recordState;

  @override
  void didChangeDependencies() {
    appState = Provider.of<AppState>(context);
    recordState = Provider.of<RecordState>(context);
    super.didChangeDependencies();
  }

  void handleTap() {
    print('i was tapped');
    if (widget.isMainCat) {
      recordState.updateNewExpense('mainCategory', widget.category);

      // appState.newExpense.mainCategory = widget.category;
      setState(() {});
    }
    if (!widget.isMainCat) {
      recordState.updateNewExpense('subCategory', widget.category);
    }
  }

  @override
  Widget build(BuildContext context) {
    var iconOpacity = widget.isDimmed ? 0.8 : 1.0;
    var labelOpacity = widget.isDimmed ? 0.8 : 1.0;
    var color = widget.isDimmed
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
