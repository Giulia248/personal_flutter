// As like state we have to extends the equitable to the event. We need to create the dedicated class for each event.
// The event class should extends the base class. Here our base class is MealEvent. And the event is LoadMealEvent.
// And override the get props.

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class MealEvent extends Equatable {
  const MealEvent();
}

class LoadMealEvent extends MealEvent {
  @override
  List<Object?> get props => [];
}
