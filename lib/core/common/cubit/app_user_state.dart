part of 'app_user_cubit.dart';

@immutable
sealed class AppUserState {}

final class AppUserInitial extends AppUserState {}

final class AppUserLoggedIn extends AppUserState {
  final AuthDetailEntity studentEntity;
  AppUserLoggedIn(this.studentEntity);
}

final class AppAdminLogedIn extends AppUserState {}
