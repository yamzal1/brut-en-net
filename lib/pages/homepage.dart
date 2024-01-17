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
  final horaireBrut = TextEditingController();
  final mensuelBrut = TextEditingController();
  final annuelBrut = TextEditingController();

  final horaireNet = TextEditingController();
  final mensuelNet = TextEditingController();
  final annuelNet = TextEditingController();

  final mensuelNetApresImpots = TextEditingController();
  final annuelNetApresImpots = TextEditingController();


  double tempsTravail = 100;
  double tauxPrelevementSource = 0;

  int cotisationsStatut = 22;
  int moisPrimeConventionnelle = 12;

  void changementStatut(int? value) {
    setState(() {
      cotisationsStatut = value ?? 0;
      if(horaireBrut.text.isNotEmpty){
        double? HB = double.tryParse(horaireBrut.text);
        double? MB = double.tryParse(mensuelBrut.text);
        double? AB = double.tryParse(annuelBrut.text);

        double  HN = calculNet(HB!, true, cotisationsStatut.toDouble());
        double  MN = calculNet(MB!, true, cotisationsStatut.toDouble());
        double AN = calculNet(AB!, true, cotisationsStatut.toDouble());

        updateUI(-1,-1,-1,HN,MN,AN, -1, -1);
      }
    });
  }

  void changementPrime(int? value) {
    setState(() {
      moisPrimeConventionnelle = value ?? 0;
      if (mensuelBrut.text.isNotEmpty) {
        double? MB = double.tryParse(mensuelBrut.text);
        double AB = MB! * moisPrimeConventionnelle;
        double AN = calculNet(AB, true, cotisationsStatut.toDouble());
        updateUI(-1, -1, AB, -1, -1, AN, -1, -1);
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
                              controller: horaireBrut,
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
                              controller: mensuelBrut,
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
                              controller: annuelBrut,
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
                            controller: horaireNet,
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
                            controller: mensuelNet,
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
                            controller: annuelNet,
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
                      groupValue: cotisationsStatut,
                      onChanged: changementStatut,
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
                      groupValue: cotisationsStatut,
                      onChanged: changementStatut,
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
                      groupValue: cotisationsStatut,
                      onChanged: changementStatut,
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
                      groupValue: cotisationsStatut,
                      onChanged: changementStatut,
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
                      groupValue: cotisationsStatut,
                      onChanged: changementStatut,
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
                      groupValue: moisPrimeConventionnelle,
                      onChanged: changementPrime,
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
                      groupValue: moisPrimeConventionnelle,
                      onChanged: changementPrime,
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
                      groupValue: moisPrimeConventionnelle,
                      onChanged: changementPrime,
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
                      groupValue: moisPrimeConventionnelle,
                      onChanged: changementPrime,
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
                      groupValue: moisPrimeConventionnelle,
                      onChanged: changementPrime,
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
                  value: tempsTravail,
                  interval: 10,
                  showTicks: true,
                  showLabels: true,
                  enableTooltip: true,
                  minorTicksPerInterval: 0,
                  onChanged: (dynamic value) {
                    setState(() {
                      tempsTravail = value;


                      if(horaireBrut.text.isNotEmpty) {
                        double? HB = double.tryParse(horaireBrut.text);

                        double MB = HB! * 152 * (tempsTravail / 100);
                        double MN =
                            calculNet(MB, true, cotisationsStatut.toDouble());

                        double AB = MB * moisPrimeConventionnelle;
                        double AN =
                            calculNet(AB, true, cotisationsStatut.toDouble());

                        updateUI(-1, MB, AB, -1, MN, AN, -1, -1);
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
                  value: tauxPrelevementSource,
                  showTicks: false,
                  showLabels: true,
                  enableTooltip: true,
                  minorTicksPerInterval: 0,
                  onChanged: (dynamic value) {
                    setState(() {
                      tauxPrelevementSource = value;
                      if(mensuelNet.text.isNotEmpty){

                        double? MN = double.tryParse(mensuelNet.text);
                        double MNIP = MN!*(1-tauxPrelevementSource/100);
                        double? AN = double.tryParse(annuelNet.text);
                        double ANIP = AN!*(1-tauxPrelevementSource/100);
                        updateUI(-1, -1, -1, -1, -1, -1, MNIP, ANIP);

                      }


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
                          controller: mensuelNetApresImpots,
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
                          controller: annuelNetApresImpots,
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

                            horaireBrut.clear();
                            mensuelBrut.clear();
                            annuelBrut.clear();
                            horaireNet.clear();
                            mensuelNet.clear();
                            annuelNet.clear();
                            mensuelNetApresImpots.clear();
                            annuelNetApresImpots.clear();

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
      double? HB = double.tryParse(horaireBrut.text);
      double  HN = calculNet(HB!, true, cotisationsStatut.toDouble());
      double MB = HB* 152 * (tempsTravail/100);
      double  MN = calculNet(MB, true, cotisationsStatut.toDouble());
      double AB = MB*moisPrimeConventionnelle;
      double AN = calculNet(AB, true, cotisationsStatut.toDouble());

      updateUI(-1,MB,AB,HN,MN,AN, -1, -1);

    });
  }


  double calculNet(double salaire, bool isBrut, double statut){
    if(!isBrut) {
      return  roundDouble(salaire / (1-statut/100), 2);
    }

    return  roundDouble(salaire * (1-statut/100), 2);

  }

  double roundDouble(double value, int places){
    num mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  void updateUI(double hb, double mb, double ab, double hn, double mn, double an, double mnip, double anip) {
    if(!hb.isNegative) {
      hb = roundDouble(hb,2);
      horaireBrut.text = hb.toString();
    }
    if(!mb.isNegative) {
      mb = roundDouble(mb,2);
      mensuelBrut.text = mb.toString();
    }
    if(!ab.isNegative) {
      ab = roundDouble(ab,2);
      annuelBrut.text = ab.toString();
    }
    if(!hn.isNegative) {
      hn = roundDouble(hn,2);
      horaireNet.text = hn.toString();
    }
    if(!mn.isNegative) {
      mn = roundDouble(mn,2);
      mensuelNet.text = mn.toString();
    }
    if(!an.isNegative) {
      an = roundDouble(an,2);
      annuelNet.text = an.toString();
    }
    if(!anip.isNegative) {
      anip = roundDouble(an,2);
      annuelNetApresImpots.text = anip.toString();
    }
    if(!mnip.isNegative) {
      mnip = roundDouble(mnip,2);
      mensuelNetApresImpots.text = mnip.toString();
    }
  }

  void onMBChange() {
    setState(() {
      double? MB = double.tryParse(mensuelBrut.text);

      double HB = MB!/ 152 * (tempsTravail/100);

      double  HN = calculNet(HB, true, cotisationsStatut.toDouble());
      double  MN = calculNet(MB, true, cotisationsStatut.toDouble());

      double AB = MB*moisPrimeConventionnelle;
      double AN = calculNet(AB, true, cotisationsStatut.toDouble());

      updateUI(HB,-1,AB,HN,MN,AN, -1, -1);

    });
  }
  void onABChange() {
    setState(() {
      double? AB = double.tryParse(annuelBrut.text);

      double MB = AB!/moisPrimeConventionnelle;
      double HB = MB/ 152 * (tempsTravail/100);

      double  HN = calculNet(HB, true, cotisationsStatut.toDouble());
      double  MN = calculNet(MB, true, cotisationsStatut.toDouble());
      double AN = calculNet(AB, true, cotisationsStatut.toDouble());

      updateUI(HB,MB,-1,HN,MN,AN, -1, -1);

    });
  }
  void onHNChange() {
    setState(() {
      double? HN = double.tryParse(horaireNet.text);
      double  HB = calculNet(HN!, false, cotisationsStatut.toDouble());

      double MB = HB* 152 * (tempsTravail/100);
      double AB = MB*moisPrimeConventionnelle;

      double  MN = calculNet(MB, true, cotisationsStatut.toDouble());
      double AN = calculNet(AB, true, cotisationsStatut.toDouble());

      updateUI(HB,MB,AB,-1,MN,AN, -1, -1);

    });
  }
  void onMNChange() {
    setState(() {
      double? MN = double.tryParse(mensuelNet.text);
      double  MB = calculNet(MN!, false, cotisationsStatut.toDouble());

      double HB = MB/ 152 * (tempsTravail/100);
      double AB = MB*moisPrimeConventionnelle;

      double  HN = calculNet(HB, true, cotisationsStatut.toDouble());
      double AN = calculNet(AB, true, cotisationsStatut.toDouble());

      updateUI(HB,MB,AB,HN,-1,AN, -1, -1);

    });
  }
  void onANChange() {
    setState(() {
      double? AN = double.tryParse(annuelNet.text);

      double MN = AN!/moisPrimeConventionnelle;
      double HN = MN/ 152 * (tempsTravail/100);

      double  HB = calculNet(HN, false, cotisationsStatut.toDouble());
      double  MB = calculNet(MN, false, cotisationsStatut.toDouble());
      double AB = calculNet(AN, false, cotisationsStatut.toDouble());

      updateUI(HB,MB,AB,HN,MN,-1, -1, -1);

    });
  }
  void onANIPChange() {}
  void onMNIPChange() {}

}
