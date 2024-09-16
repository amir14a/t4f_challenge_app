import 'package:dio/dio.dart';
import 'package:t4f_challenge_app/model/item_model.dart';
import 'package:t4f_challenge_app/repository/consts.dart';

abstract class AppAPI {
  static final dio = Dio();

  static Future<List<ItemModel>> getItems() async {
    var response = await dio.get('$apiBaseUrl/api/v1/home/items');
    return ItemModel.fromListMap(response.data);
  }
}
