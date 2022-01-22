import 'package:flutter/material.dart';
import 'package:recipe/Model/database.dart';
import 'package:recipe/Model/recipe.dart';

class TypeBar extends StatelessWidget {
  
  TypeBar ({Key? key, @required this.stream}) : super(key: key);

  final List<String> types = [
    // "الكل",
    "حلويات",
    "مشروبات",
    "لحوم",
    "دجاج",
    "مأكولات بحرية",
    "معكرونة",
    "معجنات",
    "صلصات",
    "عيش",
    "وجبات خفيفة",
    "أخرى",
  ];

  final List<RecipeQuery> queries = [
    RecipeQuery.sweet,
    RecipeQuery.drinks,
    RecipeQuery.meat,
    RecipeQuery.chicken,
    RecipeQuery.seaFood,
    RecipeQuery.pasta,
    RecipeQuery.bread,
    RecipeQuery.sauce,
    RecipeQuery.rice,
    RecipeQuery.snacks,
    RecipeQuery.more,
  ];

  // Color textColor = Color(0xff403d52);
  // Color backColor = Color(0xff78d0d3).withOpacity(.7);
  // late Color temp;

  int clicked = -1;
  final TypeState? stream;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return StatefulBuilder(
      builder: (context, StateSetter setState) {
        return SizedBox(
          height: 50,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            reverse: true,
            child: Row(
              textDirection: TextDirection.rtl,
              children: List.generate(
                types.length,
                (indx) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5,
                    ),
                    child: ActionChip(
                      label: Text(
                        types[indx],
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          color: clicked == indx ? theme.indicatorColor : theme.accentColor,
                        ),
                      ),
                      backgroundColor: clicked == indx ? theme.primaryColor : theme.indicatorColor,
                      onPressed: () {
                        if (clicked == indx) {
                          stream?.eventSink.add(RecipeQuery.all);
                          setState(() {
                            clicked = -1;
                          });
                        }
                        else {
                          stream?.eventSink.add(queries[indx]);
                          setState (() {
                            clicked = indx;
                          });
                        }
                        
                        
                        
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
