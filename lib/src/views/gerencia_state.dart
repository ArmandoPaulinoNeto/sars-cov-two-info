import 'package:flutter/material.dart';
import 'package:sars_cov_two_info/src/controllers/home_controller.dart';
import 'package:sars_cov_two_info/src/util/date_to_number_days.dart';
import '../controllers/historical_graphic_controller.dart';

class GerenciaDeState extends StatefulWidget {
  @override
  State<GerenciaDeState> createState() {
    return TelaPrincipalState();
  }
}
class TelaPrincipalState extends State<GerenciaDeState> {
  final controller = HomeController();
  bool loudedGrephic = false;
  @override
  void initState() {
    controller.start();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Covid-19 info'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh_outlined),
            onPressed: () {
              restart();
            },
          ),
        ]
       // actions: [SwitchTheme(),],
      ),
      body: AnimatedBuilder(
              animation:
              controller.state,
              builder: (context, child) {
                return stateManagement(controller.state.value);
              },
            ),
    );
  }
  Widget buildCard(it) => Container(
    width: 200,
      child:
        Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(149, 206, 157, 1.0),
              borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(10.0),
                topRight: const Radius.circular(10.0),
                bottomLeft: const Radius.circular(10.0),
                bottomRight: const Radius.circular(10.0),
            ),
          ),
          padding: const EdgeInsets.all(15),
          width: 200,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 10),
                width: 200,
                child: Text("Casos ${controller.historicalCountry.timeline!.cases[it]}",
                  style: TextStyle(color: Color.fromRGBO(2, 110, 60, 1.0), fontSize: 18, fontWeight: FontWeight.bold ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 10),
                width: 200,
                child: Text(controller.historicalCountry.timeline!.dayCases[it],
                  style: TextStyle(color: Color.fromRGBO(154, 69, 33, 1.0), fontSize: 18, fontWeight: FontWeight.bold ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 10),
                width: 200,
                child: Text("Recuperados ${controller.historicalCountry.timeline!.recovered[it]}",
                  style: TextStyle(color: Color.fromRGBO(2, 110, 60, 1.0), fontSize: 18, fontWeight: FontWeight.bold ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 10),
                width: 200,
                child: Text(controller.historicalCountry.timeline!.dayRecovereds[it],
                  style: TextStyle(color: Color.fromRGBO(154, 69, 33, 1.0), fontSize: 18, fontWeight: FontWeight.bold ),
                ),
              ),
            ],
          ),
        ),
  );

  _start(){
    return Container();
  }

  _loading(){
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  _sucess(){
    return ListView(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 20, bottom: 15),
          child: Center(
            child:
              Text(controller.historicalCountry.country!,
                style: TextStyle(color: Color.fromRGBO(154, 69, 33, 1.0), fontSize: 22, fontWeight: FontWeight.bold ),
              ),
          ),
        ),
        Card(
          elevation: 10,
          child: HistoricalGraphic(controller.historicalCountry).getGraphic(),
        ),
        Container(
          padding: const EdgeInsets.all(5),
          height: 180,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: controller.historicalCountry.timeline!.cases.length,
            separatorBuilder: (context, _) => SizedBox(width: 12,),
            itemBuilder: (context, index) => buildCard(index),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 15, left: 270),
          child:
            FloatingActionButton(
              backgroundColor: Color.fromRGBO(154, 69, 33, 1.0),
              child: Icon(Icons.search),
              onPressed: (){
                showDialogWithFields();
              }),
        )
      ],
    );
  }

  _error(){
    return Center(
      child: RaisedButton(onPressed: (){
        restart();
      },
        child: Text('Tentar novamente'),),
    );
  }
  void showDialogWithFields() {
    showDialog(
      context: context,
      builder: (_) {
        var countryController = TextEditingController();
        var dateStartController = TextEditingController();
        var dateEndtController = TextEditingController();

        return AlertDialog(
          title: Text('Pesquisar:', style: TextStyle(color: Color.fromRGBO(154, 69, 33, 1.0))),
          shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10)),
          backgroundColor: Color.fromRGBO(149, 206, 157, 1.0),
          content: ListView(
            shrinkWrap: true,
            children: [
              Container(),
              TextFormField(
                controller: countryController,
                decoration: InputDecoration(hintText: 'País'),
              ),
              TextFormField(
                controller: dateStartController,
                decoration: InputDecoration(hintText: 'Data Inicial'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancelar', style: TextStyle(color: Color.fromRGBO(154, 69, 33, 1.0))),
            ),
            TextButton(
              onPressed: () { 

                var country = countryController.text;
                var dateInitial = dateStartController.text;

                if(country.isNotEmpty){
                  if(verifyDate(dateInitial)){
                    controller.country = country;
                    controller.lastdays = DateToNumberDays(dateInitial).numberDays();
                    Navigator.pop(context);
                    controller.start();
                  }else{
                    Navigator.pop(context);
                    showMaterialBannerDate();
                  }
                }else{
                  Navigator.pop(context);
                  showMaterialBannerCountry();
                }
              },
              child: Text('Pesquisar', style: TextStyle(color: Color.fromRGBO(154, 69, 33, 1.0))),
            ),
          ],
        );
      },
    );
  }
  showMaterialBannerCountry(){
    ScaffoldMessenger.of(context)..removeCurrentMaterialBanner()..showMaterialBanner(
      MaterialBanner(
        content: const Text('Preencha os campos corretamente!', style: TextStyle(color: Color.fromRGBO(154, 69, 33, 1.0))),
        leading: const Icon(Icons.info),
        backgroundColor: Colors.tealAccent,
        actions: [
          TextButton(onPressed: (){
            ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
            showDialogWithFields();
          }, child: const Text('Fechar')),
        ],
      )
    );
  }
  showMaterialBannerDate(){
    ScaffoldMessenger.of(context)..removeCurrentMaterialBanner()..showMaterialBanner(
        MaterialBanner(
          content: const Text('Digite uma data com o farmaato dia/mês/ano.', style: TextStyle(color: Color.fromRGBO(154, 69, 33, 1.0))),
          leading: const Icon(Icons.info),
          backgroundColor: Colors.tealAccent,
          actions: [
            TextButton(onPressed: (){
              ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
              showDialogWithFields();
            }, child: const Text('Fechar')),
          ],
        )
    );
  }
  restart(){
    controller.country = "brasil";
    controller.lastdays = '31';
    controller.start();
  }
  bool verifyDate(String date){

    List<String> positions = date.split("");
    for(int i = 0; i < 10; i++ ) {
      date = date.replaceAll(i.toString(), "*");
    }
    return date == "**/**/****" ? true : false;
  }
  stateManagement(HOME_STATE state){
    switch(state){
      case HOME_STATE.start:
        return _start();//start, loading, sucess, error
      case HOME_STATE.loading:
        return _loading();
      case HOME_STATE.sucess:
        return _sucess();
      case HOME_STATE.error:
        return _error();
      default:
    }
  }
}
