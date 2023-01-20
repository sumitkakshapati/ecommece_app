import 'package:ecommerce_app/features/homepage/cubit/add_to_cart_cubit.dart';
import 'package:ecommerce_app/features/homepage/cubit/product_detail_cubit.dart';
import 'package:ecommerce_app/features/homepage/resources/product_repository.dart';
import 'package:ecommerce_app/features/homepage/ui/widgets/product_details_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsScreens extends StatelessWidget {
  final String productId;
  const ProductDetailsScreens({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductDetailCubit(
            repository: RepositoryProvider.of<ProductRepository>(context),
          )..fetchProductDetails(productId),
        ),
        BlocProvider(
          create: (context) => AddToCartCubit(
            repository: RepositoryProvider.of<ProductRepository>(context),
          ),
        ),
      ],
      child: ProductDetailsWidgets(),
    );
  }
}
