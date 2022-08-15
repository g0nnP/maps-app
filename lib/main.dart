import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapas_app/blocs/blocs.dart';

import 'screens/screens.dart';

void main() => runApp(const MapsApp());

class MapsApp extends StatelessWidget {

  const MapsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => GpsBloc(),
        ),
        BlocProvider(
          create: (_) => LocationBloc(),
        )
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Maps App',
        home: LoadingScreen()
      ),
    );
  }
}