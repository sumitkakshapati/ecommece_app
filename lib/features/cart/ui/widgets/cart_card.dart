import 'package:ecommerce_app/common/assets.dart';
import 'package:ecommerce_app/common/bloc/common_state.dart';
import 'package:ecommerce_app/common/custom_theme.dart';
import 'package:ecommerce_app/features/cart/cubit/update_cart_quantity_cubit.dart';
import 'package:ecommerce_app/features/homepage/cubit/total_cart_price_cubit.dart';
import 'package:ecommerce_app/features/homepage/model/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class CartCard extends StatefulWidget {
  final CartModel cart;
  const CartCard({super.key, required this.cart});

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  int _quantity = 1;

  @override
  void initState() {
    super.initState();
    _quantity = widget.cart.quantity;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateCartQuantityCubit, CommonState>(
      listener: (context, state) {
        if (state is CommonSuccessState<CartModel>) {
          if (state.data.id == widget.cart.id) {
            setState(() {
              _quantity = state.data.quantity;
            });
            context.read<TotalCartAmountCubit>().totalAmount();
          }
        }
      },
      child: Container(
        margin: const EdgeInsets.only(
          bottom: 16,
          left: CustomTheme.horizontalPadding,
          right: CustomTheme.horizontalPadding,
        ),
        child: Material(
          elevation: 1,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      widget.cart.product.image,
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 0, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        widget.cart.product.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        widget.cart.product.formatedPrice,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      IconButton(
                        splashRadius: 10.0,
                        onPressed: () {
                          if (_quantity > 1) {
                            context
                                .read<UpdateCartQuantityCubit>()
                                .updateQuantity(
                                  cartId: widget.cart.id,
                                  quantity: _quantity - 1,
                                );
                          }
                        },
                        icon: const Icon(
                          Icons.remove,
                          size: 16,
                          color: CustomTheme.primaryColor,
                        ),
                      ),
                      Text(
                        '${_quantity}',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      IconButton(
                        splashRadius: 10.0,
                        onPressed: () {
                          context
                              .read<UpdateCartQuantityCubit>()
                              .updateQuantity(
                                cartId: widget.cart.id,
                                quantity: _quantity + 1,
                              );
                        },
                        icon: const Icon(
                          Icons.add,
                          size: 16,
                          color: CustomTheme.primaryColor,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
