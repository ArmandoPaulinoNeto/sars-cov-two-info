import 'package:flutter/material.dart';
import 'package:sars_cov_two_info/src/models/historical_country_model.dart';
import 'package:sars_cov_two_info/src/repositories/repository.dart';

class HomeController{

  final state = ValueNotifier<HOME_STATE>(HOME_STATE.start);
  String country = "brasil";
  String lastdays = '31';
  late HistoricalCountry historicalCountry;
  final repository = Repository();

  Future start() async{
    state.value = HOME_STATE.loading;
    try{
      historicalCountry = await repository.getHistoricalCoutryLastdays(country: country, lastdays: lastdays);
      state.value = HOME_STATE.sucess;
    }catch(e){
      print(e);
      state.value = HOME_STATE.error;
    }
  }
}
enum HOME_STATE{start, loading, sucess, error}

