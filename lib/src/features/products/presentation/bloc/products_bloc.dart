import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacker_kernel_assignment/src/features/failure.dart';
import 'package:hacker_kernel_assignment/src/features/products/data/models/product_dto.dart';
import 'package:hacker_kernel_assignment/src/features/products/domain/entities/product.dart';
import 'package:hacker_kernel_assignment/src/features/products/domain/usecases/product_usecase.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductState> {
  final ProductUsecase _productUsecase;
  ProductsBloc({required ProductUsecase productUsecase})
      : _productUsecase = productUsecase,
        super(ProductState.initial()) {
    on<ProductAdded>(_onProductAdded);
    on<ProductListed>(_onProductListed);
    on<ProductDeleted>(_onProductDeleted);
    on<ProductSearched>(_onProductSearched);
  }

  Future<void> _onProductListed(
    ProductListed event,
    Emitter<ProductState> emit,
  ) async {
    emit(
      state.copyWith(
        status: ProductStateStatus.loading,
      ),
    );
    final response = await _productUsecase.listProducts();
    response.fold(
      (left) => emit(
        state.copyWith(
          status: ProductStateStatus.failure,
          failure: left,
        ),
      ),
      (products) {
        emit(
          state.copyWith(
            status: ProductStateStatus.success,
            products: products,
          ),
        );
      },
    );
  }

  Future<void> _onProductAdded(
    ProductAdded event,
    Emitter<ProductState> emit,
  ) async {
    emit(
      state.copyWith(
        status: ProductStateStatus.loading,
      ),
    );
    final product = event.product;
    final response = await _productUsecase.addProduct(
      ProductDto(
        id: product.id,
        name: product.name,
        image: product.image,
        price: product.price,
      ),
    );
    response.fold(
      (left) => emit(
        state.copyWith(
          status: ProductStateStatus.failure,
          failure: left,
        ),
      ),
      (product) {
        emit(
          state.copyWith(
            status: ProductStateStatus.success,
            products: [...state.products, product],
          ),
        );
      },
    );
  }

  Future<void> _onProductDeleted(
    ProductDeleted event,
    Emitter<ProductState> emit,
  ) async {
    emit(
      state.copyWith(
        status: ProductStateStatus.loading,
      ),
    );
    final response = await _productUsecase.deleteProduct(event.id);
    response.fold(
      (left) => emit(
        state.copyWith(
          status: ProductStateStatus.failure,
          failure: left,
        ),
      ),
      (success) {
        if (success) {
          emit(
            state.copyWith(
              status: ProductStateStatus.success,
              products: state.products
                ..removeWhere((product) => product?.id == event.id),
            ),
          );
        }
      },
    );
  }

  Future<void> _onProductSearched(
    ProductSearched event,
    Emitter<ProductState> emit,
  ) async {
    emit(
      state.copyWith(
        status: ProductStateStatus.loading,
      ),
    );
    final response = await _productUsecase.searchProducts(event.query);
    response.fold(
      (left) => emit(
        state.copyWith(
          status: ProductStateStatus.failure,
          failure: left,
        ),
      ),
      (products) {
        emit(
          state.copyWith(
            status: ProductStateStatus.success,
            products: products,
          ),
        );
      },
    );
  }
}
