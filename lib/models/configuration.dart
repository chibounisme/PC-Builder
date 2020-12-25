import 'package:flutter/cupertino.dart';
import 'package:pcbuilder/models/equipment.dart';

class Configuration {
  Equipment _graphicscard;
  Equipment _cpu;
  Equipment _motherboard;
  Equipment _ssd;
  Equipment _ram;
  Equipment _psu;
  Equipment _case;
  Configuration();

  Configuration.initconfiguration(
      graphicscard, cpu, motherboard, ram, ssd, psu, hcase) {
    this._graphicscard = graphicscard;
    this._cpu = cpu;
    this._motherboard = motherboard;
    this._ssd = ssd;
    this._ram = ram;
    this._psu = psu;
    this._case = hcase;
  }
  // String toString() {
  //   return "Hello guys,Check out my new set up made with the App Pc-Builder:/n";
  // }
}
