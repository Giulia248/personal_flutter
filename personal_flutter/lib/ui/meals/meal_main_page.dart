import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_flutter/blocs/meal/meal_blocs.dart';
import 'package:personal_flutter/blocs/meal/meal_events.dart';
import 'package:personal_flutter/blocs/meal/meal_states.dart';
import 'package:personal_flutter/network/models/meal_model.dart';
import 'package:personal_flutter/network/repo/repositories.dart';
import 'package:personal_flutter/utils/utils.dart';

class MealMainPage extends StatelessWidget {
  const MealMainPage({super.key});

  static const String description =
      "Welcome to TheMealDB: An open, crowd-sourced database of recipes from around the world.";
  static const String description2 =
      "Select a category to show some recipes🥨🥗";

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MealBloc>(
          create: (BuildContext context) =>
              MealBloc(MealRepository(), MealEnum.category, "NO"),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(title: Text("Meal DB API")),
        body: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  description,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  description2,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Expanded(child: blocBody()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget blocBody() {
  return BlocProvider(
    create: (context) =>
        MealBloc(MealRepository(), MealEnum.category, "NO")
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
        if (state is CatLoadedState) {
          List<CategoryModel> categories = state.categories;
          categories.shuffle();
          debugPrint("LOADED ✅  ${categories.length} ");

          return ListView.builder(
            itemCount: categories.length,
            itemBuilder: (_, index) {
              final String desc = Utils.truncate(
                categories[index].strCategoryDescription ?? '',
                88,
              );
              return Padding(
                padding: EdgeInsetsGeometry.all(8.0),
                child: Card(
                  color: Theme.of(context).primaryColor,
                  child: ListTile(
                    title: Text(
                      '${categories[index].strCategory} ID: ${categories[index].idCategory}',
                      style: const TextStyle(color: Colors.white),
                    ),

                    subtitle: Text(
                      'Meal id: ${desc}',
                      style: const TextStyle(
                        color: Color.fromARGB(255, 196, 172, 236),
                      ),
                    ),

                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        categories[index].strCategoryThumb.toString(),
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
