import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(
        horizontal: (MediaQuery. of(context).size.width / 2) - 65,
      ),
      contentPadding: EdgeInsets.all(10),
      backgroundColor: Theme.of(context).backgroundColor,
      // contentPadding: const EdgeInsets.all(10),
      scrollable: false,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(
          const Radius.circular(10),
        ),
      ),
      content: SizedBox(
        height: 100,
        width: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SpinKitWave(
              color: Theme.of(context).primaryColor,
              size: 50,
            ),
            Text(
              "انتظر",
              textDirection: TextDirection.rtl,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.copyWith(color: Theme.of(context).accentColor),
            ),
          ],
        ),
      ),
    );
  }
}
