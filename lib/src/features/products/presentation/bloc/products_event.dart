part of 'products_bloc.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object?> get props => [];
}

class ProductAdded extends ProductsEvent {
  final Product product;

  const ProductAdded({
    required this.product,
  });

  @override
  List<Object?> get props => [product];
}

class ProductListed extends ProductsEvent {}

class ProductDeleted extends ProductsEvent {
  final String id;

  const ProductDeleted({
    required this.id,
  });

  @override
  List<Object?> get props => [id];
}

class ProductSearched extends ProductsEvent {
  final String query;

  const ProductSearched({
    required this.query,
  });

  @override
  List<Object?> get props => [query];
}
