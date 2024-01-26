import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacker_kernel_assignment/injection.dart';
import 'package:hacker_kernel_assignment/src/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:hacker_kernel_assignment/src/features/authentication/presentation/pages/login_screen.dart';
import 'package:hacker_kernel_assignment/src/features/products/presentation/bloc/products_bloc.dart';
import 'package:hacker_kernel_assignment/src/features/products/presentation/pages/add_product_screen.dart';
import 'package:hacker_kernel_assignment/src/features/products/presentation/widgets/product_card.dart';

class ListProductScreen extends StatefulWidget {
  const ListProductScreen({super.key});

  @override
  State<ListProductScreen> createState() => _ListProductScreenState();
}

class _ListProductScreenState extends State<ListProductScreen> {
  final _productBloc = sl<ProductsBloc>();
  final _authBloc = sl<AuthenticationBloc>();
  final _searchController = TextEditingController();
  @override
  void initState() {
    _productBloc.add(ProductListed());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hi-Fi Shop & Service'),
        actions: [
          IconButton(
            onPressed: () {
              _authBloc.add(AuthLoggedOut());
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
                (route) => false,
              );
            },
            icon: const Icon(
              Icons.logout_rounded,
            ),
          )
        ],
      ),
      body: BlocBuilder<ProductsBloc, ProductState>(
        bloc: _productBloc,
        builder: (context, state) {
          if (state.status == ProductStateStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.status == ProductStateStatus.failure) {
            return Center(
                child: AlertDialog(
              content: Text('${state.failure}'),
            ));
          }
          if (state.status == ProductStateStatus.success) {
            final productList = state.products;

            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('This Shop offers both product and Services'),
                  const Text(
                    'Products',
                    textScaler: TextScaler.linear(2),
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _searchController,
                    onChanged: (value) {
                      if (value.isEmpty) {
                        _productBloc.add(ProductListed());
                      }
                      if (value.length > 2) {
                        _productBloc.add(
                          ProductSearched(
                            query: _searchController.text,
                          ),
                        );
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'Search',
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        onPressed: () {
                          _productBloc.add(
                            ProductSearched(
                              query: _searchController.text,
                            ),
                          );
                        },
                        icon: const Icon(Icons.search),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  productList.isNotEmpty
                      ? Expanded(
                          child: GridView.builder(
                            itemCount: productList.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 0.7,
                              crossAxisCount: 2,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              final product = productList[index];
                              return ProductCard(
                                product: product,
                                delete: () {
                                  if (product?.id != null) {
                                    _productBloc
                                        .add(ProductDeleted(id: product!.id));
                                  }
                                },
                              );
                            },
                          ),
                        )
                      : const Center(child: Text('No Products Found')),
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddProductScreen(
                productBloc: _productBloc,
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
