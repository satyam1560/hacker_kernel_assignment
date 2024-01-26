import 'package:dartz/dartz.dart';
import 'package:hacker_kernel_assignment/src/features/failure.dart';
import 'package:hacker_kernel_assignment/src/features/products/data/datasources/product_db.dart';
import 'package:hacker_kernel_assignment/src/features/products/data/models/product_dto.dart';
import 'package:hacker_kernel_assignment/src/features/products/domain/entities/product.dart';
import 'package:hacker_kernel_assignment/src/features/products/domain/repositories/product_repo.dart';

class ProductRepoImpl implements ProductRepo {
  final ProductDb _productDb;

  ProductRepoImpl({required ProductDb productDb}) : _productDb = productDb;

  @override
  Future<Either<Failure, Product>> addProduct(ProductDto product) async {
    try {
      final result = await _productDb.addProduct(product);
      return Right(result);
    } catch (error) {
      return Left(Failure(failureMessage: error.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Product?>>> listProducts() async {
    try {
      final result = await _productDb.listProducts();
      return Right(result);
    } catch (error) {
      return Left(Failure(failureMessage: error.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteProduct(String id) async {
    try {
      final result = await _productDb.deleteProduct(id);
      return Right(result);
    } catch (error) {
      return Left(Failure(failureMessage: error.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Product?>>> searchProducts(String query) async {
    try {
      final result = await _productDb.searchProducts(query);
      return Right(result);
    } catch (error) {
      return Left(Failure(failureMessage: error.toString()));
    }
  }
}
