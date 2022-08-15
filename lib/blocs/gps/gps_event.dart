part of 'gps_bloc.dart';

abstract class GpsEvent extends Equatable {
  const GpsEvent();

  @override
  List<Object> get props => [];
}

class GpsPermissionEvent extends GpsEvent {
  
  const GpsPermissionEvent(this.gpsIsEnabled, this.gpsPermissionIsGranted);

  final bool gpsIsEnabled;
  final bool gpsPermissionIsGranted;

}
