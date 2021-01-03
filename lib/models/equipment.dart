class Equipment {
  String imgUrl;
  double price;
  String name;
  String description;
  String type;
  String brand;
  String id;

  Equipment(
      {this.imgUrl,
      this.price,
      this.name,
      this.description,
      this.type,
      this.brand,
      this.id});

  @override
  String toString() {
    return "$id -- $name -- $type -- $price";
  }
}
