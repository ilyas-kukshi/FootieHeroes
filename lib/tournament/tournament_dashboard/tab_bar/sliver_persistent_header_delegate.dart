import 'package:flutter/material.dart';

class SliverPersistentHeaderDelegateTournamentMain
    extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;
  final Color color;

  const SliverPersistentHeaderDelegateTournamentMain({
    this.color = Colors.transparent,
    required this.tabBar,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: color,
      child: tabBar,
    );
  }

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
