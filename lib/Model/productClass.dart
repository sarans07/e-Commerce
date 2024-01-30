

class Product {
  int? id;
  String? title;
  double? price;
  String? description;
  String? category;
  String? image;
  //Rating? rating;


  Product({this.id,this.title,this.price,this.description,this.category,this.image});

  Product.fromJson(Map<String, dynamic> json) {
    print(json);
    id = json['id'] ?? 0;
    title = json['title'] ?? "";
    price = double.parse(json['price'].toString());
    description = json['description'] ?? "";
    category = json['category'] ?? "";
    image = json['image'] ?? "";
    //rating = json['rating'] != null ? Rating.fromJson(json['rating']) : null;

  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      //'price': price,
      'description': description,
      'category': category,
      'image': image,
     // 'rating': rating?.toJson(), // Convert Rating object to JSON
          };
  }
}

class Rating {
  String? rate;
  String? count;

  Rating({this.rate, this.count});

  Rating.fromJson(Map<String, dynamic> json) {
    rate = json['rate'] ?? '';
    count = json['count'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'rate': rate,
      'count': count,
    };
  }
}
