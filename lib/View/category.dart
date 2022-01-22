import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recipe/Model/database.dart';
import 'package:recipe/Model/recipe.dart';
import 'package:recipe/View/Component/net_img.dart';
import 'package:recipe/View/Component/search_bar.dart';
import 'package:recipe/View/Component/typeBar.dart';
import 'package:recipe/View/recipe_page.dart';

class Category extends StatelessWidget {
  Category({
    Key? key,
    @required this.stream,
    @required this.typeState,
  }) : super(key: key);

  // TODO: delete the stream and let the typeState
  final Stream<List<Recipe>?>? stream;
  final TypeState? typeState;

  // Widget getSliver() {
  //   return CustomScrollView(
  //     physics: BouncingScrollPhysics(),
  //     slivers: <Widget>[
  //       SliverList(
  //         delegate: SliverChildBuilderDelegate(
  //           (BuildContext context, int indx) {
  //             GestureDetector(
  //               onTap: () {
  //                 Navigator.push(context, MaterialPageRoute(builder: (context) => RecipePage(recipe: snapshot.data?[indx])));
  //               },
  //               child: Padding(
  //                 padding: const EdgeInsets.fromLTRB(10, 10, 25, 10),
  //                 child: Row(
  //                   textDirection: TextDirection.rtl,
  //                   children: [
  //                     NetImage(
  //                       imgName: snapshot.data?[indx].img,
  //                       height: 140,
  //                       width: 130,
  //                       borderRadius: BorderRadius.circular(15),
  //                     ),
  //                     // ),

  //                     SizedBox(
  //                       width: 30,
  //                     ),

  //                     RichText(
  //                       textDirection: TextDirection.rtl,
  //                       text: TextSpan(
  //                         children: [
  //                           TextSpan(
  //                             text: "${snapshot.data?[indx].name}\n",
  //                             style: TextStyle(
  //                               fontWeight: FontWeight.bold,
  //                               color: theme.accentColor,
  //                               fontSize: 20,
  //                               fontFamily: "Cocon",
  //                             ),
  //                           ),
  //                           TextSpan(
  //                             text: "${snapshot.data?[indx].type}\n\n\n",
  //                             style: theme.textTheme.bodyText2?.copyWith(
  //                               color: theme.accentColor.withOpacity(.7),
  //                             ),
  //                           ),

  //                           WidgetSpan(
  //                             alignment: PlaceholderAlignment.middle,
  //                             child: SvgPicture.asset(
  //                               "assets/icons/star-full.svg",
  //                               height: 20,
  //                               color: Colors.amber,//Colors.amber,
  //                             ),
  //                           ),
  //                           TextSpan(
  //                             text: " ${snapshot.data?[indx].time} د   ",
  //                             style: theme.textTheme.bodyText2?.copyWith(
  //                               color: theme.accentColor,
  //                             ),
  //                           ),
  //                           WidgetSpan(
  //                             alignment: PlaceholderAlignment.middle,
  //                             child: SvgPicture.asset(
  //                               "assets/icons/clock.svg",
  //                               height: 20,
  //                               color: theme.accentColor,
  //                             ),
  //                           ),
  //                           TextSpan(
  //                             text: " ${snapshot.data?[indx].rate}",
  //                             style: theme.textTheme.bodyText2?.copyWith(
  //                               color: theme.accentColor,
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             );
  //           },
  //           childCount: snapshot.data?.length ?? 0,
  //         ),
  //       ),
  //     ],
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return StreamBuilder<List<Recipe>?>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Expanded(
              child: snapshot.data?.length == 0
                  ? const Center(
                      child: Text("لا توجد وصفات لهذا التصنيف"),
                    )
                  : CustomScrollView(
                      physics: BouncingScrollPhysics(),
                      slivers: <Widget>[
                        // TODO add sliverAppbar with the search

                        // RefreshIndicator(
                        //   onRefresh: () async{
                        //     await typeState.eventSink.
                        //   },
                        //   child:
                        SliverAppBar(
                          backgroundColor: theme.primaryColor,
                          flexibleSpace: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(2),
                              child: SearchBar(),
                            ),
                            alignment: Alignment.center,
                            padding: const EdgeInsets.only(top: 10),
                          ),
                          // stretch: true,
                          stretch: true,
                          floating: true,
                          onStretchTrigger: () async {
                            print("hhhhhhhhhhhhhhhhhhhhhh");
                          },
                        ),
                        SliverAppBar(
                          backgroundColor: theme.primaryColor,
                          flexibleSpace: Container(
                            child: TypeBar(
                              stream: typeState,
                            ),
                            alignment: Alignment.center,
                            padding: const EdgeInsets.only(top: 10),
                          ),
                          // stretch: true,
                          stretch: true,
                          floating: true,
                          onStretchTrigger: () async {
                            print("hhhhhhhhhhhhhhhhhhhhhh");
                          },
                        ),

                        SliverToBoxAdapter(
                          child: Container(
                            height: 50,
                            color: theme.primaryColor,
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: theme.backgroundColor,
                                borderRadius: BorderRadius.only(
                                  topLeft: const Radius.circular(50),
                                  topRight: const Radius.circular(50),
                                ),
                              ),
                            ),
                          ),
                        ),

                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int indx) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => RecipePage(
                                              recipe: snapshot.data?[indx])));
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 10, 25, 10),
                                  child: Row(
                                    textDirection: TextDirection.rtl,
                                    children: [
                                      NetImage(
                                        imgName: snapshot.data?[indx].img,
                                        height: 140,
                                        width: 130,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      // ),

                                      SizedBox(
                                        width: 30,
                                      ),

                                      RichText(
                                        textDirection: TextDirection.rtl,
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text:
                                                  "${snapshot.data?[indx].name}\n",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: theme.accentColor,
                                                fontSize: 20,
                                                fontFamily: "Cocon",
                                              ),
                                            ),
                                            TextSpan(
                                              text:
                                                  "${snapshot.data?[indx].type}\n\n\n",
                                              style: theme.textTheme.bodyText2
                                                  ?.copyWith(
                                                color: theme.accentColor
                                                    .withOpacity(.7),
                                              ),
                                            ),
                                            WidgetSpan(
                                              alignment:
                                                  PlaceholderAlignment.middle,
                                              child: SvgPicture.asset(
                                                "assets/icons/star-full.svg",
                                                height: 20,
                                                color: Colors
                                                    .amber, //Colors.amber,
                                              ),
                                            ),
                                            TextSpan(
                                              text:
                                                  " ${snapshot.data?[indx].time} د   ",
                                              style: theme.textTheme.bodyText2
                                                  ?.copyWith(
                                                color: theme.accentColor,
                                              ),
                                            ),
                                            WidgetSpan(
                                              alignment:
                                                  PlaceholderAlignment.middle,
                                              child: SvgPicture.asset(
                                                "assets/icons/clock.svg",
                                                height: 20,
                                                color: theme.accentColor,
                                              ),
                                            ),
                                            TextSpan(
                                              text:
                                                  " ${snapshot.data?[indx].rate}",
                                              style: theme.textTheme.bodyText2
                                                  ?.copyWith(
                                                color: theme.accentColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            childCount: snapshot.data?.length ?? 0,
                          ),
                        ),
                        // ),
                      ],
                    )
              // ListView.separated(
              //     separatorBuilder: (context, indx) {
              //       return SizedBox(
              //         height: 10,
              //       );
              //     },
              //     padding: const EdgeInsets.symmetric(
              //       vertical: 20,
              //       horizontal: 5,
              //     ),
              //     physics: const BouncingScrollPhysics(),
              //     itemCount: snapshot.data?.length ?? 0,
              //     itemBuilder: (context, indx) {
              //       return GestureDetector(
              //         onTap: () {
              //           Navigator.push(context, MaterialPageRoute(builder: (context) => RecipePage(recipe: snapshot.data?[indx])));
              //         },
              //         child: Padding(
              //           padding: const EdgeInsets.all(10),
              //           child: Row(
              //             textDirection: TextDirection.rtl,
              //             children: [
              //               NetImage(
              //                 imgName: snapshot.data?[indx].img,
              //                 height: 140,
              //                 width: 130,
              //                 borderRadius: BorderRadius.circular(15),
              //               ),
              //               // ),

              //               SizedBox(
              //                 width: 30,
              //               ),

              //               RichText(
              //                 textDirection: TextDirection.rtl,
              //                 text: TextSpan(
              //                   children: [
              //                     TextSpan(
              //                       text: "${snapshot.data?[indx].name}\n",
              //                       style: TextStyle(
              //                         fontWeight: FontWeight.bold,
              //                         color: theme.accentColor,
              //                         fontSize: 20,
              //                         fontFamily: "Cocon",
              //                       ),
              //                     ),
              //                     TextSpan(
              //                       text: "${snapshot.data?[indx].type}\n\n\n",
              //                       style: theme.textTheme.bodyText2?.copyWith(
              //                         color: theme.accentColor.withOpacity(.7),
              //                       ),
              //                     ),

              //                     WidgetSpan(
              //                       alignment: PlaceholderAlignment.middle,
              //                       child: SvgPicture.asset(
              //                         "assets/icons/star-full.svg",
              //                         height: 20,
              //                         color: Colors.amber,//Colors.amber,
              //                       ),
              //                     ),
              //                     TextSpan(
              //                       text: " ${snapshot.data?[indx].time} د   ",
              //                       style: theme.textTheme.bodyText2?.copyWith(
              //                         color: theme.accentColor,
              //                       ),
              //                     ),
              //                     WidgetSpan(
              //                       alignment: PlaceholderAlignment.middle,
              //                       child: SvgPicture.asset(
              //                         "assets/icons/clock.svg",
              //                         height: 20,
              //                         color: theme.accentColor,
              //                       ),
              //                     ),
              //                     TextSpan(
              //                       text: " ${snapshot.data?[indx].rate}",
              //                       style: theme.textTheme.bodyText2?.copyWith(
              //                         color: theme.accentColor,
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //       );
              //     },
              //   ),
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
          return Expanded(
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
