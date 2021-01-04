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

  Equipment get graphicsCard => _graphicscard;
  Equipment get cpu => _cpu;
  Equipment get motherboard => _motherboard;
  Equipment get ssd => _ssd;
  Equipment get ram => _ram;
  Equipment get psu => _psu;
  Equipment get hcase => _case;

  set graphicsCard(Equipment graphicsCard) {
    _graphicscard = graphicsCard;
  }

  set cpu(Equipment cpu) {
    _cpu = cpu;
  }

  set motherboard(Equipment motherboard) {
    _motherboard = motherboard;
  }

  set ssd(Equipment ssd) {
    _ssd = ssd;
  }

  set ram(Equipment ram) {
    _ram = ram;
  }

  set psu(Equipment psu) {
    _psu = psu;
  }

  set hcase(Equipment hcase) {
    _case = hcase;
  }
}
