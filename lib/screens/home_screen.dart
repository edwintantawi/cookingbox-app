import 'package:cookingbox_app/screens/meal_screen.dart';
import 'package:cookingbox_app/widgets/app_shell.dart';
import 'package:flutter/material.dart';
import 'package:cookingbox_app/domains/meal_category.dart';
import 'package:cookingbox_app/services/the_meal_db_api.dart';

class HomeScreen extends StatefulWidget {
  final String title;

  const HomeScreen({Key? key, required this.title}) : super(key: key);

  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  late Future<List<MealCategory>> mealCategories;

  @override
  void initState() {
    super.initState();
    mealCategories = fetchMealCategories();
  }

  @override
  Widget build(BuildContext context) {
    return AppShell(
      title: Text(widget.title),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Center(
              child: FutureBuilder<List<MealCategory>>(
                future: mealCategories,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data == null) {
                      return const Text('Oops its empty...');
                    }

                    return ListView.separated(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      itemCount: snapshot.data!.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider();
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          visualDensity: VisualDensity.comfortable,
                          trailing: const Icon(Icons.arrow_right_outlined),
                          iconColor: Theme.of(context).primaryColor,
                          title: Text(snapshot.data![index].title),
                          leading: Image.network(
                            snapshot.data![index].image,
                            width: 60,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MealsScreen(
                                  category: snapshot.data![index],
                                ),
                              ),
                            );
                          },
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
          ),
        ],
      ),
    );
  }
}
