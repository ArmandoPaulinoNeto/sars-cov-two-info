import 'package:sars_cov_two_info/src/models/historical_country_model.dart';
import 'package:sars_cov_two_info/src/models/historical_model.dart';
import 'package:dio/dio.dart';

class Repository{

  final _dio = Dio();

  String urlJHUCSSE = "https://disease.sh/v3/covid-19/historical";
  
  Future<List<HistoricalCountry>> getHistorical() async {
    Response response = await _dio.get('$urlJHUCSSE');
    if (response.statusCode != 200) {
      throw Exception();
    } else {
      return Historical().fromJson(response.data);
    }
  }
  Future<List<HistoricalCountry>> getHistoricalLastdays({required String lastdays}) async {
    Response response = await _dio.get('$urlJHUCSSE/lastdays=$lastdays');
    if (response.statusCode != 200) {
      throw Exception();
    } else {
      return Historical().fromJson(response.data);
    }
  }
  Future<HistoricalCountry> getHistoricalCoutry({required String country}) async {
    Response response = await _dio.get('$urlJHUCSSE/$country');
    if (response.statusCode != 200) {
      throw Exception();
    } else {
      return HistoricalCountry.fromJson(response.data);
    }
  }
  Future<HistoricalCountry> getHistoricalCoutryLastdays({required String country, required String lastdays}) async {
    Response response = await _dio.get('$urlJHUCSSE/$country?lastdays=$lastdays');
    if (response.statusCode != 200) {
      throw Exception();
    } else {
      return HistoricalCountry.fromJson(response.data);
    }
  }
}