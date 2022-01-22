import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchBar extends StatelessWidget {
  SearchBar({
    Key? key,
    // @required int? pageNo,
    // @required this.state,
    // this.state,
  }) : super(key: key);
  //  {
  //   headerState["pageNo"] = pageNo;
  // }

  // final TypeState? state;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return //headerState["pageNo"] != 3 ?
        Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: theme.indicatorColor,
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                boxShadow: [
                  // BoxShadow(
                  //   blurRadius: 20,
                  //   color: Colors.black.withOpacity(.07),
                  //   offset: const Offset(0, 4),
                  // ),
                ],
              ),
              child: TextField(
                textDirection: TextDirection.rtl,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 8,
                  ),
                  hintText: "إبحث عن وصفة...",
                  hintStyle: TextStyle(
                    color: theme.accentColor.withOpacity(.5)
                  ),
                  hintTextDirection: TextDirection.rtl,
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: SvgPicture.asset(
                      "assets/icons/search.svg",
                      color: theme.accentColor.withOpacity(.5),
                      height: 30,
                    ),
                  ),
                  suffixIconConstraints: const BoxConstraints(
                    minHeight: 0,
                    minWidth: 0,
                  ),
                ),
                textAlignVertical: TextAlignVertical.center,
                cursorColor: theme.accentColor,
              ),
            ),
          ),
          Container(
            height: 50,
            width: 50,
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              // TODO: delete the container if the shadow is not used 
              boxShadow: [
                // BoxShadow(
                //   blurRadius: 20,
                //   offset: const Offset(0, 7),
                //   color: theme.shadowColor,
                // ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: ElevatedButton(
              child: RotatedBox(
                quarterTurns: 1,
                child: SvgPicture.asset(
                  "assets/icons/filter.svg",
                  height: 30,
                  color: theme.primaryColor,
                ),
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(0),
                primary: theme.accentColor,
              ),
              onPressed: () {/*Comming Soon*/},
            ),
          ),
        ],
      ),
    );
    // : Container();
  }
}
