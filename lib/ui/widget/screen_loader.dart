import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'package:acits_flutter/res/color.dart';

class ScreenLoader extends StatelessWidget {
  const ScreenLoader({
    this.height,
    this.pullToRefresh,
    Key? key,
  }) : super(key: key);

  final Future<void> Function()? pullToRefresh;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return pullToRefresh != null
        ? RefreshIndicator(
            onRefresh: pullToRefresh!,
            child: _buildList(),
          )
        : _buildList();
  }

  Widget _buildList() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          top: 16.0,
          bottom: 40.0,
        ),
        child: Column(
          children: List.filled(
            3,
            Shimmer.fromColors(
              child: Container(
                height: height ?? 104.0,
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 16.0),
                decoration: const BoxDecoration(
                  color: ColorRes.textSecondary,
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
              ),
              baseColor: ColorRes.inactiveIcon.withOpacity(.3),
              highlightColor: ColorRes.background,
            ),
          ),
        ),
      ),
    );
  }
}
