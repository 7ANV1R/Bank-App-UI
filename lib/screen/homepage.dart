import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final headerNotifier = ValueNotifier<_MyHeader?>(null);

  void _refreshHeader(String title, bool visible, {String? lastOne}) {
    final headerValue = headerNotifier.value;
    final headerTitle = headerValue?.title ?? title;
    final headerVisible = headerValue?.visible ?? visible;

    //TODO: Review this if else logic

    if (headerTitle != title || headerVisible != visible || lastOne != null) {
      Future.microtask(() {
        if (!visible && lastOne != null) {
          headerNotifier.value = _MyHeader(title: lastOne, visible: true);
        } else {
          headerNotifier.value = _MyHeader(title: title, visible: visible);
        }
      });
    }
  }

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
                    delegate: _MyHeaderTitle((visible) {
                      _refreshHeader('April', visible);
                    }, 'Latest Transaction'),
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
                    childCount: 10,
                  ))
                ],
                ...[
                  SliverPersistentHeader(
                    delegate: _MyHeaderTitle((visible) {
                      _refreshHeader('March', visible, lastOne: 'April');
                    }, 'March'),
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
                    childCount: 10,
                  ))
                ],
                ...[
                  SliverPersistentHeader(
                    delegate: _MyHeaderTitle((visible) {
                      _refreshHeader('February', visible, lastOne: 'March');
                    }, 'February'),
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
                    childCount: 10,
                  ))
                ],
                ...[
                  SliverPersistentHeader(
                    delegate: _MyHeaderTitle((visible) {
                      _refreshHeader('January', visible, lastOne: 'February');
                    }, 'January'),
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
                    childCount: 10,
                  ))
                ],
                ...[
                  SliverPersistentHeader(
                    delegate: _MyHeaderTitle((visible) {
                      _refreshHeader('December', visible, lastOne: 'January');
                    }, 'December'),
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
                    childCount: 20,
                  ))
                ]
              ],
            ),
            ValueListenableBuilder<_MyHeader?>(
                valueListenable: headerNotifier,
                builder: (context, snapshot, _) {
                  final visible = snapshot?.visible ?? false;
                  final title = snapshot?.title ?? '';
                  return Positioned(
                    left: 15,
                    right: 0,
                    top: 0,
                    child: visible
                        ? DecoratedBox(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.7),
                            ),
                            child: Text(
                              title,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                  );
                }),
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

class _MyHeader {
  const _MyHeader({
    required this.title,
    required this.visible,
  });
  final String title;
  final bool visible;
}

const maxHeaderTitleHeight = 55.0;
typedef OnHeaderChanged = void Function(bool visible);

class _MyHeaderTitle extends SliverPersistentHeaderDelegate {
  _MyHeaderTitle(this.onHeaderChanged, this.title);
  final OnHeaderChanged onHeaderChanged;
  final String title;

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
            color: Colors.white,
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
