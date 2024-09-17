import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:t4f_challenge_app/model/item_model.dart';
import 'package:t4f_challenge_app/repository/api.dart';
import 'package:t4f_challenge_app/repository/consts.dart';
import 'package:t4f_challenge_app/repository/enums.dart';
import 'package:t4f_challenge_app/repository/themes.dart';

class HomeViewModel extends ChangeNotifier {
  ValueNotifier<List<ItemModel>?> items = ValueNotifier(null);
  ValueNotifier<AppApiRequestState> requestState = ValueNotifier(AppApiRequestState.NOT_SENT_YET);
  ThemeData theme = appLightTheme;
  ScrollController listController = ScrollController();
  Key listKey = UniqueKey();

  HomeViewModel() {
    items.addListener(notifyListeners);
    requestState.addListener(notifyListeners);
  }

  @override
  void dispose() {
    items.dispose();
    requestState.dispose();
    super.dispose();
  }

  bool get isDarkMode => theme == appDarkTheme;

  getItemsFromApi() async {
    requestState.value = AppApiRequestState.SENDING;
    await Future.delayed(const Duration(seconds: 1)); // For view loading animation longer
    try {
      var list = await AppApi.getItems();
      list.shuffle(); // Asked in project infos to load items in random sort
      items.value = list;
      requestState.value = AppApiRequestState.SUCCESS;
      await reorderCurrentList();
    } catch (e) {
      requestState.value = AppApiRequestState.FAILED;
    }
  }

  toggleDarkMode(c) {
    if (theme == appLightTheme) {
      theme = appDarkTheme;
    } else {
      theme = appLightTheme;
    }
    ThemeSwitcher.of(c).changeTheme(theme: theme, isReversed: false // default: false
        );
  }

  saveLastVisitedItem(int itemId) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getInt(lastVisitedItemIdKey) != itemId) {
      await sharedPreferences.setInt(lastVisitedItemIdKey, itemId);
      await reorderCurrentList();
    }
  }

  reorderCurrentList() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    int? lastVisitedItemId = sharedPreferences.getInt(lastVisitedItemIdKey);
    if (lastVisitedItemId != null) {
      if (listController.hasClients) {
        //moving the scroll view to the first position
        await listController.animateTo(0, duration: const Duration(milliseconds: 600), curve: Curves.easeOut);
      }
      var lastVisitedItem = items.value?.firstWhere((e) => e.id == lastVisitedItemId);
      items.value?.remove(lastVisitedItem);
      items.value?.insert(0, lastVisitedItem!);
      listKey = UniqueKey(); //Change list key to rebuild it with animation using AnimatedSwitcher widget
      notifyListeners();
    }
  }
}
