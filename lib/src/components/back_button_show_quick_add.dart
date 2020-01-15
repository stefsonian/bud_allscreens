import 'package:eatsleeptravel/src/services/app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Two classes that extend BackButton to also show or hide the quick add button

class BackButtonShowQuickAdd extends BackButton {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    assert(debugCheckHasMaterialLocalizations(context));
    return IconButton(
      icon: const BackButtonIcon(),
      color: color,
      tooltip: MaterialLocalizations.of(context).backButtonTooltip,
      onPressed: () {
        appState.showQuickAddButton = true; // the only change
        Navigator.maybePop(context);
      },
    );
  }
}

class BackButtonHideQuickAdd extends BackButton {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    assert(debugCheckHasMaterialLocalizations(context));
    return IconButton(
      icon: const BackButtonIcon(),
      color: color,
      tooltip: MaterialLocalizations.of(context).backButtonTooltip,
      onPressed: () {
        appState.showQuickAddButton = false; // the only change
        Navigator.maybePop(context);
      },
    );
  }
}
