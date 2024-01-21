import 'dart:math';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../components/text_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final nameController = TextEditingController();
  final horaireBrutController = TextEditingController();
  final mensuelBrutController = TextEditingController();
  final annuelBrutController = TextEditingController();

  final horaireNetController = TextEditingController();
  final mensuelNetController = TextEditingController();
  final annuelNetController = TextEditingController();

  final mensuelNetApresImpotsController = TextEditingController();
  final annuelNetApresImpotsController = TextEditingController();

  double tempsTravail = 100;
  double tauxPrelevementSource = 0;

  int cotisationsStatut = 22;
  int moisPrimeConventionnelle = 12;

  void changementStatut(int? value) {
    setState(() {
      cotisationsStatut = value ?? 0;
      if (horaireBrutController.text.isNotEmpty) {
        double? horaireBrut = double.tryParse(horaireBrutController.text);
        double? mensuelBrut = double.tryParse(mensuelBrutController.text);
        double? annuelBrut = double.tryParse(annuelBrutController.text);

        double horaireNet =
            calculNet(horaireBrut!, true, cotisationsStatut.toDouble());
        double mensuelNet =
            calculNet(mensuelBrut!, true, cotisationsStatut.toDouble());
        double annuelNet =
            calculNet(annuelBrut!, true, cotisationsStatut.toDouble());

        updateUI(-1, -1, -1, horaireNet, mensuelNet, annuelNet, -1, -1);
      }
    });
  }

  void changementPrime(int? value) {
    setState(() {
      moisPrimeConventionnelle = value ?? 0;
      if (mensuelBrutController.text.isNotEmpty) {
        double? mensuelBrut = double.tryParse(mensuelBrutController.text);
        double annuelBrut = mensuelBrut! * moisPrimeConventionnelle;
        double annuelNet =
            calculNet(annuelBrut, true, cotisationsStatut.toDouble());
        updateUI(-1, -1, annuelBrut, -1, -1, annuelNet, -1, -1);
      }
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Brut net'),
          centerTitle: true,
        ),
        body: Flex(direction: Axis.vertical, children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //Center Column contents vertically,

            children: [
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          CustomTextField(controller: horaireBrutController, label: 'Horaire brut', onTextChanged: onHoraireBrutChange),
                          CustomTextField(controller: mensuelBrutController, label: 'Mensuel brut', onTextChanged: onMensuelBrutChange),
                          CustomTextField(controller: annuelBrutController, label: 'Annuel brut', onTextChanged: onAnnuelBrutChange),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        CustomTextField(controller: horaireNetController, label: 'Horaire net', onTextChanged: onHoraireNetChange),
                        CustomTextField(controller: mensuelNetController, label: 'Mensuel net', onTextChanged: onMensuelNetChange),
                        CustomTextField(controller: annuelNetController, label: 'Annuel net', onTextChanged: onAnnuelNetChange),
                      ],
                    ),
                  ),
                ],
              ),
              const Row(
                children: [
                  Padding(
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
              const Row(
                children: [
                  Padding(
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
              const Row(
                children: [
                  Padding(
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

                      if (horaireBrutController.text.isNotEmpty) {
                        double? horaireBrut =
                            double.tryParse(horaireBrutController.text);

                        double mensuelBrut =
                            horaireBrut! * 152 * (tempsTravail / 100);
                        double mensuelNet = calculNet(
                            mensuelBrut, true, cotisationsStatut.toDouble());

                        double annuelBrut =
                            mensuelBrut * moisPrimeConventionnelle;
                        double annuelNet = calculNet(
                            annuelBrut, true, cotisationsStatut.toDouble());

                        updateUI(-1, mensuelBrut, annuelBrut, -1, mensuelNet,
                            annuelNet, -1, -1);
                      }
                    });
                  },
                ),
              ),
              const Row(
                children: [
                  Padding(
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
                      if (mensuelNetController.text.isNotEmpty) {
                        double? mensuelNet =
                            double.tryParse(mensuelNetController.text);
                        double mensuelNetApresImpots =
                            mensuelNet! * (1 - tauxPrelevementSource / 100);
                        double? annuelNet =
                            double.tryParse(annuelNetController.text);
                        double annuelNetApresImpots =
                            annuelNet! * (1 - tauxPrelevementSource / 100);
                        updateUI(-1, -1, -1, -1, -1, -1, mensuelNetApresImpots,
                            annuelNetApresImpots);
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
                      child:
                      CustomTextField(controller: mensuelNetApresImpotsController, label: 'Mensuel net après impôts', onTextChanged: onMensuelNetApresImpotsChange),
                    ),
                    Expanded(
                      child:
                      CustomTextField(controller: annuelNetApresImpotsController, label: 'Annuel net après impôts', onTextChanged: onAnnuelNetApresImpotsChange),
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
                            horaireBrutController.clear();
                            mensuelBrutController.clear();
                            annuelBrutController.clear();
                            horaireNetController.clear();
                            mensuelNetController.clear();
                            annuelNetController.clear();
                            mensuelNetApresImpotsController.clear();
                            annuelNetApresImpotsController.clear();
                          },
                          child: const Text('Réinitialiser'),
                        )),
                  ),
                ],
              ),
            ],
          ),
        ]),
      );

  void onHoraireBrutChange(String value) {
    setState(() {
      double? horaireBrut = double.tryParse(horaireBrutController.text);
      double horaireNet =
          calculNet(horaireBrut!, true, cotisationsStatut.toDouble());
      double mensuelBrut = horaireBrut * 152 * (tempsTravail / 100);
      double mensuelNet =
          calculNet(mensuelBrut, true, cotisationsStatut.toDouble());
      double annuelBrut = mensuelBrut * moisPrimeConventionnelle;
      double annuelNet =
          calculNet(annuelBrut, true, cotisationsStatut.toDouble());

      updateUI(-1, mensuelBrut, annuelBrut, horaireNet, mensuelNet, annuelNet,
          -1, -1);
    });
  }

  double calculNet(double salaire, bool isBrut, double statut) {
    if (!isBrut) {
      return roundDouble(salaire / (1 - statut / 100), 2);
    }
    return roundDouble(salaire * (1 - statut / 100), 2);
  }

  double roundDouble(double value, int places) {
    num mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  void updateUI(double hb, double mb, double ab, double hn, double mn,
      double an, double mnip, double anip) {
    if (!hb.isNegative) {
      hb = roundDouble(hb, 2);
      horaireBrutController.text = hb.toString();
    }
    if (!mb.isNegative) {
      mb = roundDouble(mb, 2);
      mensuelBrutController.text = mb.toString();
    }
    if (!ab.isNegative) {
      ab = roundDouble(ab, 2);
      annuelBrutController.text = ab.toString();
    }
    if (!hn.isNegative) {
      hn = roundDouble(hn, 2);
      horaireNetController.text = hn.toString();
    }
    if (!mn.isNegative) {
      mn = roundDouble(mn, 2);
      mensuelNetController.text = mn.toString();
    }
    if (!an.isNegative) {
      an = roundDouble(an, 2);
      annuelNetController.text = an.toString();
    }
    if (!anip.isNegative) {
      anip = roundDouble(an, 2);
      annuelNetApresImpotsController.text = anip.toString();
    }
    if (!mnip.isNegative) {
      mnip = roundDouble(mnip, 2);
      mensuelNetApresImpotsController.text = mnip.toString();
    }
  }

  void onMensuelBrutChange(String value) {
    setState(() {
      double? mensuelBrut = double.tryParse(mensuelBrutController.text);

      double horaireBrut = mensuelBrut! / 152 * (tempsTravail / 100);

      double horaireNet =
          calculNet(horaireBrut, true, cotisationsStatut.toDouble());
      double mensuelNet =
          calculNet(mensuelBrut, true, cotisationsStatut.toDouble());

      double annuelBrut = mensuelBrut * moisPrimeConventionnelle;
      double annuelNet =
          calculNet(annuelBrut, true, cotisationsStatut.toDouble());

      updateUI(horaireBrut, -1, annuelBrut, horaireNet, mensuelNet, annuelNet,
          -1, -1);
    });
  }

  void onAnnuelBrutChange(String value) {
    setState(() {
      double? annuelBrut = double.tryParse(annuelBrutController.text);

      double mensuelBrut = annuelBrut! / moisPrimeConventionnelle;
      double horaireBrut = mensuelBrut / 152 * (tempsTravail / 100);

      double horaireNet =
          calculNet(horaireBrut, true, cotisationsStatut.toDouble());
      double mensuelNet =
          calculNet(mensuelBrut, true, cotisationsStatut.toDouble());
      double annuelNet =
          calculNet(annuelBrut, true, cotisationsStatut.toDouble());

      updateUI(horaireBrut, mensuelBrut, -1, horaireNet, mensuelNet, annuelNet,
          -1, -1);
    });
  }

  void onHoraireNetChange(String value) {
    setState(() {
      double? horaireNet = double.tryParse(horaireNetController.text);
      double horaireBrut =
          calculNet(horaireNet!, false, cotisationsStatut.toDouble());

      double mensuelBrut = horaireBrut * 152 * (tempsTravail / 100);
      double annuelBrut = mensuelBrut * moisPrimeConventionnelle;

      double mensuelNet =
          calculNet(mensuelBrut, true, cotisationsStatut.toDouble());
      double annuelNet =
          calculNet(annuelBrut, true, cotisationsStatut.toDouble());

      updateUI(horaireBrut, mensuelBrut, annuelBrut, -1, mensuelNet, annuelNet,
          -1, -1);
    });
  }

  void onMensuelNetChange(String value) {
    setState(() {
      double? mensuelNet = double.tryParse(mensuelNetController.text);
      double mensuelBrut =
          calculNet(mensuelNet!, false, cotisationsStatut.toDouble());

      double horaireBrut = mensuelBrut / 152 * (tempsTravail / 100);
      double annuelBrut = mensuelBrut * moisPrimeConventionnelle;

      double horaireNet =
          calculNet(horaireBrut, true, cotisationsStatut.toDouble());
      double annuelNet =
          calculNet(annuelBrut, true, cotisationsStatut.toDouble());

      updateUI(horaireBrut, mensuelBrut, annuelBrut, horaireNet, -1, annuelNet,
          -1, -1);
    });
  }

  void onAnnuelNetChange(String value) {
    setState(() {
      double? annuelNet = double.tryParse(annuelNetController.text);

      double mensuelNet = annuelNet! / moisPrimeConventionnelle;
      double horaireNet = mensuelNet / 152 * (tempsTravail / 100);

      double horaireBrut =
          calculNet(horaireNet, false, cotisationsStatut.toDouble());
      double mensuelBrut =
          calculNet(mensuelNet, false, cotisationsStatut.toDouble());
      double annuelBrut =
          calculNet(annuelNet, false, cotisationsStatut.toDouble());

      updateUI(horaireBrut, mensuelBrut, annuelBrut, horaireNet, mensuelNet, -1,
          -1, -1);
    });
  }

  void onAnnuelNetApresImpotsChange(String value) {}

  void onMensuelNetApresImpotsChange(String value) {}
}
