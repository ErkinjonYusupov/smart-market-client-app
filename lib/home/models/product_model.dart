class ProductModel {
  int id;
  int categoryId;
  String title;
  String barcode;
  String category;
  int price;
  String unit;

  ProductModel(
      {required this.id,
      required this.barcode,
      required this.category,
      required this.categoryId,
      required this.price,
      required this.title,
      required this.unit});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        id: json['id'],
        barcode: json['barcode'],
        category: json['category'],
        categoryId: json['categoryId'],
        price: json['price'],
        title: json['title'],
        unit: json['unit']);
  }

   // Map uchun to‘g‘ri formatni olish uchun toDictionary metodi
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'categoryId': categoryId,
      'category': category,
      'unit': unit,
      'barcode': barcode,
    };
  }
}
List<ProductModel> productsFromJson(List list){
  return List<ProductModel>.from(list.map((el)=>ProductModel.fromJson(el)));
}