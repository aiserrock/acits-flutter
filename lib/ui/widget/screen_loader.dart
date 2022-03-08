import 'package:flutter/material.dart';

import 'package:acits_flutter/ui/widget/skeleton.dart';
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
            Card(
              color: ColorRes.foreground,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              margin: const EdgeInsets.only(bottom: 16.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Skeleton(height: 20.0, width: 80.0),
                    SizedBox(height: 10.0),
                    Skeleton(height: 20.0, width: 170.0),
                    SizedBox(height: 10.0),
                    Skeleton(height: 20.0, width: double.infinity),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
