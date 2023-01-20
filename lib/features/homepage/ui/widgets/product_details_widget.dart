import 'package:ecommerce_app/common/assets.dart';
import 'package:ecommerce_app/common/bloc/common_state.dart';
import 'package:ecommerce_app/common/buttons/custom_rounded_button.dart';
import 'package:ecommerce_app/common/custom_theme.dart';
import 'package:ecommerce_app/common/utils/snackbar_utils.dart';
import 'package:ecommerce_app/features/homepage/cubit/add_to_cart_cubit.dart';
import 'package:ecommerce_app/features/homepage/cubit/product_detail_cubit.dart';
import 'package:ecommerce_app/features/homepage/model/products.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_overlay/loading_overlay.dart';

class ProductDetailsWidgets extends StatefulWidget {
  ProductDetailsWidgets({Key? key}) : super(key: key);

  @override
  State<ProductDetailsWidgets> createState() => _ProductDetailsWidgetsState();
}

class _ProductDetailsWidgetsState extends State<ProductDetailsWidgets> {
  ValueNotifier<bool> _isProductAddedToCart = ValueNotifier(false);
  Product? _product;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: _isLoading,
      child: Scaffold(
        backgroundColor: CustomTheme.backGroundColor,
        appBar: AppBar(
          backgroundColor: CustomTheme.primaryColor,
        ),
        body: BlocListener<AddToCartCubit, CommonState>(
          listener: (context, state) {
            if (state is CommonLoadingState) {
              setState(() {
                _isLoading = true;
              });
            } else {
              setState(() {
                _isLoading = false;
              });
            }

            if (state is CommonErrorState) {
              SnackbarUtils.showSnackBar(
                  context: context, message: state.message);
            } else if (state is CommonSuccessState) {
              SnackbarUtils.showSnackBar(
                context: context,
                message: "Product added to cart",
              );
              _isProductAddedToCart.value = true;
            }
          },
          child: BlocConsumer<ProductDetailCubit, CommonState>(
            listener: (context, state) {
              if (state is CommonSuccessState<Product>) {
                _product = state.data;
                _isProductAddedToCart.value = state.data.isInCart;
              }
            },
            builder: (context, state) {
              if (state is CommonLoadingState) {
                return Center(child: CupertinoActivityIndicator());
              } else if (state is CommonErrorState) {
                return Center(
                  child: Text(state.message),
                );
              } else if (state is CommonSuccessState<Product>) {
                return Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * .35,
                      width: double.infinity,
                      child: Image.network(
                        state.data.image,
                        fit: BoxFit.cover,
                        height: double.infinity,
                      ),
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(
                                top: 40, right: 14, left: 14),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                            ),
                            height: double.infinity,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    state.data.brand,
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        state.data.name,
                                        style: GoogleFonts.poppins(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(width: 16),
                                      Text(
                                        state.data.formatedPrice,
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  Text(
                                    state.data.description,
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: CustomTheme.darkGrayColor,
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                ],
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              margin: const EdgeInsets.only(top: 10),
                              width: 50,
                              height: 5,
                              decoration: BoxDecoration(
                                color: CustomTheme.gray,
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ValueListenableBuilder<bool>(
                      valueListenable: _isProductAddedToCart,
                      builder: (context, isInCart, _) {
                        if (isInCart) {
                          return Container();
                        } else {
                          return Container(
                            height: 70,
                            color: Colors.white,
                            padding: EdgeInsets.all(10),
                            child: CustomRoundedButtom(
                              title: "+ Add to Cart",
                              onPressed: () {
                                if (_product != null) {
                                  context
                                      .read<AddToCartCubit>()
                                      .addToCart(_product!.id);
                                } else {
                                  SnackbarUtils.showSnackBar(
                                      context: context,
                                      message: "Product not found");
                                }
                              },
                            ),
                          );
                        }
                      },
                    ),
                  ],
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}
