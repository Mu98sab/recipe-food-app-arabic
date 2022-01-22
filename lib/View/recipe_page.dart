import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:recipe/Model/database.dart';
import 'package:recipe/Model/recipe.dart';
import 'package:rxdart/rxdart.dart';

class RecipePage extends StatelessWidget {
  RecipePage({Key? key, @required this.recipe}) : super(key: key);

  final Recipe? recipe;
  final Map<String, dynamic> _state = {
    "start": true,
    "steps": false,
    "currRecipe": 0,
  };

  final StreamController<bool> _listStreamController = BehaviorSubject();
  StreamSink<bool> get listSink => _listStreamController.sink;
  Stream<bool> get listStream => _listStreamController.stream;

  // TODO: use it when there is many sub recipes
  final StreamController<bool> _indxStreamController = BehaviorSubject();
  StreamSink<bool> get indxSink => _indxStreamController.sink;
  Stream<bool> get indxSteam => _indxStreamController.stream;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: SvgPicture.asset("assets/icons/comment.svg", color: theme.indicatorColor, width: 25,),
        onPressed: () {},
        backgroundColor: theme.primaryColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body: SafeArea(
        child: Column(
          children: [
            FutureBuilder<String?>(
              future: Database().getImg(recipe?.img ?? ""),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    height: 250,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: theme.accentColor,
                      ),
                    ),
                  );
                } else {
                  return Container(
                    height: 250,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(snapshot.data ?? ""),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                margin: const EdgeInsets.all(15),
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white.withOpacity(.5),
                                ),
                                child: SvgPicture.asset(
                                  "assets/icons/chevron-left.svg",
                                  height: 30,
                                  color: theme.accentColor,
                                  alignment: Alignment.center,
                                ),
                              ),
                            ),
                            const Expanded(child: const SizedBox()),
                            InkWell(
                              onTap: () {
                                print("Coming Soon");
                              },
                              child: Container(
                                margin: const EdgeInsets.all(15),
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white.withOpacity(.5),
                                ),
                                child: SvgPicture.asset(
                                  "assets/icons/more.svg",
                                  height: 30,
                                  color: theme.accentColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Expanded(child: const SizedBox()),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 40),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: const Radius.circular(30),
                              topRight: const Radius.circular(30),
                            ),
                            color: theme.accentColor.withOpacity(.3),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: ClipRect(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaX: 10,
                                sigmaY: 10,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 20,
                                ),
                                child: Row(
                                  textDirection: TextDirection.rtl,
                                  children: [
                                    RichText(
                                      textDirection: TextDirection.rtl,
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: "${recipe?.name}\n",
                                            style: theme.textTheme.headline2
                                                ?.copyWith(
                                                    color:
                                                        theme.backgroundColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                          ),
                                          TextSpan(
                                              text: "${recipe?.type}",
                                              style: theme.textTheme.bodyText1
                                                  ?.copyWith(
                                                      color: Colors.white)),
                                        ],
                                      ),
                                    ),
                                    const Expanded(
                                      child: SizedBox(),
                                    ),
                                    ActionChip(
                                      label: Text(
                                        "${recipe?.rate}",
                                        style: TextStyle(
                                          color: theme.accentColor,
                                        ),
                                      ),
                                      backgroundColor: theme.backgroundColor,
                                      avatar: SvgPicture.asset(
                                        "assets/icons/star-full.svg",
                                        color: theme.accentColor,
                                      ),
                                      onPressed: () {},
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
            Container(
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.symmetric(horizontal: 40),
              decoration: BoxDecoration(
                color: theme.backgroundColor, //Colors.white,
                borderRadius: const BorderRadius.only(
                  bottomLeft: const Radius.circular(30),
                  bottomRight: const Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 20,
                    color: Colors.black.withOpacity(.05),
                  )
                ],
              ),
              child: Row(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RichText(
                    textDirection: TextDirection.rtl,
                    text: TextSpan(children: [
                      WidgetSpan(
                        child: SvgPicture.asset(
                          "assets/icons/clock.svg",
                          color: theme.accentColor,
                        ),
                        alignment: PlaceholderAlignment.middle,
                      ),
                      TextSpan(
                        text: " ${recipe?.time} د",
                        style: theme.textTheme.bodyText2
                            ?.copyWith(color: theme.accentColor),
                      ),
                    ]),
                  ),
                  RichText(
                    textDirection: TextDirection.rtl,
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          child: SvgPicture.asset(
                            "assets/icons/dashboard.svg",
                            height: 20,
                            color: theme.accentColor,
                          ),
                          alignment: PlaceholderAlignment.middle,
                        ),
                        TextSpan(
                          text: " ${recipe?.difficulty}",
                          style: theme.textTheme.bodyText2?.copyWith(
                              color: theme
                                  .accentColor), //TextStyle(color: theme.accentColor),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    textDirection: TextDirection.rtl,
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          child: SvgPicture.asset(
                            "assets/icons/user.svg",
                            color: theme.accentColor,
                          ),
                          alignment: PlaceholderAlignment.middle,
                        ),
                        TextSpan(
                          text: " ${recipe?.person}",
                          style: theme.textTheme.bodyText2
                              ?.copyWith(color: theme.accentColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return FutureBuilder<RecipeCook?>(
                    future: Database()
                        .getCook(recipe!.subRecipe![_state["currRecipe"]]),
                    builder: (context, snapshot) {
                      print(recipe?.subRecipe?.length);
                      return CustomScrollView(
                        slivers: [
                          SliverList(
                            delegate: SliverChildListDelegate(
                              [
                                Container(
                                  margin: const EdgeInsets.only(
                                    top: 20,
                                  ),
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 20, 20, 0),
                                  decoration: BoxDecoration(
                                      color:
                                          theme.backgroundColor, //Colors.white,
                                      borderRadius: const BorderRadius.only(
                                        topLeft: const Radius.circular(50),
                                        topRight: const Radius.circular(50),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 20,
                                            offset: Offset(0, -10),
                                            color:
                                                Colors.black.withOpacity(.03))
                                      ]),
                                  child: Column(
                                    textDirection: TextDirection.rtl,
                                    children: [
                                      recipe!.subRecipe!.length > 1
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 20),
                                              child: Row(
                                                children: [
                                                  _state["currRecipe"] < (recipe!.subRecipe!.length - 1)
                                                      ? IconButton(
                                                          icon:
                                                              SvgPicture.asset(
                                                            "assets/icons/chevron-left.svg",
                                                            color: theme
                                                                .accentColor,
                                                          ),
                                                          onPressed: () {
                                                            setState(() {
                                                              _state["currRecipe"] =
                                                                  _state["currRecipe"] +
                                                                      1;
                                                            });
                                                          },
                                                        )
                                                      : Container(width: 48,),
                                                  Expanded(
                                                    child: Text(
                                                      snapshot.data?.name ?? "",
                                                      textDirection:
                                                          TextDirection.rtl,
                                                      style: theme
                                                          .textTheme.headline2
                                                          ?.copyWith(
                                                              color: theme
                                                                  .accentColor),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                  _state["currRecipe"] > 0
                                                      ? IconButton(
                                                          icon:
                                                              SvgPicture.asset(
                                                            "assets/icons/chevron-right.svg",
                                                            color: theme
                                                                .accentColor,
                                                          ),
                                                          onPressed: () {
                                                            setState(() {
                                                              _state["currRecipe"] =  _state["currRecipe"] - 1;
                                                            });
                                                          })
                                                      : Container(width: 48,),
                                                ],
                                              ),
                                            )
                                          : Container(),
                                      StatefulBuilder(
                                        builder: (BuildContext context,
                                            StateSetter setState) {
                                          return Row(
                                            textDirection: TextDirection.rtl,
                                            children: [
                                              Expanded(
                                                child: InkWell(
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(5),
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                        horizontal: 15,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: !_state["steps"]
                                                            ? theme.primaryColor
                                                            : theme
                                                                .backgroundColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(7),
                                                      ),
                                                      child: Text(
                                                        "المقادير",
                                                        textDirection:
                                                            TextDirection.rtl,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: theme
                                                            .textTheme.headline3
                                                            ?.copyWith(
                                                                color: !_state[
                                                                        "steps"]
                                                                    ? theme
                                                                        .indicatorColor
                                                                    : theme
                                                                        .accentColor),
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      if (_state["steps"]) {
                                                        listSink.add(false);
                                                        setState(() {
                                                          _state["steps"] =
                                                              false;
                                                          _state["start"] =
                                                              true;
                                                        });
                                                        print(
                                                            "Ingredient selected");
                                                      }
                                                    }),
                                              ),
                                              Expanded(
                                                child: InkWell(
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(5),
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                        horizontal: 15,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: _state["steps"]
                                                            ? theme.primaryColor
                                                            : theme
                                                                .backgroundColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(7),
                                                      ),
                                                      child: Text(
                                                        "الخطوات",
                                                        textDirection:
                                                            TextDirection.rtl,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: theme
                                                            .textTheme.headline3
                                                            ?.copyWith(
                                                          color: _state["steps"]
                                                              ? theme
                                                                  .indicatorColor
                                                              : theme
                                                                  .accentColor,
                                                        ),
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      if (!_state["steps"]) {
                                                        print("Steps selected");
                                                        listSink.add(true);
                                                        setState(() {
                                                          _state["steps"] =
                                                              true;
                                                          _state["start"] =
                                                              true;
                                                        });
                                                      }
                                                    }),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          snapshot.connectionState == ConnectionState.done
                              ? StreamBuilder(
                                  stream: listStream,
                                  initialData: false,
                                  builder: (BuildContext context,
                                      AsyncSnapshot<bool> snapshot2) {
                                    return SliverList(
                                      delegate: SliverChildBuilderDelegate(
                                        (context, indx) {
                                          if (_state["start"]) {
                                            if (snapshot2.data ?? false) {
                                              if (indx + 1 ==
                                                  snapshot
                                                      .data?.steps?.length) {
                                                _state["start"] = false;
                                              }
                                            } else {
                                              _state[indx.toString()] = false;
                                              if (indx + 1 ==
                                                  snapshot.data?.ingredientName
                                                      ?.length) {
                                                _state["start"] = false;
                                              }
                                            }
                                          }

                                          if (!(snapshot2.data ?? false)) {
                                            return StatefulBuilder(
                                              builder: (BuildContext context,
                                                  StateSetter setState) {
                                                return ListTile(
                                                  title: Text(
                                                    snapshot.data
                                                                ?.ingredientName?[
                                                            indx] ??
                                                        "",
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    style: theme
                                                        .textTheme.bodyText1
                                                        ?.copyWith(
                                                      color: theme.accentColor,
                                                    ),
                                                  ),
                                                  leading: Text(
                                                    snapshot.data
                                                                ?.ingredientMag?[
                                                            indx] ??
                                                        "",
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            theme.accentColor),
                                                  ),
                                                  trailing: SvgPicture.asset(
                                                    !_state[indx.toString()]
                                                        ? "assets/icons/circle.svg"
                                                        : "assets/icons/checkbox.svg",
                                                    color: theme.primaryColor,
                                                    height: 30,
                                                  ),
                                                  onTap: () {
                                                    setState(() {
                                                      _state[indx.toString()] =
                                                          !_state[
                                                              indx.toString()];
                                                    });
                                                  },
                                                  tileColor:
                                                      theme.backgroundColor,
                                                );
                                              },
                                            );
                                          } else {
                                            return Container(
                                              padding: const EdgeInsets.all(15),
                                              margin: const EdgeInsets.all(15),
                                              decoration: BoxDecoration(
                                                  color: theme.backgroundColor,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  boxShadow: <BoxShadow>[
                                                    BoxShadow(
                                                      blurRadius: 20,
                                                      color: Colors.black
                                                          .withOpacity(.07),
                                                      offset: Offset(0, 4),
                                                    ),
                                                  ]),
                                              child: Row(
                                                textDirection:
                                                    TextDirection.rtl,
                                                children: <Widget>[
                                                  Container(
                                                    padding: EdgeInsets.all(12),
                                                    decoration: BoxDecoration(
                                                      color: theme.primaryColor,
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Text(
                                                      "${indx + 1}",
                                                      style: theme
                                                          .textTheme.headline3
                                                          ?.copyWith(
                                                              color: theme
                                                                  .indicatorColor),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 15,
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      snapshot.data
                                                              ?.steps?[indx] ??
                                                          "",
                                                      style: theme
                                                          .textTheme.bodyText1
                                                          ?.copyWith(
                                                              color: theme
                                                                  .accentColor),
                                                      textDirection:
                                                          TextDirection.rtl,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }
                                        },
                                        childCount: snapshot2.data ?? false
                                            ? snapshot.data?.steps?.length
                                            : snapshot
                                                .data?.ingredientMag?.length,
                                      ),
                                    );
                                  },
                                )
                              : SliverFillRemaining(
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: theme.accentColor,
                                    ),
                                  ),
                                ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
