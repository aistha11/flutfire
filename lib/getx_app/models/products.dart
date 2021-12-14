import 'dart:convert';

class Products {
  final int id;
  final String name;
  final String img;
  Products({
    required this.id,
    required this.name,
    required this.img,
  });

  Products copyWith({
    int? id,
    String? name,
    String? img,
  }) {
    return Products(
      id: id ?? this.id,
      name: name ?? this.name,
      img: img ?? this.img,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'img': img,
    };
  }

  factory Products.fromMap(Map<String, dynamic> map) {
    return Products(
      id: map['id'],
      name: map['name'],
      img: map['img'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Products.fromJson(String source) => Products.fromMap(json.decode(source));

  @override
  String toString() => 'Products(id: $id, name: $name, img: $img)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Products &&
      other.id == id &&
      other.name == name &&
      other.img == img;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ img.hashCode;
}
