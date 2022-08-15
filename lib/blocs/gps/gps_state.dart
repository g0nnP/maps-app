part of 'gps_bloc.dart';

abstract class GpsState extends Equatable {

  const GpsState();

  @override
  List<Object> get props => [];
}

class GpsInitialState extends GpsState {

  const GpsInitialState({
    required this.gpsIsEnabled,
    required this.gpsPermissionIsGranted
  });

  final bool gpsIsEnabled;
  final bool gpsPermissionIsGranted;

  bool get allIsGranted => gpsIsEnabled && gpsPermissionIsGranted;

  GpsInitialState copyWith({
    bool? gpsIsEnabled,
    bool? gpsPermissionIsGranted
  }) => GpsInitialState(
    gpsIsEnabled: gpsIsEnabled ?? this.gpsIsEnabled,
    gpsPermissionIsGranted: gpsPermissionIsGranted ?? this.gpsIsEnabled
  );

  @override
  List<Object> get props => [gpsIsEnabled, gpsPermissionIsGranted];

}

