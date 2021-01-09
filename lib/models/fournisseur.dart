class Fournisseur {
  String name;
  String subtitle;
  List<dynamic> boutiques;
  Fournisseur(name, subtitle, boutiques) {
    this.name = name;
    this.subtitle = subtitle;
    this.boutiques = boutiques;
  }

  String toString() => "$name - $subtitle";

  getTitle() => name;
}

class Boutique {
  double lat;
  double long;
  String telephone;
  String adresse;
  Boutique({lat, long, telephone, adresse});
}
