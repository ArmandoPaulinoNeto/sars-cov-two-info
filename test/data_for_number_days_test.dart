import 'package:flutter_test/flutter_test.dart';
import 'package:sars_cov_two_info/src/util/date_to_number_days.dart';

main(){

  test("Conveter data para numero de dias", () async {
    //DateForNumberDays dates = DateForNumberDays('26/10/2021', '26/11/2021');
    String date = "12/12/2021".replaceAll("1", "");
    print(date);
    //return date == "**/**/****" ? true : false;
    print(date == "**/**/****" ? true : false);
  });
}