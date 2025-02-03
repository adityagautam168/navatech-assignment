import 'package:flutter/material.dart';

void main() => runApp(const ExampleApp());

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyWidget(),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final UniqueKey _center = UniqueKey();
  final AxisDirection _axisDirection = AxisDirection.down;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Infinite List Demo'),
      ),
      body: CustomScrollView(
        reverse: axisDirectionIsReversed(_axisDirection),
        scrollDirection: axisDirectionToAxis(_axisDirection),
        anchor: 0.5,
        center: _center,
        slivers: <Widget>[
          _getList(isForward: false),
          SliverToBoxAdapter(
            key: _center,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  '0',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          _getList(isForward: true),
        ],
      ),
    );
  }

  Widget _getList({required bool isForward}) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (context, index) {
          return Container(
            color: isForward
                ? (index.isEven ? Colors.amber[100] : Colors.amberAccent)
                : (index.isEven ? Colors.green[100] : Colors.lightGreen),
            padding: const EdgeInsets.all(8.0),
            child: Center(child: Text(index.toString())),
          );
        },
      ),
    );
  }
}
