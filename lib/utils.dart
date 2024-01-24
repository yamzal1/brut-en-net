import 'dart:math';

double conversionBrutNet(double salaire, bool isBrut, double statut) {
  if (!isBrut) {
    return roundDouble(salaire / (1 - statut / 100), 2);
  }
  return roundDouble(salaire * (1 - statut / 100), 2);
}

double roundDouble(double value, int places) {
  num mod = pow(10.0, places);
  return ((value * mod).round().toDouble() / mod);
}