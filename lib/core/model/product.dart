class ProductModel {
  final  String?  imageCard;
  final  String? id;
  final  String?  imageDetail;
  final  String? name;
  final  String? description;
  final  double? price;
  final  double? rate;
  final  String? specialItem;
  final  String? category;
  final  int? kcal;
  final  String? time;

  
  ProductModel({
    this.imageCard,
    this.id,
    this.imageDetail,
    this.name,
    this.description,
    this.price,
    this.rate,
    this.specialItem,
    this.category,
    this.kcal,
    this.time,
  });
  
  
  factory ProductModel.fromJson(Map<String,dynamic> json){
    return ProductModel(
      id: json['id'] ?? "",
      imageCard: json['imageCard'] ?? "",
      imageDetail: json['imageDetail'] ?? "",
      name: json['name'] ?? "",
      description: json['description'] ?? "",
      price: json['price']?.toDouble() ?? 0.0,
      rate: json['rate']?.toDouble() ?? 0.0,
      specialItem: json['specialItem'] ?? "",
      category: json['category'] ?? "",
      kcal: json['kcal']?.toInt() ?? 0,
      time: json['time'] ?? "",
    );
  }
  
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imageCard': imageCard,
      'imageDetail': imageDetail,
      'name': name,
      'description': description,
      'price': price,
      'rate': rate,
      'specialItem': specialItem,
      'category': category,
      'kcal': kcal,
      'time': time,
    };
  }
}
