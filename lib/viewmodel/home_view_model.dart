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
  ValueNotifier<ThemeData> theme = ValueNotifier(appLightTheme);
  ScrollController listController = ScrollController();
  Key listKey = UniqueKey();

  HomeViewModel() {
    items.addListener(notifyListeners);
    requestState.addListener(notifyListeners);
    theme.addListener(notifyListeners);
  }

  @override
  void dispose() {
    items.dispose();
    requestState.dispose();
    theme.dispose();
    super.dispose();
  }

  bool get isDarkMode => theme.value == appDarkTheme;

  getItemsFromApi() async {
    requestState.value = AppApiRequestState.SENDING;
    await Future.delayed(Duration(seconds: 4));
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

  toggleDarkMode() {
    if (theme.value == appLightTheme) {
      theme.value = appDarkTheme;
    } else {
      theme.value = appLightTheme;
    }
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
