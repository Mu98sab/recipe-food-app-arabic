import 'package:flutter/material.dart';
import 'package:recipe/Model/database.dart';
import 'package:recipe/View/Component/recipe_slide.dart';
import 'package:recipe/View/Component/search_bar.dart';

class Home extends StatelessWidget {
  Home({
    Key? key,
    // @required this.referesh,
  }) : super(key: key);

  late ThemeData theme;

  // final Function? referesh;
  late Color test ;//Color(0xffffcba4);
  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    test = theme.backgroundColor;

    //TODO: change it to custom scroll and make the search as sliver app bar

    return Expanded(
      child: Container(
        // margin: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          color: test, //theme.backgroundColor,
          // borderRadius: BorderRadius.only(
          //   topLeft: const Radius.circular(50),
          //   topRight: const Radius.circular(50),
          // ),
        ),
        clipBehavior: Clip.antiAlias,
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              backgroundColor: theme.primaryColor,
              flexibleSpace: Container(
                child: SearchBar(),
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top: 10),
              ),
              // stretch: true,
              stretchTriggerOffset: 1,
              stretch: true,
              floating: true,
              onStretchTrigger: () async {
                print("hhhhhhhhhhhhhhhhhhhhhh");
              },
            ),
            SliverToBoxAdapter(
              child: Container(
                color: theme.primaryColor,
                child: Container(
                  margin: const EdgeInsets.only(top: 15),
                  decoration: BoxDecoration(
                    color: test,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(50),
                      topRight: const Radius.circular(50),
                    ),
                  ),
                  padding: const EdgeInsets.only(
                    right: 30,
                    top: 20,
                  ),
                  child: Text(
                    "الأكثر شهرة",
                    textDirection: TextDirection.rtl,
                    style: theme.textTheme.headline2?.copyWith(
                      color: theme.accentColor.withOpacity(.8),
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                color: test,
                child: RecipesSlide(
                  query: RecipeQuery.mostPopular,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                color: test,
                padding: const EdgeInsets.only(
                  right: 30,
                  top: 0,
                ),
                child: Text(
                  "الأحدث",
                  textDirection: TextDirection.rtl,
                  style: theme.textTheme.headline2?.copyWith(
                    color: theme.accentColor.withOpacity(.8),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                color: test,
                child: RecipesSlide(
                  query: RecipeQuery.newest,
                ),
              ),
            ),
          ],
        ),
      ),
    );

    // return Expanded(
    //   child: SingleChildScrollView(
    //     physics: const BouncingScrollPhysics(),
    //     child: Container(
    //       child: Column(
    //         textDirection: TextDirection.rtl,
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Padding(
    //             padding: const EdgeInsets.only(
    //               right: 30,
    //               top: 20,
    //             ),
    //             child: Text(
    //               "الأكثر شهرة",
    //               textDirection: TextDirection.rtl,
    //               style: theme.textTheme.headline2?.copyWith(
    //                     color:
    //                         theme.accentColor.withOpacity(.8),
    //                   ),
    //             ),
    //           ),
    //           RecipesSlide(
    //             query: RecipeQuery.mostPopular,
    //           ),
    //           Padding(
    //             padding: const EdgeInsets.only(
    //               right: 30,
    //               top: 0,
    //             ),
    //             child: Text(
    //               "الأحدث",
    //               textDirection: TextDirection.rtl,
    //               style: theme.textTheme.headline2?.copyWith(
    //                     color:
    //                         theme.accentColor.withOpacity(.8),
    //                   ),
    //             ),
    //           ),
    //           RecipesSlide(
    //             query: RecipeQuery.newest,
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
