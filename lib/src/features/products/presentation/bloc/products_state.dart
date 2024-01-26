part of 'products_bloc.dart';

enum ProductStateStatus { initial, loading, success, failure }

class ProductState extends Equatable {
  final ProductStateStatus status;
  final List<Product?> products;
  final Failure? failure;

  const ProductState({
    required this.status,
    this.products = const [],
    this.failure,
  });

  ProductState copyWith({
    ProductStateStatus? status,
    List<Product?>? products,
    Failure? failure,
  }) {
    return ProductState(
      status: status ?? this.status,
      products: products ?? this.products,
      failure: failure ?? this.failure,
    );
  }

  factory ProductState.initial() => const ProductState(
        status: ProductStateStatus.initial,
      );

  @override
  String toString() {
    return 'ProductState(status: $status, products: $products, failure: $failure)';
  }

  @override
  List<Object?> get props => [status, products, failure];
}
