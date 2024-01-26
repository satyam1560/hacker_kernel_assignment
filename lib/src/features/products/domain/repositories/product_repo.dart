import 'package:dartz/dartz.dart';
import 'package:hacker_kernel_assignment/src/features/failure.dart';
import 'package:hacker_kernel_assignment/src/features/products/data/models/product_dto.dart';
import 'package:hacker_kernel_assignment/src/features/products/domain/entities/product.dart';

abstract class ProductRepo {
  Future<Either<Failure, Product>> addProduct(ProductDto product);
  Future<Either<Failure, bool>> deleteProduct(String id);
  Future<Either<Failure, List<Product?>>> listProducts();
  Future<Either<Failure, List<Product?>>> searchProducts(String query);
}
