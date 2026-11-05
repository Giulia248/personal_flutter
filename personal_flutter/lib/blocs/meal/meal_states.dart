// Equatable is used to compare the values wether they are same or not. If two variable have the same values we are not going to change or update UI.

// First to create the state we need to create the abstract class which needs to extends the equatable.

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:personal_flutter/network/models/meal_model.dart';

@immutable
abstract class MealState extends Equatable {}

class MealLoadingState extends MealState {
  @override
  List<Object?> get props => [];
}

class MealLoadedState extends MealState {
  final List<MealModel> meals;
  MealLoadedState(this.meals);
  @override
  List<Object?> get props => [meals];
}

class CatLoadedState extends MealState {
  final List<CategoryModel> categories;
  CatLoadedState(this.categories);
  @override
  List<Object?> get props => [categories];
}

class MealErrorState extends MealState {
  final String error;
  MealErrorState(this.error);
  @override
  List<Object?> get props => [error];
}
