import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navatech_assignment/album_list/bloc/album_list_bloc.dart';
import 'package:navatech_assignment/album_list/presentation/album_list_route.dart';
import 'package:navatech_assignment/dependency_injector/dependency_injector.dart';
import 'package:navatech_assignment/generated/l10n.dart';

void main() {
  runZonedGuarded(
    () {
      WidgetsFlutterBinding.ensureInitialized();
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
      if (!kDebugMode) debugPrint = (_, {int? wrapWidth}) => {};
      runApp(const ExampleApp());
    },
    (error, stack) {
      debugPrint("Zone error caught: $error, trace: $stack");
    },
  );
}

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
            albumRepository: DependencyInjector().get(),
          )..add(FetchAlbumsList());
        },
        child: const AlbumListRoute(),
      ),
    );
  }
}
