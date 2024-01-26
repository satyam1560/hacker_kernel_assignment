import 'dart:convert';

import 'package:hacker_kernel_assignment/src/features/products/data/models/product_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _token = 'token';
const _products = 'products';

class SharedPrefs {
  factory SharedPrefs() => SharedPrefs._internal();
  SharedPrefs._internal();
  static SharedPreferences? _sharedPrefs;

  static Future<void> init() async {
    _sharedPrefs ??= await SharedPreferences.getInstance();
  }

  static Future<void> setToken(String token) async {
    if (_sharedPrefs != null) {
      await _sharedPrefs?.setString(_token, token);
    }
  }

  static String? getToken() {
    return _sharedPrefs?.getString(_token);
  }

  static Future<bool> addProduct({required ProductDto product}) async {
    if (_sharedPrefs != null) {
      final storedProducts = _sharedPrefs?.getStringList(_products) ?? [];

      final result = await _sharedPrefs?.setStringList(
        _products,
        [...storedProducts, jsonEncode(product.toMap())],
      );

      return result ?? false;
    }
    return false;
  }

  static List<ProductDto> listProducts() {
    List<ProductDto> products = [];
    final storedProducts = _sharedPrefs?.getStringList(_products) ?? [];

    for (var product in storedProducts) {
      products.add(ProductDto.fromMap(jsonDecode(product)));
    }

    return products;
  }

  static Future<bool> deleteProduct(String id) async {
    if (_sharedPrefs == null) return false;
    final storedProducts = _sharedPrefs?.getStringList(_products) ?? [];

    final List<String> updatedProducts = List.from(storedProducts)
      ..removeWhere((product) {
        Map<String, dynamic> productMap = jsonDecode(product);
        return productMap['id'] == id;
      });

    final result = await _sharedPrefs?.setStringList(
      _products,
      updatedProducts,
    );

    return result ?? false;
  }

  static Future<List<ProductDto?>> searchProducts(String query) async {
    if (_sharedPrefs == null) return [];

    final products = listProducts();

    final List<ProductDto?> updatedProducts = products
        .where((product) =>
            product.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return updatedProducts;
  }

  static Future<void> clear() async {
    await _sharedPrefs?.clear();
  }
}
