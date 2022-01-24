class Product {
  String name;
  String type;
  String cost;
  String image;
  String category;
  bool isLike = false;

  Product({
    required this.name,
    required this.type,
    required this.cost,
    required this.image,
    required this.category,
  });
}

class ProductList {
  static List<Product> products = [
    Product(name: "PDP car", type: "Electric", cost: "100", image: "assets/images/img_0.png", category: "Red"),
    Product(name: "PDP car", type: "Electric", cost: "100", image: "assets/images/img_1.png", category: "Blue"),
    Product(name: "PDP car", type: "Electric", cost: "100", image: "assets/images/img_2.png", category: "Yellow"),
    Product(name: "PDP car", type: "Electric", cost: "100", image: "assets/images/img_3.png", category: "Grey"),
    Product(name: "PDP car", type: "Electric", cost: "100", image: "assets/images/img_4.png", category: "Green"),
  ];

  static List<Product> favProducts = [];
}
