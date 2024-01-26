import 'package:get_it/get_it.dart';
import 'package:hacker_kernel_assignment/src/features/authentication/data/datasources/auth_datasource.dart';
import 'package:hacker_kernel_assignment/src/features/authentication/data/repositories/auth_repo_impl.dart';
import 'package:hacker_kernel_assignment/src/features/authentication/domain/repositories/auth_repo.dart';
import 'package:hacker_kernel_assignment/src/features/authentication/domain/usecases/auth_usecase.dart';
import 'package:hacker_kernel_assignment/src/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:hacker_kernel_assignment/src/features/products/data/datasources/product_db.dart';
import 'package:hacker_kernel_assignment/src/features/products/data/repositories/product_repo_impl.dart';
import 'package:hacker_kernel_assignment/src/features/products/domain/repositories/product_repo.dart';
import 'package:hacker_kernel_assignment/src/features/products/domain/usecases/product_usecase.dart';
import 'package:hacker_kernel_assignment/src/features/products/presentation/bloc/products_bloc.dart';

final sl = GetIt.I;

Future<void> productInstanceInit() async {
  sl.registerFactory(() => ProductsBloc(productUsecase: sl()));
  sl.registerLazySingleton(() => AuthenticationBloc(authUsecase: sl()));
  sl.registerLazySingleton(() => ProductUsecase(productRepo: sl()));
  sl.registerLazySingleton(() => AuthUsecase(authRepo: sl()));
  sl.registerLazySingleton<ProductRepo>(() => ProductRepoImpl(productDb: sl()));
  sl.registerLazySingleton<AuthRepo>(() => AuthRepoImpl(authDataSource: sl()));
  sl.registerLazySingleton(() => ProductDb());
  sl.registerLazySingleton(() => AuthDataSource());
}
