class CalculatorNumberForDay{

  List<double> calcNumberForDay(List<double> values){

    double firstValue = values.removeAt(0);
    List<double> auxilian = [];

    for(int i = 0; i < values.length; i++){
      auxilian.add((values[i] - firstValue));
      firstValue = values[i];
    }
    return auxilian;
  }
}