class Product {
  final String id;
  final String title;
  final double price;
  final int quantity;
  final String imagePath;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
    required this.imagePath,
  });



  String get _id=>id;
  String get _title=>title;
  double get _price=>price;
  String get _imagePath=>imagePath;
  


}
