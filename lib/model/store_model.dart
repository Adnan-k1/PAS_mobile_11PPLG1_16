// ...existing code...
import 'dart:convert';

List<Storemodel> storemodelFromJson(String str) => List<Storemodel>.from(json.decode(str).map((x) => Storemodel.fromJson(x)));

String storemodelToJson(List<Storemodel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Storemodel {
    int id;
    String title;
    double price;
    String description;
    Category category;
    String image;
    Rating rating;

    Storemodel({
        required this.id,
        required this.title,
        required this.price,
        required this.description,
        required this.category,
        required this.image,
        required this.rating,
    });

    factory Storemodel.fromJson(Map<String, dynamic> json) => Storemodel(
        id: json["id"] is int ? json["id"] : int.parse(json["id"].toString()),
        title: json["title"]?.toString() ?? '',
        price: (json["price"] as num?)?.toDouble() ?? 0.0,
        description: json["description"]?.toString() ?? '',
        category: categoryValues.map[json["category"]] ?? Category.ELECTRONICS,
        image: json["image"]?.toString() ?? '',
        rating: json["rating"] != null ? Rating.fromJson(json["rating"]) : Rating(rate: 0.0, count: 0),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "description": description,
        "category": categoryValues.reverse[category],
        "image": image,
        "rating": rating.toJson(),
    };

    // -----------------------
    // DB mapping helpers
    // -----------------------
    Map<String, dynamic> toMap() {
      return {
        'id': id,
        'title': title,
        'price': price,
        'description': description,
        'category': categoryValues.reverse[category],
        'image': image,
        'rate': rating.rate,
        'count': rating.count,
      };
    }

    factory Storemodel.fromMap(Map<String, dynamic> map) {
      return Storemodel(
        id: map['id'] is int ? map['id'] : int.parse(map['id'].toString()),
        title: map['title']?.toString() ?? '',
        price: (map['price'] as num?)?.toDouble() ?? 0.0,
        description: map['description']?.toString() ?? '',
        category: categoryValues.map[map['category']] ?? Category.ELECTRONICS,
        image: map['image']?.toString() ?? '',
        rating: Rating(
          rate: (map['rate'] as num?)?.toDouble() ?? 0.0,
          count: (map['count'] as num?)?.toInt() ?? 0,
        ),
      );
    }
}
// ...existing code...
enum Category {
    ELECTRONICS,
    JEWELERY,
    MEN_S_CLOTHING,
    WOMEN_S_CLOTHING
}

final categoryValues = EnumValues({
    "electronics": Category.ELECTRONICS,
    "jewelery": Category.JEWELERY,
    "men's clothing": Category.MEN_S_CLOTHING,
    "women's clothing": Category.WOMEN_S_CLOTHING
});

class Rating {
    double rate;
    int count;

    Rating({
        required this.rate,
        required this.count,
    });

    factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        rate: (json["rate"] as num?)?.toDouble() ?? 0.0,
        count: json["count"] is int ? json["count"] : (json["count"] as num?)?.toInt() ?? 0,
    );

    Map<String, dynamic> toJson() => {
        "rate": rate,
        "count": count,
    };
}

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}