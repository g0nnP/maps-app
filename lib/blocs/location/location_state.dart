part of 'location_bloc.dart';

abstract class LocationState extends Equatable {
  const LocationState();
  
  @override
  List<Object> get props => [];
}

class LocationInitial extends LocationState {

  const LocationInitial({
    this.followingUser = false
  });

  final bool followingUser;

  @override
  List<Object> get props => [followingUser];

}
