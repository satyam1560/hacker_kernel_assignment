import 'package:dartz/dartz.dart';
import 'package:hacker_kernel_assignment/src/features/failure.dart';
import 'package:hacker_kernel_assignment/src/features/products/data/models/product_dto.dart';
import 'package:hacker_kernel_assignment/src/features/products/domain/entities/product.dart';
import 'package:hacker_kernel_assignment/src/features/products/domain/repositories/product_repo.dart';

class ProductUsecase {
  final ProductRepo _productRepo;

  ProductUsecase({required ProductRepo productRepo})
      : _productRepo = productRepo;

  Future<Either<Failure, Product>> addProduct(ProductDto product) async {
    return await _productRepo.addProduct(product);
  }

  Future<Either<Failure, List<Product?>>> listProducts() async {
    return await _productRepo.listProducts();
  }

  Future<Either<Failure, bool>> deleteProduct(String id) async {
    return await _productRepo.deleteProduct(id);
  }

  Future<Either<Failure, List<Product?>>> searchProducts(String query) async {
    return await _productRepo.searchProducts(query);
  }
}
