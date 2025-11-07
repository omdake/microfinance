import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:microfinance/common_widgets/ui_helper_widgets.dart';
import 'package:microfinance/themes/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class LoadMoreListView extends StatelessWidget {
  final List<Widget> children;
  final Function loadData;
  final Function loadMoreData;
  final EdgeInsetsGeometry? padding;

  const LoadMoreListView({
    Key? key,
    required this.loadMoreData,
    required this.loadData,
    required this.children,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
        header: DeliveryHeader(
          backgroundColor: AppColors.primary,
        ),
        footer: BallPulseFooter(
          backgroundColor: Colors.white,
          color: AppColors.primary,
        ),
        onLoad: () async => loadMoreData(),
        onRefresh: () async => loadData(),
        child: ListView(
          children: children.isNotEmpty
              ? children
              : [
                  Container(
                    height: MediaQuery.of(Get.context!).size.height / 1,
                    child: Center(child: Text("No Data Found")),
                  )
                ],
          padding: padding,
        )
        /*
         ListView(
          children: [
           Container(width: double.infinity, child: Column(children: children)),
            Text("No more data")
          ],
           padding: padding,
         ),*/
        );
  }
}

class LoadMoreListView1 extends StatelessWidget {
  final List<Widget> children;
  final bool isLoading;
  final bool isLoadingMore;
  final EdgeInsetsGeometry? padding;
  final int shimmerItemCount;
  final Future<void> Function()? loadData;
  final Future<void> Function()? loadMoreData;

  const LoadMoreListView1({
    Key? key,
    required this.children,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.padding,
    this.shimmerItemCount = 15,
    this.loadData,
    this.loadMoreData,
  }) : super(key: key);

  Widget _buildSkeletonLoader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade300,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                shape: BoxShape.circle,
              ),
            ),
          ),
          C10(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    height: 14,
                    width: 120,
                    color: Colors.grey.shade400,
                  ),
                ),
                const SizedBox(height: 6),
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    height: 12,
                    width: 200,
                    color: Colors.grey.shade400,
                  ),
                ),
              ],
            ),
          ),
          C10(),
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              width: 50,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return ListView.builder(
        padding: padding ?? const EdgeInsets.all(8),
        itemCount: shimmerItemCount,
        itemBuilder: (context, index) => _buildSkeletonLoader(),
      );
    }

    if (children.isEmpty) {
      return Center(
        child: Text(
          "No Data Found",
          style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
        ),
      );
    }

    return RefreshIndicator(
      color: AppColors.primaryRed,
      backgroundColor: Colors.white,
      onRefresh: loadData ?? () async {},
      child: NotificationListener<ScrollNotification>(
        onNotification: (scrollInfo) {
          if (loadMoreData != null &&
              !isLoadingMore &&
              scrollInfo.metrics.pixels >=
                  scrollInfo.metrics.maxScrollExtent - 100) {
            Future.microtask(() => loadMoreData!());
          }
          return false;
        },
        child: ListView.builder(
          padding: padding,
          itemCount: children.length + (isLoadingMore ? 1 : 0),
          itemBuilder: (context, index) {
            if (index < children.length) return children[index];
            return _buildSkeletonLoader();
          },
        ),
      ),
    );
//     return RefreshIndicator(
//   color: AppColors.primaryRed,
//   backgroundColor: Colors.white,
//   onRefresh: () async {
//     if (loadData != null) {
//       await loadData!();
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text("Load completed"),
//           duration: Duration(seconds: 2),
//         ),
//       );
//     }
//   },
//   child: NotificationListener<ScrollNotification>(
//     onNotification: (scrollInfo) {
//       if (loadMoreData != null &&
//           !isLoadingMore &&
//           scrollInfo.metrics.pixels >= scrollInfo.metrics.maxScrollExtent - 100) {
//         loadMoreData?.call();
//       }
//       return false;
//     },
//     child: ListView.builder(
//       padding: padding,
//       itemCount: children.length + (isLoadingMore ? 1 : 0),
//       itemBuilder: (context, index) {
//         if (index < children.length) return children[index];
//         return _buildSkeletonLoader();
//       },
//     ),
//   ),
// );
  }
}
