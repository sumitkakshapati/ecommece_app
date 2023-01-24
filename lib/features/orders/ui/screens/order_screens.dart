import 'package:ecommerce_app/features/checkout/cubit/checkout_cubit.dart';
import 'package:ecommerce_app/features/orders/cubit/fetch_all_orders.dart';
import 'package:ecommerce_app/features/orders/resources/order_repository.dart';
import 'package:ecommerce_app/features/orders/ui/widgets/order_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderScreens extends StatelessWidget {
  const OrderScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FetchAllOrdersCubit(
        orderRepository: RepositoryProvider.of<OrderRepository>(context),
        checkoutCubit: BlocProvider.of<CheckoutCubit>(context),
      )..fetchOrders(),
      child: OrdersWidget(),
    );
  }
}
