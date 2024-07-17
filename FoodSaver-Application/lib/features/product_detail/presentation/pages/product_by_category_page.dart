import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funix_thieudvfx_foodsaver/dependency_injection.dart';
import 'package:funix_thieudvfx_foodsaver/features/auth/presentation/widgets/loading_page.dart';
import 'package:funix_thieudvfx_foodsaver/features/auth/presentation/widgets/no_data_found.dart';
import 'package:funix_thieudvfx_foodsaver/features/home/presentation/widgets/product_gridview.dart';
import 'package:funix_thieudvfx_foodsaver/features/product_detail/presentation/bloc/product_detail_bloc.dart';
import 'package:funix_thieudvfx_foodsaver/theme/app_component.dart';
import 'package:funix_thieudvfx_foodsaver/theme/theme.dart';

class ProductByCategoryPage extends StatelessWidget {
  final int categoryId;
  final String categoryName;
  const ProductByCategoryPage({
    Key? key,
    required this.categoryId,
    required this.categoryName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductDetailBloc>(
      create: (context) => DependencyInjection.instance(),
      child: ProductByCategoryWrapper(
        categoryId: categoryId,
        categoryName: categoryName,
      ),
    );
  }
}

class ProductByCategoryWrapper extends StatefulWidget {
  final int categoryId;
  final String categoryName;
  const ProductByCategoryWrapper({super.key, required this.categoryId, required this.categoryName});

  @override
  State<ProductByCategoryWrapper> createState() => _ProductByCategoryWrapperState();
}

class _ProductByCategoryWrapperState extends State<ProductByCategoryWrapper> {
  late ProductDetailBloc _productDetailBloc;

  @override
  void initState() {
    _productDetailBloc = BlocProvider.of<ProductDetailBloc>(context);
    _productDetailBloc.add(ProductByCategoryPageEvent(widget.categoryId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: AppSizes.paddingHorizontal,
        backgroundColor: AppColors.primaryBrand,
        systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent),
        title: AppComponent.customAppBar(Colors.white, widget.categoryName, context),
        toolbarHeight: 50.h,
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<ProductDetailBloc, ProductDetailState>(
          bloc: _productDetailBloc,
          builder: (context, state) {
            if (state is ProductByCategoryPageFinishedState) {
              return state.listProductEntity.isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 24.h),
                        ProductGridView(products: state.listProductEntity),
                        SizedBox(height: AppSizes.paddingBottom),
                      ],
                    )
                  : const NoDataFound();
            } else if (state is ProductByCategoryPageLoadingState) {
              return const LoadingPage();
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
