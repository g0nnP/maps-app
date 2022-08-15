import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapas_app/blocs/gps/gps_bloc.dart';

class GpsAcessScreen extends StatelessWidget {
  const GpsAcessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          ScreenBackground(size: size),
          Center(child: EnableGpsMessage(size: size)),
        ],
      )
    );
  }
}

class ScreenBackground extends StatelessWidget {
  const ScreenBackground({
    Key? key,
    required this.size
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: size.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/mapppp.png'),
          fit: BoxFit.cover
        )
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.transparent
          ),
        ),
      ),
    );
  }
}

class EnableGpsMessage extends StatelessWidget {

  const EnableGpsMessage({
    Key? key,
    required this.size
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {

    return Container(
      height: size.height * 0.25,
      width: size.width * 0.7,
      decoration: BoxDecoration(
        color: Colors. white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Active su ubicación por favor', style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700
            ),),
            const Icon(Icons.location_on, size: 60,),
            BlocBuilder<GpsBloc, GpsState>(
              builder: (_, state) {

                final currentState = state as GpsInitialState;

                if(currentState.gpsPermissionIsGranted) {
                  return const SizedBox.shrink();
                } else {
                  return ElevatedButton(
                    onPressed: (){

                      context.read<GpsBloc>().requestGpsAccess();

                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      )
                    ),
                    child: const Text('Solicitar acceso')
                  );
                }
              }
            )
          ],
        )
      ),
    );
  }
}