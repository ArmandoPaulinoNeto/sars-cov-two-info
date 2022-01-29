import 'package:flutter/material.dart';
import 'app_controller.dart';
import 'gerencia_state.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: AppController.intancia,
      builder: (context, child) {
        return MaterialApp(
          theme: ThemeData(
              primarySwatch: Colors.deepOrange,
              brightness: AppController.intancia.mudaEstado
                  ? Brightness.dark
                  : Brightness.light),
          title: 'Sejam Bem-vindos',
          home: GerenciaDeState(),
        );
      },
    );
  }
}
