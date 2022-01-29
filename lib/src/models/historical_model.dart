import 'historical_country_model.dart';

class Historical extends HistoricalCountry{

  List<HistoricalCountry> fromJson(List<dynamic> json) {

    List<HistoricalCountry> countries = [];

    for(Map<String, dynamic> list  in json){
      countries.add(HistoricalCountry.fromJson(list));
    }
    return countries;
  }
}