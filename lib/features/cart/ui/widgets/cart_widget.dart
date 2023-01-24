import 'package:ecommerce_app/common/bloc/common_state.dart';
import 'package:ecommerce_app/common/buttons/custom_rounded_button.dart';
import 'package:ecommerce_app/common/utils/snackbar_utils.dart';
import 'package:ecommerce_app/features/cart/cubit/update_cart_quantity_cubit.dart';
import 'package:ecommerce_app/features/cart/ui/widgets/cart_card.dart';
import 'package:ecommerce_app/features/checkout/ui/screens/check_out_page.dart';
import 'package:ecommerce_app/features/homepage/cubit/fetch_all_cart.dart';
import 'package:ecommerce_app/features/homepage/cubit/total_cart_price_cubit.dart';
import 'package:ecommerce_app/features/homepage/model/cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:page_transition/page_transition.dart';

class CartWidget extends StatefulWidget {
  const CartWidget({super.key});

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget>
    with AutomaticKeepAliveClientMixin {
  bool _isloading = false;

  _updateLoadingState(bool status) {
    setState(() {
      _isloading = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LoadingOverlay(
      isLoading: _isloading,
      child: BlocListener<UpdateCartQuantityCubit, CommonState>(
        listener: (context, state) {
          if (state is CommonLoadingState) {
            _updateLoadingState(true);
          } else {
            _updateLoadingState(false);
          }

          if (state is CommonErrorState) {
            SnackbarUtils.showSnackBar(
                context: context, message: state.message);
          }
        },
        child: BlocBuilder<FetchAllCartCubit, CommonState>(
          builder: (context, state) {
            if (state is CommonLoadingState) {
              return Center(child: CupertinoActivityIndicator());
            } else if (state is CommonErrorState) {
              return Center(
                child: Text(state.message),
              );
            } else if (state is CommonSuccessState<List<CartModel>>) {
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.only(top: 16),
                      itemBuilder: (context, index) {
                        return CartCard(cart: state.data[index]);
                      },
                      itemCount: state.data.length,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(12)),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(1, -3),
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 10,
                          spreadRadius: 10,
                        )
                      ],
                    ),
                    child:
                        BlocSelector<TotalCartAmountCubit, CommonState, String>(
                      selector: (state) {
                        if (state is CommonLoadingState) {
                          return "Calculating Amount";
                        } else if (state is CommonSuccessState<num>) {
                          return state.data.toString();
                        } else {
                          return "Amount not available";
                        }
                      },
                      builder: (context, amount) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 6),
                              child: Text(
                                "Total Cost: Rs. $amount",
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            SizedBox(height: 4),
                            CustomRoundedButtom(
                              title: "Checkout",
                              onPressed: () {
                                Navigator.of(context).push(
                                  PageTransition(
                                    child: CheckoutPage(),
                                    type: PageTransitionType.fade,
                                  ),
                                );
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  )
                ],
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
