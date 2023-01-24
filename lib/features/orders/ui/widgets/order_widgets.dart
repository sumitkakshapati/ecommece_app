import 'package:ecommerce_app/common/bloc/common_state.dart';
import 'package:ecommerce_app/features/orders/cubit/fetch_all_orders.dart';
import 'package:ecommerce_app/features/orders/model/orders.dart';
import 'package:ecommerce_app/features/orders/ui/widgets/order_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersWidget extends StatefulWidget {
  const OrdersWidget({super.key});

  @override
  State<OrdersWidget> createState() => _OrdersWidgetState();
}

class _OrdersWidgetState extends State<OrdersWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: BlocBuilder<FetchAllOrdersCubit, CommonState>(
        builder: (context, state) {
          if (state is CommonLoadingState) {
            return Center(
              child: CupertinoActivityIndicator(),
            );
          } else if (state is CommonErrorState) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is CommonSuccessState<List<Orders>>) {
            return ListView.builder(
              padding: EdgeInsets.only(top: 16),
              itemBuilder: (context, index) {
                return OrderCard(orders: state.data[index]);
              },
              itemCount: state.data.length,
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}
