import 'package:ecommerce_app/features/checkout/cubit/checkout_cubit.dart';
import 'package:ecommerce_app/features/checkout/ui/widgets/check_out_widget.dart';
import 'package:ecommerce_app/features/homepage/resources/product_repository.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CheckoutCubit(
        productRepository: RepositoryProvider.of<ProductRepository>(context),
      ),
      child: CheckoutWidgets(),
    );
  }
}
