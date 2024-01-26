import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String image;
  final String name;
  final double price;

  const Product({
    required this.id,
    required this.image,
    required this.name,
    required this.price,
  });

  @override
  List<Object?> get props => [
        image,
        name,
        price,
        id,
      ];

  Product copyWith({
    String? id,
    String? image,
    String? name,
    double? price,
  }) {
    return Product(
      id: id ?? this.id,
      image: image ?? this.image,
      name: name ?? this.name,
      price: price ?? this.price,
    );
  }
}
