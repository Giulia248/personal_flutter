import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_flutter/blocs/meal/meal_blocs.dart';
import 'package:personal_flutter/blocs/meal/meal_events.dart';
import 'package:personal_flutter/blocs/meal/meal_states.dart';
import 'package:personal_flutter/network/models/meal_model.dart';
import 'package:personal_flutter/network/repo/repositories.dart';
import 'package:personal_flutter/ui/meals/meal_category_page.dart';
import 'package:personal_flutter/utils/utils.dart';

class MealRandomPage extends StatelessWidget {
  const MealRandomPage({super.key});

  static const String title = "Random recipe";
  static const String desc = "Random meal showcase!";

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MealBloc>(
          create: (BuildContext context) =>
              MealBloc(MealRepository(), MealEnum.recipes, "NO"),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(title: Text(title)),
        body: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(desc),
                Expanded(child: _randomBody()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _randomBody() {
  return BlocProvider(
    create: (context) =>
        MealBloc(MealRepository(), MealEnum.random, "NO")..add(LoadMealEvent()),
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
          debugPrint("LOADED ✅  ${state.meals.length} ");

          return RandomMealView(meal: state.meals.first);
        }
        return Container();
      },
    ),
  );
}

/// Shows the random meal card and a button that reveals the recipes of the
/// meal's category underneath, using a simple StatefulWidget flag.
class RandomMealView extends StatefulWidget {
  const RandomMealView({super.key, required this.meal});

  final MealModel meal;

  @override
  State<RandomMealView> createState() => _RandomMealViewState();
}

class _RandomMealViewState extends State<RandomMealView> {
  bool _showCategory = false;

  @override
  Widget build(BuildContext context) {
    final meal = widget.meal;
    final category = meal.strCategory;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            color: Theme.of(context).primaryColor,
            child: ListTile(
              title: Text(
                '${meal.strMeal} Country: ${meal.strCountry}',
                style: const TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                '${meal.strInstructions}...',
                maxLines: 6,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Color.fromARGB(255, 196, 172, 236),
                ),
              ),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(meal.strMealThumb.toString()),
              ),
            ),
          ),
        ),
        if (category != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: OutlinedButton(
              onPressed: () => setState(() => _showCategory = !_showCategory),
              child: Text(
                _showCategory ? 'Hide $category' : 'Search in this category',
              ),
            ),
          ),
        if (_showCategory && category != null)
          Expanded(child: MealRecipesList(category: category)),
      ],
    );
  }
}
