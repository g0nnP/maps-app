import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapas_app/blocs/gps/gps_bloc.dart';
import 'package:mapas_app/screens/gps_access_screen.dart';
import 'package:mapas_app/screens/map_screen.dart';

class LoadingScreen extends StatelessWidget {

  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GpsBloc, GpsState>(
        builder: (_, state) {
          final currentState = state as GpsInitialState;

          if(currentState.allIsGranted){
            return const MapScreen();
          } else {
            return const GpsAcessScreen();
          }
        }
      )
    );
  }

}