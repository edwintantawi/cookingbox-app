import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
    double screenWidth = MediaQuery.of(context).size.width;

    int getGridCount() {
      if (screenWidth < 520) {
        return 2;
      } else if (screenWidth < 1000) {
        return 3;
      } else if (screenWidth < 1200) {
        return 4;
      } else {
        return 6;
      }
    }

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
                  crossAxisCount: getGridCount(),
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                ),
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Stack(
                    clipBehavior: Clip.antiAlias,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: snapshot.data![index].image,
                          width: screenWidth,
                          fit: BoxFit.cover,
                          progressIndicatorBuilder: (context, url, progress) =>
                              Center(
                            child: CircularProgressIndicator(
                              value: progress.progress,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            bottom: Radius.circular(8),
                          ),
                          child: Container(
                            clipBehavior: Clip.antiAlias,
                            alignment: Alignment.topLeft,
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 10,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                            ),
                            child: Text(
                              snapshot.data![index].title,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              softWrap: true,
                              style: const TextStyle(
                                fontSize: 12,
                                letterSpacing: 1,
                                color: Colors.white,
                              ),
                            ),
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
