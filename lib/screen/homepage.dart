import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                const SliverAppBar(
                  centerTitle: false,
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.transparent,
                  title: Text(
                    '\$26.710',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300),
                  ),
                ),
                ...[
                  SliverPersistentHeader(
                    delegate: _MyHeaderTitle((visible) {}, 'This'),
                  ),
                  SliverList(
                      delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return ListTile(
                        title: Text(
                          'Title : $index',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                    childCount: 30,
                  ))
                ]
              ],
            ),
            Positioned(
              right: 10,
              top: 0,
              child: CircleAvatar(
                backgroundColor: Colors.grey[800],
                child: const Icon(Icons.compare_arrows_rounded),
              ),
            )
          ],
        ),
      ),
    );
  }
}

const maxHeaderTitleHeight = 55.0;
typedef OnHeaderChanged = void Function(bool visible);

class _MyHeaderTitle extends SliverPersistentHeaderDelegate {
  _MyHeaderTitle(this.onHeaderChanged, this.title);
  final OnHeaderChanged onHeaderChanged;
  final String title;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w400,
          color: Colors.white,
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
