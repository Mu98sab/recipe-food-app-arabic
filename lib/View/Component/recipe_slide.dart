import 'package:flutter/material.dart';
import 'package:recipe/Model/database.dart';
import 'package:recipe/Model/recipe.dart';
import 'package:recipe/View/Component/net_img.dart';
import 'package:recipe/View/recipe_page.dart';

class RecipesSlide extends StatelessWidget {
  const RecipesSlide({Key? key, this.query}) : super(key: key);

  final RecipeQuery? query;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FutureBuilder<List<Recipe>?>(
      future: Database().getRecipe(query: query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // _recipes = snapshot.data as List<Recipe>;
          return SizedBox(
            height: 215,
            child: (snapshot.data!.length) > 0 ? ListView.builder(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.only(
                right: 20,
                top: 12,
                left: 20,
              ),
              reverse: true,
              itemCount: snapshot.data?.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int i) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => RecipePage(recipe: snapshot.data?[i])));
                      Database().incViews(snapshot.data?[i].id, snapshot.data?[i].visit);
                    },
                    child: Column(
                      textDirection: TextDirection.rtl,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        NetImage(
                          imgName: snapshot.data?[i].img,
                          width: 200,
                          height: 150,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 5,
                          ),
                          child: Text(
                            snapshot.data?[i].name ?? "",
                            style:
                                Theme.of(context).textTheme.bodyText1?.copyWith(
                                      color: Theme.of(context).accentColor,
                                    ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
            : Center(child: Text("لا توجد وصفات"),),
          );
        } else if (snapshot.hasError) {
          return Expanded(
            child: Center(
              child: Row(
                textDirection: TextDirection.rtl,
                children: [
                  Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.red,
                  ),
                  Text("  خطأ في الحصول على البيانات"),
                ],
              ),
            ),
          );
        } else {
          return SizedBox(
            height: 215,
            child: Center(
              child: CircularProgressIndicator(
                color: theme.accentColor,
              ),
            ),
          );
        }
      },
    );
  }
}
