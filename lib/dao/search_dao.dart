import 'package:xiecheng/model/home_model.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:xiecheng/model/sesarch_model.dart';

const SEARCH_URL =
    'https://m.ctrip.com/restapi/h5api/searchapp/search?source=mobileweb&action=autocomplete&contentType=json&keyword=';

//搜索接口
class SearchDao{
  static Future<SearchModel> fetch(String keyword,String text) async {
    print(SEARCH_URL+keyword);
    final response = await http.get(SEARCH_URL+keyword);
    if(response.statusCode == 200){
      Utf8Decoder utf8decoder = Utf8Decoder();    //修复中文乱码
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      //SearchModel model = SearchModel.fromJson(result);
      return SearchModel.fromJson(result);
    }else{
      throw Exception('Failed to load search');
    }
  }
}