import 'package:ecommerce_app/common/bloc/common_state.dart';
import 'package:ecommerce_app/common/cards/product_card.dart';
import 'package:ecommerce_app/features/homepage/cubit/home_page_event.dart';
import 'package:ecommerce_app/features/homepage/cubit/homepage_cubit.dart';
import 'package:ecommerce_app/features/homepage/model/products.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class HomepageWidget extends StatefulWidget {
  final TextEditingController searchController;
  const HomepageWidget({super.key, required this.searchController});

  @override
  State<HomepageWidget> createState() => _HomepageWidgetState();
}

class _HomepageWidgetState extends State<HomepageWidget>
    with AutomaticKeepAliveClientMixin {
  final RefreshController _refreshController = RefreshController();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: BlocConsumer<HomepageCubit, CommonState>(
        listener: (context, state) {
          if (state is! CommonLoadingState) {
            _refreshController.refreshCompleted();
          }
        },
        buildWhen: (previous, current) {
          if (current is CommonLoadingState) {
            if (current.isRefreshing) {
              return false;
            } else {
              return true;
            }
          } else {
            return true;
          }
        },
        builder: (context, state) {
          if (state is CommonLoadingState) {
            return CupertinoActivityIndicator();
          } else if (state is CommonErrorState) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is CommonSuccessState<List<Product>>) {
            return NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification.metrics.pixels >
                        (notification.metrics.maxScrollExtent / 2) &&
                    _scrollController.position.userScrollDirection ==
                        ScrollDirection.reverse) {
                  context.read<HomepageCubit>().add(LoadMoreHomepageDataEvent(
                      query: widget.searchController.text));
                }
                return false;
              },
              child: SmartRefresher(
                controller: _refreshController,
                onRefresh: () {
                  context.read<HomepageCubit>().add(ReFetchAllHomepageDataEvent(
                      query: widget.searchController.text));
                },
                child: ListView.builder(
                  controller: _scrollController,
                  padding: EdgeInsets.only(top: 16),
                  itemBuilder: (context, index) {
                    return ProductCards(product: state.data[index]);
                  },
                  itemCount: state.data.length,
                ),
              ),
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
