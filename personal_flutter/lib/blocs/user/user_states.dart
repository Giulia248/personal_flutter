// Equatable is used to compare the values wether they are same or not. If two variable have the same values we are not going to change or update UI.

// First to create the state we need to create the abstract class which needs to extends the equatable.

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:personal_flutter/network/models/user_model.dart';

@immutable
abstract class UserState extends Equatable {}

class UserLoadingState extends UserState {
  @override
  List<Object?> get props => [];
}

class UserLoadedState extends UserState {
  final List<UserModel> users;
  UserLoadedState(this.users);
  @override
  List<Object?> get props => [users];
}

class UserErrorState extends UserState {
  final String error;
  UserErrorState(this.error);
  @override
  List<Object?> get props => [error];
}
