import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recipe/Model/authentication.dart';
import 'package:recipe/Model/database.dart';
import 'package:recipe/Model/user.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:recipe/View/Component/typeBar.dart';
import 'package:recipe/View/category.dart';
import 'package:recipe/View/home.dart';

// TODO: convert it to stateless widget
class PageControler extends StatefulWidget {
  PageControler({Key? key, this.user}) : super(key: key);

  final RecipeUser? user;

  @override
  _PageControlerState createState() => _PageControlerState();
}

class _PageControlerState extends State<PageControler> {
  int _currentPage = 0;
  final TypeState typeState = TypeState();

  List<String> txt = <String>[];
  initData() {
    txt = [
      "مرحبًا ${widget.user?.name ?? ""}",
      "تصنيفات الطعام",
      "المفضلة",
      "الملف الشخصي"
    ];
    pages = [
      Home(/*referesh: setState(() {}),*/),
      Category(
        stream: typeState.typeStream,
        typeState: typeState,
      ),
      Expanded(child: Center(child: Text("Coming soon"))),
      Expanded(
        child: Center(
          child: ElevatedButton(
            child: Text("تسجيل خروج"),
            onPressed: () async {
              await Authentication().signOut();
            },
          ),
        ),
      ),
    ];
  }

  @override
  void initState() {
    // print("INIT DATA");
    super.initState();
    initData();
  }

  @override
  void dispose() {
    print("ERROR DISPOSE");
    typeState.disposeStream();
    super.dispose();
  }

  List<Widget> pages = <Widget>[];

  late ThemeData theme;

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        // Text is written in row to make it on the right
        title: Row(
          textDirection: TextDirection.rtl,
          children: [
            Text(
              " ${txt[_currentPage]}",
              textDirection: TextDirection.rtl,
              style:
                  theme.textTheme.headline1?.copyWith(color: theme.accentColor),
            ),
          ],
        ),

        // TODO: implement the dark mode
        leading: IconButton(
          icon: SvgPicture.asset(
            "assets/icons/moon.svg",
            color: theme.accentColor,
          ),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "قريبا",
                  textDirection: TextDirection.rtl,
                  style: theme.textTheme.bodyText1?.copyWith(color: theme.backgroundColor),
                ),
              ),
            );
          },
          highlightColor: theme.primaryColorLight,
        ),
        backgroundColor: theme.primaryColor,
      ),
      bottomNavigationBar:
          // Container(
          //   decoration: BoxDecoration(
          //     color: Colors.white,
          //     boxShadow: [
          //       BoxShadow(
          //         blurRadius: 20,
          //         color: Theme.of(context).shadowColor,
          //       ),
          //     ],
          //     borderRadius: BorderRadius.only(
          //       topLeft: const Radius.circular(25),
          //       topRight: const Radius.circular(25),
          //     ),
          //   ),
          //   // clipBehavior: Clip.antiAlias,
          //   child:
          SnakeNavigationBar.color(
        behaviour: SnakeBarBehaviour.pinned,
        elevation: 20,
        shadowColor: Colors.black,
        snakeShape: SnakeShape.indicator.copyWith(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 28),
        ),
        height: 55,
        backgroundColor: theme.backgroundColor,
        currentIndex: _currentPage,
        snakeViewColor: theme.accentColor,
        onTap: (indx) {
          if (indx == 1) {
            typeState.eventSink.add(RecipeQuery.all);
          }
          if (_currentPage != indx) {
            setState(() {
              _currentPage = indx;
            });
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/home.svg",
              height: 30,
              color: theme.accentColor.withOpacity(_currentPage == 0 ? 1 : .7),
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/document.svg",
              height: 30,
              color: theme.accentColor.withOpacity(_currentPage == 1 ? 1 : .7),
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/bookmark.svg",
              height: 30,
              color: theme.accentColor.withOpacity(_currentPage == 2 ? 1 : .7),
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/icons/user.svg",
              height: 30,
              color: theme.accentColor.withOpacity(_currentPage == 3 ? 1 : .7),
            ),
          ),
        ],
      ),
      // ),
      floatingActionButton: FloatingActionButton(
        child: SvgPicture.asset(
          "assets/icons/plus.svg",
          height: 35,
          color: theme.primaryColor,
        ),
        elevation: 20,
        backgroundColor: theme.accentColor,
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body: Column(
        textDirection: TextDirection.rtl,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SearchBar(),
          // _currentPage == 1
          //     ? TypeBar(
          //         stream: typeState,
          //       )
          //     : Container(),
          pages[_currentPage],
        ],
      ),
    );
  }
}
