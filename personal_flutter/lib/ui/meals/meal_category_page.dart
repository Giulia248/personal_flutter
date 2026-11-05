import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_flutter/blocs/meal/meal_blocs.dart';
import 'package:personal_flutter/blocs/meal/meal_events.dart';
import 'package:personal_flutter/blocs/meal/meal_states.dart';
import 'package:personal_flutter/network/models/meal_model.dart';
import 'package:personal_flutter/network/repo/repositories.dart';
import 'package:personal_flutter/utils/utils.dart';

class MealCategoryPage extends StatelessWidget {
  const MealCategoryPage({super.key, required this.categoryInput});

  final String categoryInput;

  String get title => "You selected $categoryInput";

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MealBloc>(
          create: (BuildContext context) =>
              MealBloc(MealRepository(), MealEnum.recipes, categoryInput),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(title: Text("Recipes by category")),
        body: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title),
                Expanded(child: MealRecipesList(category: categoryInput)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MealRecipesList extends StatelessWidget {
  const MealRecipesList({super.key, required this.category});

  final String category;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          MealBloc(MealRepository(), MealEnum.recipes, category)
            ..add(LoadMealEvent()),
      child: BlocBuilder<MealBloc, MealState>(
        builder: (context, state) {
          if (state is MealLoadingState) {
            debugPrint("LOADING  ... ");
            return const Center(child: CircularProgressIndicator());
          }

          if (state is MealErrorState) {
            debugPrint("ERROR 💀${state.error}");
            return Center(child: Text("Error: ${state.error}"));
          }
          if (state is MealLoadedState) {
            final List<MealModel> meals = (List.of(
              state.meals,
            )..shuffle()).take(8).toList();
            debugPrint("LOADED ✅  ${meals.length} ");

            return ListView.builder(
              itemCount: meals.length,
              itemBuilder: (_, index) {
                return Padding(
                  padding: EdgeInsetsGeometry.all(8.0),
                  child: Card(
                    color: Theme.of(context).primaryColor,
                    child: ListTile(
                      title: Text(
                        '${meals[index].strMeal} Country: ${meals[index].strCountry}',
                        style: const TextStyle(color: Colors.white),
                      ),

                      subtitle: Text(
                        'Meal id: ${meals[index].idMeal}',
                        style: const TextStyle(
                          color: Color.fromARGB(255, 196, 172, 236),
                        ),
                      ),

                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                          meals[index].strMealThumb.toString(),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
