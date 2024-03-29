import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:recipe/settings/server.dart';
import 'package:recipe/models/category.dart';

class CategoryRepository {
  // API로 호출해서 값을 받아오는 부분
  // ui에서 접근X
  // controller에서 접근O
  final http.Client _client = http.Client();

  Future<List<Category>> getCategoryList() async {
    Uri url = Uri.parse(getUrl("list"));
    var response = await _client.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );

    print("getCategoryList API Code " + response.statusCode.toString());

    if (response.statusCode == 200) {
      // 200 : 성공코드
      final responseBody = json.decode(response.body);
      List<Category> list = responseBody
          .map<Category>((item) => Category.fromJson(item))
          .toList();
      return list;
    } else {
      return [];
    }
  }

  String getUrl(String control) {
    return "${Server.serverUrl}/category/$control";
  }
}
