class Equipment {
  String imgUrl;
  double price;
  String name;
  String description;
  String type;
  String brand;

  Equipment(
      {this.imgUrl,
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
