import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import '../../utils/app_log.dart';
import '../models/home_page_response.dart';

class HomeRepository {
  const HomeRepository();

  Future<HomePageResponse> getHomePageDetails(int num) async {
    final dio = Dio();
    final response = await dio.get("https://randomuser.me/api/?results=$num.");
    print("statusCode::${response.statusCode}");
    if (response.statusCode == 200) {
      if (response.data != null && response.data['results']!=null) {
        AppLog.d("Response::${response.data.toString()}");
        return HomePageResponse.fromJson(response.data);
      } else {
        throw Exception("No results found");
      }
    } else {
      throw Exception(response.statusMessage);
    }
  }


}