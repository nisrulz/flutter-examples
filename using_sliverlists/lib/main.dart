import 'package:flutter/material.dart';
import 'dart:math' as math;
void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Collapsible List Demo Using Slivers',),
            backgroundColor: Colors.black,

          ),
          body: CollapsingList(),
        ),
      ),
    );
  }
}
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });
  final double minHeight;
  final double maxHeight;
  final Widget child;
  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => math.max(maxHeight, minHeight);
  @override
  Widget build(
      BuildContext context,
      double shrinkOffset,
      bool overlapsContent)
  {
    return new SizedBox.expand(child: child);
  }
  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
class CollapsingList extends StatelessWidget {
  SliverPersistentHeader header_maker(String headerText) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverAppBarDelegate(
        minHeight: 80.0,
        maxHeight: 200.0,
        child: Container(
            color: Colors.black, child: Center(child:
        Text(headerText,style: TextStyle(fontStyle: FontStyle.italic,fontSize: 20,color: Colors.white,fontWeight: FontWeight.w600),))),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        header_maker('Header Section 1'),
        SliverGrid.count(
          crossAxisCount: 2,
          children: [
            Container(color: Colors.blue[100], height: 150.0),
            Container(color: Colors.blue[200], height: 150.0),
            Container(color: Colors.blue[300], height: 150.0),
            Container(color: Colors.blue[400], height: 150.0),
            Container(color: Colors.blue[500], height: 150.0),
            Container(color: Colors.blue[100], height: 150.0),
            Container(color: Colors.cyan, height: 150.0),
            Container(color: Colors.indigo, height: 150.0),

          ],
        ),
        header_maker('Header Section 2'),
        SliverFixedExtentList(
          itemExtent: 150.0,
          delegate: SliverChildListDelegate(
            [
              Container(color: Colors.green[400]),
              Container(color: Colors.green[600]),
              Container(color: Colors.green[800]),
              Container(color: Colors.green[900]),
              Container(color: Colors.lightGreen),
            ],
          ),
        ),
        header_maker('Header Section 3'),
        SliverGrid(
          gridDelegate:
          new SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 250.0,
            mainAxisSpacing: 15.0,
            crossAxisSpacing: 15.0,
            childAspectRatio: 2.0,
          ),
          delegate: new SliverChildBuilderDelegate(
                (BuildContext context, int index) {
              return new Container(
                alignment: Alignment.center,
                color: Colors.deepOrange[100*(index%9)],//Colors.teal[100 * (index % 9)],
                child: new Text('grid item $index'),
              );
            },
            childCount: 12,
          ),
        ),

      ],
    );
  }
}