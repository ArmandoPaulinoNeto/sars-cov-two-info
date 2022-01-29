import 'package:sars_cov_two_info/src/util/calc_number_for_day_util.dart';
import 'package:sars_cov_two_info/src/util/data_format_util.dart';
class HistoricalCountry {

  String ?country;
  String ?province;
  Timeline ?timeline;

  HistoricalCountry({this.country, this.province, this.timeline});

  HistoricalCountry.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    province = json['province'].toString();
    timeline = new Timeline.fromJson(json['timeline']);
  }
}

class Timeline {
  List<double> deaths = [];
  List<double> cases = [];
  List<double> recovered = [];
  List<String> dayCases = [];
  List<String> dayDeaths = [];
  List<String> dayRecovereds = [];

  Timeline(this.cases, this.deaths, this.recovered);

  Timeline.fromJson(Map<String, dynamic> json) {

    StringFormatDate dateFormat = new StringFormatDate();
    CalculatorNumberForDay calcNumberForDay = CalculatorNumberForDay();

    for(String key in json['cases'].keys){
      dayCases.add(dateFormat.dataFormat(key));
      cases.add(json['cases'][key].toDouble());
    }
    for(String key in json['deaths'].keys){
      dayDeaths.add(dateFormat.dataFormat(key));
      deaths.add(json['deaths'][key].toDouble());
    }
    for(String key in json['recovered'].keys){
      dayRecovereds.add(dateFormat.dataFormat(key));
      recovered.add(json['recovered'][key].toDouble());
    }
    cases = calcNumberForDay.calcNumberForDay(cases);
    deaths = calcNumberForDay.calcNumberForDay(deaths);
    recovered = calcNumberForDay.calcNumberForDay(recovered);
  }
}