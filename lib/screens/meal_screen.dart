import 'package:cookingbox_app/domains/meal.dart';
import 'package:cookingbox_app/services/the_meal_db_api.dart';
import 'package:cookingbox_app/widgets/app_shell.dart';
import 'package:flutter/material.dart';
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
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 8,
                    ),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(8),
                          ),
                          child: Image.network(
                            snapshot.data![index].image,
                            height: 120,
                            width: MediaQuery.of(context).size.width / 2,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          height: 65,
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.only(top: 16, bottom: 2),
                          child: Text(
                            snapshot.data![index].title,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            softWrap: true,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
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
