import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_ease/core/local/local_repository.dart';

part 'admin_event.dart';
part 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  final LocalDetailsRepository _localDetailsRepository;

  AdminBloc(this._localDetailsRepository) : super(AdminInitial()) {
    on<LogoutAdminEvent>(_onAdminLogoutEvent);
  }

  FutureOr<void> _onAdminLogoutEvent(
      LogoutAdminEvent event, Emitter<AdminState> emit) {
    try {
      _localDetailsRepository.clearAllLocalData();
      emit(AdminSuccessState());
    } catch (e) {
      emit(AdminErrorState(errorMessage: e.toString()));
    }
  }
}
