import 'package:flutter/material.dart';

class AppController extends ChangeNotifier{

  bool mudaEstado = false;
  static AppController intancia = AppController();

  alteraEstado(){
    mudaEstado = !mudaEstado;
    notifyListeners();
  }
}