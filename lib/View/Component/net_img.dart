import 'package:flutter/material.dart';
import 'package:recipe/Model/database.dart';

class NetImage extends StatelessWidget {
  NetImage({
    Key? key,
    @required this.imgName,
    this.height,
    this.width,
    this.borderRadius,
    this.shadow,
  }) : super(key: key);

  final String? imgName;
  final double? height, width;

  final Database _db = Database();
  final BorderRadiusGeometry? borderRadius;
  final List<BoxShadow>? shadow;

  
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return FutureBuilder(
      future: _db.getImg(imgName ?? ""),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Container(
            decoration: BoxDecoration(
              color: theme.backgroundColor,
              boxShadow: shadow,
              // [
              //   BoxShadow(
              //     blurRadius: 20,
              //     color: Colors.black.withOpacity(.05),
              //   ),
              // ],
              image: DecorationImage(
                image: NetworkImage(
                  snapshot.data as String,
                ),
                fit: BoxFit.cover,
              ),
              borderRadius: borderRadius, //const BorderRadius.all(Radius.circular(15))),
            ), 
              width: width,
              height: height,
              // clipBehavior: Clip.antiAlias,
              // child: Image.network(
                
              //   snapshot.data as String,
              //   loadingBuilder: (BuildContext context, Widget child,
              //       ImageChunkEvent? loadingProgress) {
              //     return loadingProgress?.cumulativeBytesLoaded !=
              //             loadingProgress?.expectedTotalBytes
              //     ? Center(
              //         child: CircularProgressIndicator(
              //           color: theme.primaryColor,
              //         ),
              //       )
              //   : child;
              // },
              // fit: BoxFit.cover,
            // ),
          );  
        }
        else{
          return SizedBox(
            height: height,
            width: width,
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
