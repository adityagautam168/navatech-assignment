import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navatech_assignment/album_list/bloc/album_list_bloc.dart';
import 'package:navatech_assignment/album_list/domain/album_list_use_case.dart';
import 'package:navatech_assignment/album_list/presentation/album_list_route.dart';
import 'package:navatech_assignment/album_list/repository/album_repository.dart';
import 'package:navatech_assignment/album_list/repository/photo_repository.dart';
import 'package:navatech_assignment/generated/l10n.dart';

void main() => runApp(const ExampleApp());

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        Strings.delegate,
      ],
      home: BlocProvider(
        create: (context) {
          return AlbumListBloc(
            albumListUseCase: AlbumListUseCase(
              // TODO(Aditya): Instantiate these via dependency injection
              albumRepository: AlbumRepositoryImpl(),
              photoRepository: PhotoRepositoryImpl(),
            ),
          )..add(FetchAlbumsList());
        },
        child: const AlbumListRoute(),
      ),
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
