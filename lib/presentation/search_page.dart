import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:fresh_garden/blocs/blocs.dart';
import 'package:fresh_garden/blocs/search/bloc/search_bloc.dart';
import 'package:fresh_garden/models/product_model.dart';
import 'package:fresh_garden/presentation/product_details.dart';

import '../utils/constances.dart';
import '../widgets/custom_text.dart';
import '../widgets/search_field.dart';
import '../widgets/RandomSearch.dart';

class SerachPage extends StatefulWidget {
  const SerachPage({super.key});

  @override
  State<SerachPage> createState() => _SerachPageState();
}

class _SerachPageState extends State<SerachPage> {
  final TextEditingController _search = TextEditingController();

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(
            height: 13.h,
          ),
          SearchField(
            search: _search,
            prefixIcon: BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                if (state is SearchEmptyState) {
                  return const Icon(Icons.search);
                }

                return IconButton(
                    onPressed: () {
                      context
                          .read<SearchBloc>()
                          .add(const StarSearchEvent(searchtext: ''));
                      _search.clear();
                    },
                    icon: const Icon(Icons.clear));
              },
            ),
            onChanged: (String? value) => context
                .read<SearchBloc>()
                .add(StarSearchEvent(searchtext: _search.text.trim())),
          ),
          Expanded(
            child: BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                if (state is SearchEmptyState) {
                  return RandomSearch();
                }
                if (state is LoadingSearchState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is SearcheFinished) {
                  final List<ProductModel> products = state.products;
                  return ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return _buildcartproduct(products[index]);
                    },
                  );
                }
                if (state is SearchErrorState) {
                  return Center(
                    child: Text(state.errortext),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          )
        ],
      )),
    );
  }

  Widget _buildcartproduct(ProductModel products) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return ProductDetails(productModel: products);
          },
        ));
      },
      child: Container(
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Color(0xFFE2E2E2)))),
        child: ListTile(
          leading: CachedNetworkImage(
            height: 90.h,
            width: 90.w,
            imageUrl: products.productimage,
            placeholder: (context, url) => Center(
                child: CircularProgressIndicator(
              color: greencolor,
            )),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          title:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            CustomText(
              text: products.productname,
              fontWeight: FontWeight.bold,
              size: 22.sp,
            ),
            SizedBox(
              height: 5.h,
            ),
            Row(
              children: [
                CustomText(
                  text: '1Kg Price',
                  fontWeight: FontWeight.w300,
                  size: 19.sp,
                ),
                SizedBox(
                  width: 23.w,
                ),
                CustomText(
                  text: products.pruductprice,
                  fontWeight: FontWeight.bold,
                  size: 22.sp,
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
          ]),
          contentPadding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.w),
          trailing: Padding(
              padding: EdgeInsets.only(top: 7.h, left: 3.w),
              child: IconButton(
                  onPressed: () async {}, icon: const Icon(Icons.clear))),
        ),
      ),
    );
  }
}
