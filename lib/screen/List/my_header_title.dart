// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

const maxHeaderTitleHeight = 55.0;
typedef OnHeaderChanged = void Function(bool visible);

class StickyTitle {
  const StickyTitle({
    required this.title,
    required this.visible,
  });
  final String title;
  final bool visible;
}

class MyHeaderTitle extends SliverPersistentHeaderDelegate {
  final OnHeaderChanged onHeaderChanged;
  final String title;
  MyHeaderTitle({
    required this.onHeaderChanged,
    required this.title,
  });
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    if (shrinkOffset > 0) {
      onHeaderChanged(true);
    } else {
      onHeaderChanged(false);
    }
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => maxHeaderTitleHeight;

  @override
  double get minExtent => maxHeaderTitleHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}
