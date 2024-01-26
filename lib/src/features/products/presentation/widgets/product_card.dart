import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hacker_kernel_assignment/src/features/products/domain/entities/product.dart';

class ProductCard extends StatelessWidget {
  final Product? product;
  final VoidCallback delete;

  const ProductCard({
    super.key,
    required this.product,
    required this.delete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                kIsWeb
                    ? Image.network(
                        product?.image ?? '',
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                    : Image.file(
                        File(product?.image ?? ''),
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                IconButton(
                  onPressed: delete,
                  icon: const Icon(
                    Icons.delete_outline,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            product?.name ?? 'N/A',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            '₹ ${product?.price ?? 'N/A'}',
            style: const TextStyle(fontSize: 14, color: Colors.purple),
          ),
        ],
      ),
    );
  }
}
