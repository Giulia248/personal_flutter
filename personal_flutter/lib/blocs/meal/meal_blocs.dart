// This MealBloc has a constructor where we pass the repository. Because we are going to call this from the UI. As we call this class we pass the MealRepository to it.
// As we have used the Bloc we need to pass the initial state to the super constructor.
// After call the initial value we are calling on method.

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_flutter/blocs/meal/meal_events.dart';
import 'package:personal_flutter/blocs/meal/meal_states.dart';
import 'package:personal_flutter/network/models/meal_model.dart';

import 'package:personal_flutter/network/repo/repositories.dart';

class MealBloc extends Bloc<MealEvent, MealState> {
  final MealRepository _mealRepository;
  final MealEnum type;
  final String cat;

  MealBloc(this._mealRepository, this.type, this.cat)
    : super(MealLoadingState()) {
    switch (type) {
      case MealEnum.random:
        on<LoadMealEvent>((event, emit) async {
          emit(MealLoadingState());
          try {
            final meals = await _mealRepository.getRandomMeal();
            emit(MealLoadedState(meals));
          } catch (e) {
            emit(MealErrorState(e.toString()));
          }
        });
      case MealEnum.category:
        on<LoadMealEvent>((event, emit) async {
          emit(MealLoadingState());
          try {
            final cat = await _mealRepository.getAllCat();
            emit(CatLoadedState(cat));
          } catch (e) {
            emit(MealErrorState(e.toString()));
          }
        });
      case MealEnum.recipes:
        on<LoadMealEvent>((event, emit) async {
          emit(MealLoadingState());
          try {
            final meals = await _mealRepository.getMeal(cat);
            emit(MealLoadedState(meals));
          } catch (e) {
            emit(MealErrorState(e.toString()));
          }
        });
    }
  }
}
