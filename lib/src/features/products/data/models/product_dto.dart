import 'package:hacker_kernel_assignment/src/features/products/domain/entities/product.dart';

class ProductDto extends Product {
  const ProductDto({
    required super.image,
    required super.name,
    required super.price,
    required super.id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'image': image,
      'name': name,
      'price': price,
    };
  }

  factory ProductDto.fromMap(Map<String, dynamic> map) {
    return ProductDto(
      id: map['id'] as String,
      image: map['image'] as String,
      name: map['name'] as String,
      price: map['price'] as double,
    );
  }
}
