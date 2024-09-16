import 'package:flutter/material.dart';
import 'package:t4f_challenge_app/model/item_model.dart';
import 'package:t4f_challenge_app/repository/api.dart';
import 'package:t4f_challenge_app/repository/enums.dart';
import 'package:t4f_challenge_app/repository/themes.dart';

class HomeViewModel extends ChangeNotifier {
  ValueNotifier<List<ItemModel>?> items = ValueNotifier(null);
  ValueNotifier<AppApiRequestState> requestState = ValueNotifier(AppApiRequestState.NOT_SENT_YET);
  ValueNotifier<ThemeData> theme = ValueNotifier(appLightTheme);

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
    try {
      items.value = await AppApi.getItems();
      requestState.value = AppApiRequestState.SUCCESS;
    } catch (e) {
      print(e);
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
}
