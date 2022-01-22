import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField({ 
    Key? key,
    @required this.controller,
    @required this.color,
    @required this.imgName,
    @required this.hintTxt,
    @required this.onTap,
    @required this.onSubmit,
    @required this.validator,
    this.isObscure,
   }) : super(key: key);
  
  final TextEditingController? controller;
  final Color? color;
  final String? imgName;
  final String? hintTxt;
  final Function()? onTap;
  final Function(String)? onSubmit;
  final String? Function(String?)? validator;
  
  final bool? isObscure;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).accentColor,
            width: 2,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2,
          ),
        ),
        suffixIcon: SvgPicture.asset(
          "assets/icons/$imgName.svg",
          color: color,
          height: 35,
        ),
        suffixIconConstraints: const BoxConstraints(
          minHeight: 0,
          minWidth: 0,
        ),
        hintText: hintTxt,
        hintTextDirection: TextDirection.rtl,
        hintStyle: Theme.of(context)
            .textTheme
            .bodyText2
            ?.copyWith(
              color: Theme.of(context)
                  .accentColor
                  .withOpacity(.6),
            ),
        contentPadding: EdgeInsets.all(5),
      ),
      obscureText: isObscure ?? false,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.right,
      cursorColor: Theme.of(context).accentColor,
      keyboardType: TextInputType.emailAddress,
      onTap: onTap,
      onFieldSubmitted: onSubmit,
      validator: validator,
    );
  }
}