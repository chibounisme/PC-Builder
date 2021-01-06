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

  // ignore: unnecessary_getters_setters
  Equipment get graphicsCard => _graphicscard;
  // ignore: unnecessary_getters_setters
  Equipment get cpu => _cpu;
  // ignore: unnecessary_getters_setters
  Equipment get motherboard => _motherboard;
  // ignore: unnecessary_getters_setters
  Equipment get ssd => _ssd;
  // ignore: unnecessary_getters_setters
  Equipment get ram => _ram;
  // ignore: unnecessary_getters_setters
  Equipment get psu => _psu;
  // ignore: unnecessary_getters_setters
  Equipment get hcase => _case;

  // ignore: unnecessary_getters_setters
  set graphicsCard(Equipment graphicsCard) {
    _graphicscard = graphicsCard;
  }

  // ignore: unnecessary_getters_setters
  set cpu(Equipment cpu) {
    _cpu = cpu;
  }

  // ignore: unnecessary_getters_setters
  set motherboard(Equipment motherboard) {
    _motherboard = motherboard;
  }

  // ignore: unnecessary_getters_setters
  set ssd(Equipment ssd) {
    _ssd = ssd;
  }

  // ignore: unnecessary_getters_setters
  set ram(Equipment ram) {
    _ram = ram;
  }

  // ignore: unnecessary_getters_setters
  set psu(Equipment psu) {
    _psu = psu;
  }

  // ignore: unnecessary_getters_setters
  set hcase(Equipment hcase) {
    _case = hcase;
  }
}
