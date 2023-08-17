import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../utils/app_log.dart';
import '../models/home_page_response.dart';

class HomeRepository {
  const HomeRepository();

  Future<HomePageResponse> getHomePageDetails() async {
    http.Response response = await http.get(Uri.parse("https://randomuser.me/api/?results=5."));
    print("statusCode::${response.statusCode}");
    if (response.statusCode == 200){
      AppLog.d("Response::${response.body.toString()}");
      var result = jsonDecode(response.body);
      return HomePageResponse.fromJson(result);
    }else{
      throw Exception(response.reasonPhrase);
    }
  }

}