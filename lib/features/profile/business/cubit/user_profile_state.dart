part of 'user_profile_cubit.dart';

sealed class UserProfileState extends Equatable {
  const UserProfileState();

  @override
  List<Object> get props => [];
}

final class UserProfileInitial extends UserProfileState {}

class UserProfileLoading extends UserProfileState {}

class UserProfileLoaded extends UserProfileState {
  final ProfileModel profile;
  UserProfileLoaded(this.profile);
}

class UserProfileError extends UserProfileState {
  final String message;
  UserProfileError(this.message);
}

class UserProfileUpdated extends UserProfileState {}

