// This UserBloc has a constructor where we pass the repository. Because we are going to call this from the UI. As we call this class we pass the UserRepository to it.
// As we have used the Bloc we need to pass the initial state to the super constructor.
// After call the initial value we are calling on method.

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_flutter/blocs/app_events.dart';
import 'package:personal_flutter/blocs/app_states.dart';
import 'package:personal_flutter/network/repo/repositories.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;

  UserBloc(this._userRepository) : super(UserLoadingState()) {
    on<LoadUserEvent>((event, emit) async {
      emit(UserLoadingState());
      try {
        final users = await _userRepository.getUsers();
        emit(UserLoadedState(users));
      } catch (e) {
        emit(UserErrorState(e.toString()));
      }
    });
  }
}
