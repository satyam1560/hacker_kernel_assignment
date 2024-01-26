import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hacker_kernel_assignment/src/features/products/domain/entities/product.dart';
import 'package:hacker_kernel_assignment/src/features/products/presentation/bloc/products_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class AddProductScreen extends StatefulWidget {
  final ProductsBloc productBloc;

  const AddProductScreen({Key? key, required this.productBloc})
      : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final ImagePicker picker = ImagePicker();
  XFile? imageFile;
  final _formKey = GlobalKey<FormState>();

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      imageFile = pickedFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: BlocConsumer<ProductsBloc, ProductState>(
        bloc: widget.productBloc,
        listener: (context, state) {
          if (state.status == ProductStateStatus.success) {
            Fluttertoast.showToast(
              msg: 'Product Added Successfully.',
            );
            Navigator.of(context).pop();
          }

          if (state.status == ProductStateStatus.failure) {
            Fluttertoast.showToast(
              msg: '${state.failure}',
            );
          }
        },
        builder: (context, state) {
          if (state.status == ProductStateStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                      borderRadius: BorderRadius.circular(15),
                      onTap: pickImage,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.purple[50],
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        height: 120,
                        width: 120,
                        child: imageFile != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: kIsWeb
                                    ? Image.network(
                                        imageFile!.path,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.file(
                                        File(imageFile!.path),
                                        fit: BoxFit.cover,
                                      ),
                              )
                            : const Center(child: Icon(Icons.add, size: 40)),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Product Name',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a product name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: priceController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Price',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a price';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple[50],
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                      ),
                      onPressed: _addProduct,
                      child: state.status == ProductStateStatus.loading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : const Text(
                              'Add Product',
                              style: TextStyle(fontSize: 18),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _addProduct() {
    if (_formKey.currentState!.validate()) {
      if (imageFile == null) {
        Fluttertoast.showToast(
          msg: 'Please select an Image.',
        );
        return;
      }
      widget.productBloc.add(
        ProductAdded(
          product: Product(
            id: const Uuid().v4(),
            image: imageFile!.path,
            name: nameController.text,
            price: double.tryParse(priceController.text)!,
          ),
        ),
      );
    }
  }
}
