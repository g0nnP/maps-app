import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

part 'gps_event.dart';
part 'gps_state.dart';

class GpsBloc extends Bloc<GpsEvent, GpsState> {

  late StreamSubscription gpsServiceSubscription;

  GpsBloc() : super(const GpsInitialState(
    gpsIsEnabled: false,
    gpsPermissionIsGranted: false
  )) {
    on<GpsPermissionEvent>((event, emit) {
      final currentState = state as GpsInitialState;

      emit(currentState.copyWith(
        gpsIsEnabled: event.gpsIsEnabled,
        gpsPermissionIsGranted: event.gpsPermissionIsGranted
      ));
    });

    _init();

  }

  Future<void> _init() async {

    final isEnabled = await _checkGpsStatus();
    final isGranted = await _checkGpsPermission();
    print('Is enabled: $isEnabled - Is Granted: $isGranted');

    final checkGps = await Future.wait(
      [_checkGpsStatus(), _checkGpsPermission()]
    );

    add(GpsPermissionEvent(checkGps[0], checkGps[1]));                                                             

  }

  Future<bool> _checkGpsStatus() async {
    final currentState = state as GpsInitialState;

    final isEnabled = await Geolocator.isLocationServiceEnabled();

    gpsServiceSubscription = Geolocator.getServiceStatusStream().listen((event){
      final gpsServiceEnabled = (event.index == 1) ? true : false;

      add(GpsPermissionEvent(
        gpsServiceEnabled,
        currentState.gpsPermissionIsGranted
      ));
    });

    return isEnabled;

  }

  Future<bool> _checkGpsPermission() async
    => await Permission.location.isGranted;

  Future<void> requestGpsAccess() async {

    final currentState = state as GpsInitialState;

    final status = await Permission.location.request();

    switch (status) {

      case PermissionStatus.granted:
        add(GpsPermissionEvent(
          currentState.gpsIsEnabled, 
          true
        ));
        break;

      case PermissionStatus.denied:
      case PermissionStatus.limited:
      case PermissionStatus.permanentlyDenied:
      case PermissionStatus.restricted:
        add(GpsPermissionEvent(
          currentState.gpsIsEnabled, 
          false
        ));
        openAppSettings();
        break;

    }

  }

  @override
  Future<void> close() {
    gpsServiceSubscription.cancel();
    return super.close();
  }

}
