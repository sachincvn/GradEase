part of 'landing_page_bloc.dart';

@immutable
abstract class LandingPageState {
  final int tabIndex;

  const LandingPageState({required this.tabIndex});
}

class LandingPageInitial extends LandingPageState {
  const LandingPageInitial({required super.tabIndex});
}
