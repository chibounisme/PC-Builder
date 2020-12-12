class Equipment {
  String img_url;
  double price;
  String name;
  String description;
  String type;
  String brand;

  Equipment(
      {this.img_url,
      this.price,
      this.name,
      this.description,
      this.type,
      this.brand});

  @override
  String toString() {
    return "$name -- $type -- $price";
  }
}
