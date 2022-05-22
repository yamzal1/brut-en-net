import 'dart:math';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final nameController = TextEditingController();
  final HBController = TextEditingController();
  final MBController = TextEditingController();
  final ABController = TextEditingController();

  final HNController = TextEditingController();
  final MNController = TextEditingController();
  final ANController = TextEditingController();
  double _dureeTravail = 100;
  double _valuePrelevementSource = 0;

  int _valueStatut = 22;
  int _valuePrime = 12;

  void _changementStatut(int? value) {
    setState(() {
      _valueStatut = value ?? 0;
    });
  }

  void _changementPrime(int? value) {
    setState(() {
      _valueStatut = value ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Brut net'),
          centerTitle: true,
        ),
        body: Flex(
          direction: Axis.vertical,
          children: [Column(
            mainAxisAlignment: MainAxisAlignment.center, //Center Column contents vertically,

            children: [
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: HBController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Horaire brut',
                              ),
                              keyboardType: TextInputType.number,
                              validator: (amount) => amount != null && double.tryParse(amount) == null
                                  ? 'Saisir un nombre valide'
                                  : null,
                              onChanged: (text){
                                onHBChange();
                              },
                            )
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: MBController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Mensuel brut',
                              ),
                              maxLines: 1,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: ABController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Annuel brut',
                              ),
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: HNController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Horaire net',
                            ),
                            maxLines: 1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: MNController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Mensuel net',
                            ),
                            maxLines: 1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: ANController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Annuel net',
                            ),
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Radio(
                      value: 22,
                      groupValue: _valueStatut,
                      onChanged: _changementStatut,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Non cadre (-22%)',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                    Radio(
                      value: 25,
                      groupValue: _valueStatut,
                      onChanged: _changementStatut,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Cadre (-25%)',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    Radio(
                      value: 15,
                      groupValue: _valueStatut,
                      onChanged: _changementStatut,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Public (-15%)',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    Radio(
                      value: 45,
                      groupValue: _valueStatut,
                      onChanged: _changementStatut,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Libéral (-45%)',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    Radio(
                      value: 51,
                      groupValue: _valueStatut,
                      onChanged: _changementStatut,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Portage salarial (-51%)',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),



              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Radio(
                      value: 12,
                      groupValue: _valuePrime,
                      onChanged: _changementPrime,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        '12 mois',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                    Radio(
                      value: 13,
                      groupValue: _valuePrime,
                      onChanged: _changementPrime,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        '13 mois',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    Radio(
                      value: 14,
                      groupValue: _valuePrime,
                      onChanged: _changementPrime,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        '14 mois',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    Radio(
                      value: 15,
                      groupValue: _valuePrime,
                      onChanged: _changementPrime,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        '15 mois',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    Radio(
                      value: 16,
                      groupValue: _valuePrime,
                      onChanged: _changementPrime,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        '16 mois',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),

                  ],
                ),
              ),


              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SfSlider(
                  min: 0.0,
                  max: 100.0,
                  stepSize: 10,
                  value: _dureeTravail,
                  interval: 10,
                  showTicks: true,
                  showLabels: true,
                  enableTooltip: true,
                  minorTicksPerInterval: 0,
                  onChanged: (dynamic value) {
                    setState(() {
                      _dureeTravail = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SfSlider(
                  min: 0.0,
                  max: 43.0,
                  stepSize: 0.5,
                  value: _valuePrelevementSource,
                  showTicks: false,
                  showLabels: true,
                  enableTooltip: true,
                  minorTicksPerInterval: 0,
                  onChanged: (dynamic value) {
                    setState(() {
                      _valuePrelevementSource = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: nameController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Mensuel net après impôts',
                          ),
                          maxLines: 1,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: nameController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Annuel net après impôts',
                          ),
                          maxLines: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
       ] ),
      );







  void onHBChange() {
    setState(() {
      double? HB = double.tryParse(HBController.text);

      double  HN = calculSalaire(HB!, true, _valueStatut.toDouble(), _dureeTravail);

       double MB = HB!*152;
       double AB = HB!*2128;

      MBController.text = MB.toString();
      ABController.text = AB.toString();
      HNController.text = HN.toString();

    });
  }


  double calculSalaire(double salaire, bool isHoraire, double statut, double duree){

    // if(!isBrut) {
    //   statut += 1;
    // }


    double res =  roundDouble(salaire * (1-statut/100), 2);
    return roundDouble(res * (duree/100), 2);

  }

  // double calculSalairePrelevement(){
  //
  //   return 0;
  // }


  double roundDouble(double value, int places){
    num mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

}
//HORAIRE NET = HORAIRE BRUT -statut% (22 pour non cadre)