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

  final MNIPController = TextEditingController();
  final ANIPController = TextEditingController();


  double _dureeTravail = 100;
  double _valuePrelevementSource = 0;

  int _valueStatut = 22;
  int _valuePrime = 12;

  void _changementStatut(int? value) {
    setState(() {
      _valueStatut = value ?? 0;
      if(HBController.text.isNotEmpty){
        double? HB = double.tryParse(HBController.text);
        double? MB = double.tryParse(MBController.text);
        double? AB = double.tryParse(ABController.text);

        double  HN = calculNet(HB!, true, _valueStatut.toDouble());
        double  MN = calculNet(MB!, true, _valueStatut.toDouble());
        double AN = calculNet(AB!, true, _valueStatut.toDouble());

        updateUI(-1,-1,-1,HN,MN,AN);


      }


    });
  }

  void _changementPrime(int? value) {
    setState(() {
      _valuePrime = value ?? 0;
      if (MBController.text.isNotEmpty) {
        double? MB = double.tryParse(MBController.text);
        double AB = MB! * _valuePrime;
        double AN = calculNet(AB!, true, _valueStatut.toDouble());
        updateUI(-1, -1, AB, -1, -1, AN);
      }
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
                              keyboardType: TextInputType.number,
                              validator: (amount) => amount != null && double.tryParse(amount) == null
                                  ? 'Saisir un nombre valide'
                                  : null,
                              onChanged: (text){
                                onMBChange();
                              },
                            )
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: ABController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Annuel brut',
                              ),
                              keyboardType: TextInputType.number,
                              validator: (amount) => amount != null && double.tryParse(amount) == null
                                  ? 'Saisir un nombre valide'
                                  : null,
                              onChanged: (text){
                                onABChange();
                              },
                            )
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
                            keyboardType: TextInputType.number,
                            validator: (amount) => amount != null && double.tryParse(amount) == null
                                ? 'Saisir un nombre valide'
                                : null,
                            onChanged: (text){
                              onHNChange();
                            },
                          )
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: MNController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Mensuel net',
                            ),
                            keyboardType: TextInputType.number,
                            validator: (amount) => amount != null && double.tryParse(amount) == null
                                ? 'Saisir un nombre valide'
                                : null,
                            onChanged: (text){
                              onMNChange();
                            },
                          )
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: ANController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Annuel net',
                            ),
                            keyboardType: TextInputType.number,
                            validator: (amount) => amount != null && double.tryParse(amount) == null
                                ? 'Saisir un nombre valide'
                                : null,
                            onChanged: (text){
                              onANChange();
                            },
                          )
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Statut : ',
                      style: TextStyle(fontSize: 16.0),
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



              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Nombre de mois de prime conventionnelle : ',
                      style: TextStyle(fontSize: 16.0),
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

              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Temps de travail : ',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                ],
              ),




              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SfSlider(
                  min: 10.0,
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


                      if(HBController.text.isNotEmpty) {
                        double? HB = double.tryParse(HBController.text);

                        double MB = HB! * 152 * (_dureeTravail / 100);
                        double MN =
                            calculNet(MB!, true, _valueStatut.toDouble());

                        double AB = MB! * _valuePrime;
                        double AN =
                            calculNet(AB!, true, _valueStatut.toDouble());

                        updateUI(-1, MB, AB, -1, MN, AN);
                      }
                    });
                  },
                ),
              ),


              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Taux de prélevement a la source : ',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                ],
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
                          controller: MNIPController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Mensuel net après impôts',
                          ),
                          keyboardType: TextInputType.number,
                          validator: (amount) => amount != null && double.tryParse(amount) == null
                              ? 'Saisir un nombre valide'
                              : null,
                          onChanged: (text){
                            onMNIPChange();
                          },
                        )
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: ANIPController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Annuel net après impôts',
                          ),
                          keyboardType: TextInputType.number,
                          validator: (amount) => amount != null && double.tryParse(amount) == null
                              ? 'Saisir un nombre valide'
                              : null,
                          onChanged: (text){
                            onANIPChange();
                          },
                        )
                      ),
                    ),
                  ],
                ),
              ),

              Row(
                children: [
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: OutlinedButton(
                          onPressed: () {

                            HBController.clear();
                            MBController.clear();
                            ABController.clear();
                            HNController.clear();
                            MNController.clear();
                            ANController.clear();
                            MNIPController.clear();
                            ANIPController.clear();

                          },
                          child: Text('Réinitialiser'),
                        )
                    ),
                  ),
                ],
              ),



            ],
          ),
       ] ),
      );







  void onHBChange() {
    setState(() {
      double? HB = double.tryParse(HBController.text);

      double  HN = calculNet(HB!, true, _valueStatut.toDouble());

      double MB = HB!* 152 * (_dureeTravail/100);
      double  MN = calculNet(MB!, true, _valueStatut.toDouble());

      double AB = MB!*_valuePrime;
      double AN = calculNet(AB!, true, _valueStatut.toDouble());

      updateUI(-1,MB,AB,HN,MN,AN);

    });
  }


  double calculNet(double salaire, bool isBrut, double statut){

    if(!isBrut) {
      return  roundDouble(salaire / (1-statut/100), 2);
    }

    return  roundDouble(salaire * (1-statut/100), 2);

  }

  // double calculSalairePrelevement(){
  //
  //   return 0;
  // }


  double roundDouble(double value, int places){
    num mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  void updateUI(double hb, double mb, double ab, double hn, double mn, double an) {
    if(!hb.isNegative) {
      hb = roundDouble(hb,2);
      HBController.text = hb.toString();
    }
    if(!mb.isNegative) {
      mb = roundDouble(mb,2);
      MBController.text = mb.toString();
    }
    if(!ab.isNegative) {
      ab = roundDouble(ab,2);
      ABController.text = ab.toString();
    }
    if(!hn.isNegative) {
      hn = roundDouble(hn,2);
      HNController.text = hn.toString();
    }
    if(!mn.isNegative) {
      mn = roundDouble(mn,2);
      MNController.text = mn.toString();
    }
    if(!an.isNegative) {
      an = roundDouble(an,2);
      ANController.text = an.toString();
    }
  }

  void onMBChange() {
    setState(() {
      double? MB = double.tryParse(MBController.text);

      double HB = MB!/ 152 * (_dureeTravail/100);

      double  HN = calculNet(HB!, true, _valueStatut.toDouble());
      double  MN = calculNet(MB!, true, _valueStatut.toDouble());

      double AB = MB!*_valuePrime;
      double AN = calculNet(AB!, true, _valueStatut.toDouble());

      updateUI(HB,-1,AB,HN,MN,AN);

    });
  }
  void onABChange() {
    setState(() {
      double? AB = double.tryParse(ABController.text);

      double MB = AB!/_valuePrime;
      double HB = MB!/ 152 * (_dureeTravail/100);

      double  HN = calculNet(HB!, true, _valueStatut.toDouble());
      double  MN = calculNet(MB!, true, _valueStatut.toDouble());
      double AN = calculNet(AB!, true, _valueStatut.toDouble());

      updateUI(HB,MB,-1,HN,MN,AN);

    });
  }
  void onHNChange() {
    setState(() {
      double? HN = double.tryParse(HNController.text);
      double  HB = calculNet(HN!, false, _valueStatut.toDouble());

      double MB = HB!* 152 * (_dureeTravail/100);
      double AB = MB!*_valuePrime;

      double  MN = calculNet(MB!, true, _valueStatut.toDouble());
      double AN = calculNet(AB!, true, _valueStatut.toDouble());

      updateUI(HB,MB,AB,-1,MN,AN);

    });
  }
  void onMNChange() {
    setState(() {
      double? MN = double.tryParse(MNController.text);
      double  MB = calculNet(MN!, false, _valueStatut.toDouble());

      double HB = MB!/ 152 * (_dureeTravail/100);
      double AB = MB!*_valuePrime;

      double  HN = calculNet(HB!, true, _valueStatut.toDouble());
      double AN = calculNet(AB!, true, _valueStatut.toDouble());

      updateUI(HB,MB,AB,HN,-1,AN);

    });
  }
  void onANChange() {
    setState(() {
      double? AN = double.tryParse(ANController.text);

      double MN = AN!/_valuePrime;
      double HN = MN!/ 152 * (_dureeTravail/100);

      double  HB = calculNet(HN!, false, _valueStatut.toDouble());
      double  MB = calculNet(MN!, false, _valueStatut.toDouble());
      double AB = calculNet(AN!, false, _valueStatut.toDouble());

      updateUI(HB,MB,AB,HN,MN,-1);

    });
  }
  void onANIPChange() {}
  void onMNIPChange() {}

}
//HORAIRE NET = HORAIRE BRUT -statut% (22 pour non cadre)
//button reset