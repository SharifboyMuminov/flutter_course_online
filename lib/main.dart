import 'package:fire_auth/cubits/category/category_cubit.dart';
import 'package:fire_auth/cubits/home/home_cubit.dart';
import 'package:fire_auth/cubits/product/product_cubit.dart';
import 'package:fire_auth/cubits/user/user_cubit.dart';
import 'package:fire_auth/data/local/storage_repository.dart';
import 'package:fire_auth/data/repositories/category_repository.dart';
import 'package:fire_auth/data/repositories/home_repository.dart';
import 'package:fire_auth/data/repositories/product_repository.dart';
import 'package:fire_auth/data/repositories/user_repository.dart';
import 'package:fire_auth/screens/splash/splash_screen.dart';
import 'package:fire_auth/service/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  StorageRepository.instance;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [

        RepositoryProvider(
          create: (_) => UserRepository(),
        ),
        RepositoryProvider(
          create: (_) => HomeRepository(),
        ),
        RepositoryProvider(
          create: (_) => CategoryRepository(),
        ),
        RepositoryProvider(
          create: (_) => ProductRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [

          BlocProvider(
            create: (context) => UserCubit(context.read<UserRepository>()),
          ),
          BlocProvider(
            create: (context) => HomeCubit(context.read<HomeRepository>()),
          ),
          BlocProvider(
            create: (context) =>
                ProductCubit(context.read<ProductRepository>()),
          ),
          BlocProvider(
            create: (context) =>
                CategoryCubit(context.read<CategoryRepository>()),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            useMaterial3: true,
          ),
          home: SplashScreen(),
        ),
      ),
    );
  }
}
