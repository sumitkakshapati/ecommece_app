import 'package:ecommerce_app/common/bloc/common_state.dart';
import 'package:ecommerce_app/common/cards/product_card.dart';
import 'package:ecommerce_app/features/homepage/cubit/homepage_cubit.dart';
import 'package:ecommerce_app/features/homepage/model/products.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomepageWidget extends StatelessWidget {
  const HomepageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<HomepageCubit, CommonState>(
        builder: (context, state) {
          if (state is CommonLoadingState) {
            return CupertinoActivityIndicator();
          } else if (state is CommonErrorState) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is CommonSuccessState<List<Product>>) {
            return ListView.builder(
              padding: EdgeInsets.only(top: 16),
              itemBuilder: (context, index) {
                return ProductCards(product: state.data[index]);
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
}
