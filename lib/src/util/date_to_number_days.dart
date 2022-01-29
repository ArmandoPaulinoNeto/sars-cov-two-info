import 'package:intl/intl.dart';

class DateToNumberDays{

  DateTime ?dateInitial;

  DateToNumberDays(String dateInitial){

    this.dateInitial = new DateFormat('dd/MM/yyyy').parse(dateInitial);
  }

  String numberDays(){
    int difference = DateTime.now().difference(dateInitial!).inDays;
    return difference.toString();
  }
}