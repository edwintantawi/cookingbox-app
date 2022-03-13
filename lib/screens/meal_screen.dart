import 'package:flutter/material.dart';

import 'package:cookingbox_app/domains/meal.dart';
import 'package:cookingbox_app/services/the_meal_db_api.dart';
import 'package:cookingbox_app/widgets/app_shell.dart';
import 'package:cookingbox_app/domains/meal_category.dart';

class MealsScreen extends StatefulWidget {
  final MealCategory category;

  const MealsScreen({Key? key, required this.category}) : super(key: key);

  @override
  _MealsScreen createState() => _MealsScreen();
}

class _MealsScreen extends State<MealsScreen> {
  late Future<List<Meal>> meals;

  @override
  void initState() {
    super.initState();
    meals = fetchMealsByCategory(widget.category.title);
  }

  @override
  Widget build(BuildContext context) {
    return AppShell(
      title: Text('${widget.category.title} meal\'s'),
      body: Center(
        child: FutureBuilder<List<Meal>>(
          future: meals,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data == null) {
                return const Text('Oops its empty...');
              }

              return GridView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 16,
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: MediaQuery.of(context).size.width / 360,
                ),
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8),
                        ),
                        child: Image.network(
                          snapshot.data![index].image,
                          height: MediaQuery.of(context).size.width / 2 / 1.5,
                          width: MediaQuery.of(context).size.width / 2,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.only(top: 8, bottom: 2),
                        child: Text(
                          snapshot.data![index].title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          softWrap: true,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
