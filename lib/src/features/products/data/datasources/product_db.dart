import 'package:hacker_kernel_assignment/src/config/shared_prefs.dart';
import 'package:hacker_kernel_assignment/src/features/products/data/models/product_dto.dart';
import 'package:hacker_kernel_assignment/src/features/products/domain/entities/product.dart';

class ProductDb {
  Future<ProductDto> addProduct(ProductDto product) async {
    try {
      await SharedPrefs.addProduct(product: product);
      return product;
    } catch (_) {
      rethrow;
    }
  }

  Future<List<Product?>> listProducts() async {
    try {
      List<ProductDto?> products = SharedPrefs.listProducts();
      return products;
    } catch (_) {
      rethrow;
    }
  }

  Future<bool> deleteProduct(String id) async {
    try {
      final result = SharedPrefs.deleteProduct(id);
      return result;
    } catch (_) {
      rethrow;
    }
  }

  Future<List<Product?>> searchProducts(String query) async {
    try {
      List<ProductDto?> products = SharedPrefs.listProducts();
      return products
          .where((product) =>
              product?.name.toLowerCase().contains(query.toLowerCase()) ??
              false)
          .toList();
    } catch (_) {
      rethrow;
    }
  }
}
