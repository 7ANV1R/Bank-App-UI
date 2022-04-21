import 'package:bank_app/screen/List/my_header_title.dart';
import 'package:flutter/material.dart';

class StatsList extends StatefulWidget {
  const StatsList({Key? key}) : super(key: key);

  @override
  State<StatsList> createState() => _StatsListState();
}

class _StatsListState extends State<StatsList> {
  final headerNotifier = ValueNotifier<StickyTitle?>(null);

  void refreshHeader(String title, bool visible, {String? lastOne}) {
    final headerValue = headerNotifier.value;
    final headerTitle = headerValue?.title ?? title;
    final headerVisible = headerValue?.visible ?? visible;

    if (headerTitle != title || headerVisible != visible || lastOne != null) {
      Future.microtask(() {
        if (!visible && lastOne != null) {
          headerNotifier.value = StickyTitle(title: title, visible: true);
        } else {
          headerNotifier.value = StickyTitle(title: title, visible: visible);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                const SliverAppBar(
                  automaticallyImplyLeading: false,
                  title: Text(
                    'AppBar',
                    style: TextStyle(color: Colors.black),
                  ),
                  backgroundColor: Colors.transparent,
                ),
                ...[
                  SliverPersistentHeader(
                    delegate: MyHeaderTitle(
                        onHeaderChanged: (visible) {
                          refreshHeader('A', visible);
                        },
                        title: 'A'),
                  ),
                  SliverList(
                      delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return ListTile(
                        title: Text(
                          'Title : $index',
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      );
                    },
                    childCount: 10,
                  ))
                ],
                ...[
                  SliverPersistentHeader(
                    delegate: MyHeaderTitle(
                        onHeaderChanged: (visible) {
                          refreshHeader('B', visible, lastOne: 'A');
                        },
                        title: 'B'),
                  ),
                  SliverList(
                      delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return ListTile(
                        title: Text(
                          'Title : $index',
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      );
                    },
                    childCount: 10,
                  ))
                ],
                ...[
                  SliverPersistentHeader(
                    delegate: MyHeaderTitle(
                        onHeaderChanged: (visible) {
                          refreshHeader('C', visible, lastOne: 'B');
                        },
                        title: 'C'),
                  ),
                  SliverList(
                      delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return ListTile(
                        title: Text(
                          'Title : $index',
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      );
                    },
                    childCount: 10,
                  ))
                ],
                ...[
                  SliverPersistentHeader(
                    delegate: MyHeaderTitle(
                        onHeaderChanged: (visible) {
                          refreshHeader('D', visible, lastOne: 'C');
                        },
                        title: 'D'),
                  ),
                  SliverList(
                      delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return ListTile(
                        title: Text(
                          'Title : $index',
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      );
                    },
                    childCount: 20,
                  ))
                ],
              ],
            ),
            ValueListenableBuilder<StickyTitle?>(
                valueListenable: headerNotifier,
                builder: (context, snapshot, _) {
                  final visible = snapshot?.visible ?? false;
                  final title = snapshot?.title ?? '';
                  return Positioned(
                    left: 15,
                    right: 0,
                    top: 0,
                    child: visible
                        ? Text(
                            title,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
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
