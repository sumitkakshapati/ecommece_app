import 'package:ecommerce_app/common/custom_theme.dart';
import 'package:ecommerce_app/features/auth/resources/user_repository.dart';
import 'package:ecommerce_app/features/homepage/resources/product_repository.dart';
import 'package:ecommerce_app/features/splash/ui/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => UserRepository(),
        ),
        RepositoryProvider(
          create: (context) => ProductRepository(
            userRepository: RepositoryProvider.of<UserRepository>(context),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Ecommerce',
        theme: ThemeData(
          primaryColor: CustomTheme.primaryColor,
          textTheme: GoogleFonts.poppinsTextTheme(),
        ),
        home: const SplashPage(),
      ),
    );
  }
}
