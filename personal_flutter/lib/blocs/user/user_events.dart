// As like state we have to extends the equitable to the event. We need to create the dedicated class for each event.
// The event class should extends the base class. Here our base class is UserEvent. And the event is LoadUserEvent.
// And override the get props.

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class UserEvent extends Equatable {
  const UserEvent();
}

class LoadUserEvent extends UserEvent {
  @override
  List<Object?> get props => [];
}
