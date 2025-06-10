part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final User user;
  AuthSuccess(this.user);
  @override
  List<Object?> get props => [user];
}

class AuthFailure extends AuthState {
  final String message;
  AuthFailure(this.message);
  @override
  List<Object?> get props => [message];
}

class AuthLoggedOut extends AuthState {}

class AuthEmailNotVerified extends AuthState {
  final String message;
  AuthEmailNotVerified(this.message);
  @override
  List<Object?> get props => [message];
}

class AuthPasswordResetEmailSent extends AuthState {
  final String message;
  AuthPasswordResetEmailSent(this.message);
  @override
  List<Object?> get props => [message];
}

class AuthUserNotFound extends AuthState {
  final String message;
  AuthUserNotFound(this.message);
  @override
  List<Object?> get props => [message];
}
