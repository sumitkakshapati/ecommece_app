import 'package:ecommerce_app/features/cart/cubit/update_cart_quantity_cubit.dart';
import 'package:ecommerce_app/features/cart/ui/widgets/cart_widget.dart';
import 'package:ecommerce_app/features/homepage/cubit/fetch_all_cart.dart';
import 'package:ecommerce_app/features/homepage/cubit/total_cart_price_cubit.dart';
import 'package:ecommerce_app/features/homepage/resources/product_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FetchAllCartCubit(
            repository: RepositoryProvider.of<ProductRepository>(context),
          )..fetchData(),
        ),
        BlocProvider(
          create: (context) => TotalCartAmountCubit(
            repository: RepositoryProvider.of<ProductRepository>(context),
          )..totalAmount(),
        ),
        BlocProvider(
          create: (context) => UpdateCartQuantityCubit(
            productRepository:
                RepositoryProvider.of<ProductRepository>(context),
          ),
        ),
      ],
      child: CartWidget(),
    );
  }
}
