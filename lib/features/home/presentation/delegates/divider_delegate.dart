import 'package:flutter/material.dart';

class DividerDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return const Divider(thickness: 4);
  }

  @override
  double get maxExtent => 4.0;

  @override
  double get minExtent => 4.0;

  @override
  bool shouldRebuild(covariant DividerDelegate oldDelegate) {
    return false;
  }
}
