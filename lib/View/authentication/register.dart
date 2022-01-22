import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recipe/Model/authentication.dart';
import 'package:recipe/Model/user.dart';
import 'package:recipe/View/Component/auth_text_field.dart';
import 'package:recipe/View/Component/loading.dart';

class SignUp extends StatelessWidget {
  
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Authentication _auth = Authentication();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();


  final Map<String, dynamic> _signUpState = {
    "nameClicked": false,
    "emailClicked": false,
    "passClicked": false,
    "msg": "",
  };

  // Future showLoading() {
  //   return showDialog(
  //     barrierDismissible: false,
  //     context: context,
  //     builder: (BuildContext context) => Loading(),
  //   );
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.only(
            right: 15,
            top: 20,
          ),
          child: Row(
            textDirection: TextDirection.rtl,
            children: [
              SvgPicture.asset(
                "assets/icons/chevron-left.svg",
                color: const Color(0xff78d0d3),
                height: 40,
              ),
              Text(
                "إنشاء حساب جديد",
                textDirection: TextDirection.rtl,
                style: Theme.of(context).textTheme.headline1?.copyWith(
                      color: Theme.of(context).accentColor,
                    ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: IconButton(
                      icon: SvgPicture.asset(
                        "assets/icons/chevron-left.svg",
                        color: Theme.of(context).accentColor,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      splashRadius: .5,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: StatefulBuilder(
        builder: (context, StateSetter setState) {
          return SizedBox(
            height: double.infinity,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 35),
                      child:
                          SvgPicture.asset("assets/images/SignUp_illustration.svg"),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(_signUpState["msg"],
                          style: Theme.of(context).textTheme.bodyText2?.copyWith(
                              color: Colors.red[400], fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 12,
                      ),
                      child: AuthTextField(
                        controller: _nameController,
                        color: _signUpState["nameClicked"]
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).accentColor,
                        imgName: "user",
                        hintTxt: "الاسم",
                        onTap: () {
                          setState(() {
                            _signUpState["nameClicked"] = true;
                            _signUpState["emailClicked"] = _signUpState["passClicked"] = false;
                          });
                        },
                        onSubmit: (val) {
                          setState(() {
                            _signUpState["nameClicked"] = false;
                          });
                        },
                        validator: (val) =>
                            (val ?? "").trim().length == 0 ? "أدخِل اسمك" : null,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 12,
                      ),
                      child: AuthTextField(
                        controller: _emailController,
                        color: _signUpState["emailClicked"]
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).accentColor,
                        imgName: "email",
                        hintTxt: "البريد الإلكتروني",
                        onTap: () {
                          setState(() {
                            _signUpState["emailClicked"] = true;
                            _signUpState["nameClicked"] = _signUpState["passClicked"] = false;
                          });
                        },
                        onSubmit: (val) {
                          setState(() {
                            _signUpState["emailClicked"] = false;
                          });
                        },
                        validator: (val) => (val ?? "").trim().length == 0
                            ? "أدخِل بريدك الإلكتروني"
                            : null,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 12,
                      ),
                      child: AuthTextField(
                        controller: _passController,
                        color: _signUpState["passClicked"]
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).accentColor,
                        imgName: "password",
                        hintTxt: "كلمة المرور",
                        isObscure: true,
                        onTap: () {
                          setState(() {
                            _signUpState["passClicked"] = true;
                            _signUpState["emailClicked"] = _signUpState["nameClicked"] = false;
                          });
                        },
                        onSubmit: (val) {
                          setState(() {
                            _signUpState["passClicked"] = false;
                          });
                        },
                        validator: (val) => (val ?? "").length < 8
                            ? "كلمة المرور تتطلب 8 رموز أو أكثر"
                            : null,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 12),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 20,
                              color: Theme.of(context).shadowColor,
                              offset: const Offset(0, 5))
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () async {
                          await showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) => Loading(),
                          );
                          if (_formKey.currentState?.validate() ?? false) {
                            try {
                              RecipeUser? user = await _auth.signUpEmail(
                                _nameController.text.trim(),
                                _emailController.text.trim(),
                                _passController.text.trim(),
                              );
                              if (user == null) {
                                setState(() {
                                  _signUpState["msg"] = "البريد الإلكتروني غير صحيح";
                                });
                                _nameController.clear();
                                _emailController.clear();
                                _passController.clear();
                              } else {
                                Navigator.pop(context);
                              }
                            } catch (err) {
                              if (err.toString() ==
                                  "سبق استخدام البريد الإلكتروني المدخل") {
                                setState(() {
                                  _signUpState["msg"] = err.toString();
                                });
                              }
                            }
                          }
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            "تسجيل الدخول",
                            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                                color: Theme.of(context).accentColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).primaryColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        
      ),
    );
  }
}

// class SignUp extends StatefulWidget {
//   const SignUp({Key? key}) : super(key: key);

//   @override
//   _SignUpState createState() => _SignUpState();
// }

// class _SignUpState extends State<SignUp> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final Authentication _auth = Authentication();
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passController = TextEditingController();

//   bool _nameClicked = false;
//   bool _emailClicked = false;
//   bool _passClicked = false;

//   String _msg = "";

//   Future showLoading() {
//     return showDialog(
//       barrierDismissible: false,
//       context: context,
//       builder: (BuildContext context) => Loading(),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Theme.of(context).backgroundColor,
//         automaticallyImplyLeading: false,
//         titleSpacing: 0,
//         title: Padding(
//           padding: const EdgeInsets.only(
//             right: 15,
//             top: 20,
//           ),
//           child: Row(
//             textDirection: TextDirection.rtl,
//             children: [
//               SvgPicture.asset(
//                 "assets/icons/chevron-left.svg",
//                 color: const Color(0xff78d0d3),
//                 height: 40,
//               ),
//               Text(
//                 "إنشاء حساب جديد",
//                 textDirection: TextDirection.rtl,
//                 style: Theme.of(context).textTheme.headline1?.copyWith(
//                       color: Theme.of(context).accentColor,
//                     ),
//               ),
//               Expanded(
//                 child: Align(
//                   alignment: Alignment.bottomLeft,
//                   child: Padding(
//                     padding: const EdgeInsets.only(left: 10),
//                     child: IconButton(
//                       icon: SvgPicture.asset(
//                         "assets/icons/chevron-left.svg",
//                         color: Theme.of(context).accentColor,
//                       ),
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                       splashRadius: .5,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       body: SizedBox(
//         height: double.infinity,
//         child: SingleChildScrollView(
//           physics: BouncingScrollPhysics(),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(top: 35),
//                   child:
//                       SvgPicture.asset("assets/images/SignUp_illustration.svg"),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 10),
//                   child: Text(_msg,
//                       style: Theme.of(context).textTheme.bodyText2?.copyWith(
//                           color: Colors.red[400], fontWeight: FontWeight.bold)),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 30,
//                     vertical: 12,
//                   ),
//                   child: AuthTextField(
//                     controller: _nameController,
//                     color: _nameClicked
//                         ? Theme.of(context).primaryColor
//                         : Theme.of(context).accentColor,
//                     imgName: "user",
//                     hintTxt: "الاسم",
//                     onTap: () {
//                       setState(() {
//                         _nameClicked = true;
//                         _emailClicked = _passClicked = false;
//                       });
//                     },
//                     onSubmit: (val) {
//                       setState(() {
//                         _nameClicked = false;
//                       });
//                     },
//                     validator: (val) =>
//                         (val ?? "").trim().length == 0 ? "أدخِل اسمك" : null,
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 30,
//                     vertical: 12,
//                   ),
//                   child: AuthTextField(
//                     controller: _emailController,
//                     color: _emailClicked
//                         ? Theme.of(context).primaryColor
//                         : Theme.of(context).accentColor,
//                     imgName: "email",
//                     hintTxt: "البريد الإلكتروني",
//                     onTap: () {
//                       setState(() {
//                         _emailClicked = true;
//                         _nameClicked = _passClicked = false;
//                       });
//                     },
//                     onSubmit: (val) {
//                       setState(() {
//                         _emailClicked = false;
//                       });
//                     },
//                     validator: (val) => (val ?? "").trim().length == 0
//                         ? "أدخِل بريدك الإلكتروني"
//                         : null,
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 30,
//                     vertical: 12,
//                   ),
//                   child: AuthTextField(
//                     controller: _passController,
//                     color: _passClicked
//                         ? Theme.of(context).primaryColor
//                         : Theme.of(context).accentColor,
//                     imgName: "password",
//                     hintTxt: "كلمة المرور",
//                     isObscure: true,
//                     onTap: () {
//                       setState(() {
//                         _passClicked = true;
//                         _emailClicked = _nameClicked = false;
//                       });
//                     },
//                     onSubmit: (val) {
//                       setState(() {
//                         _passClicked = false;
//                       });
//                     },
//                     validator: (val) => (val ?? "").length < 8
//                         ? "كلمة المرور تتطلب 8 رموز أو أكثر"
//                         : null,
//                   ),
//                 ),
//                 Container(
//                   margin: EdgeInsets.only(top: 12),
//                   decoration: BoxDecoration(
//                     boxShadow: [
//                       BoxShadow(
//                           blurRadius: 20,
//                           color: Theme.of(context).shadowColor,
//                           offset: const Offset(0, 5))
//                     ],
//                   ),
//                   child: ElevatedButton(
//                     onPressed: () async {
//                       showLoading();
//                       if (_formKey.currentState?.validate() ?? false) {
//                         try {
//                           RecipeUser? user = await _auth.signUpEmail(
//                             _nameController.text.trim(),
//                             _emailController.text.trim(),
//                             _passController.text.trim(),
//                           );
//                           if (user == null) {
//                             setState(() {
//                               _msg = "البريد الإلكتروني غير صحيح";
//                             });
//                             _nameController.clear();
//                             _emailController.clear();
//                             _passController.clear();
//                           } else {
//                             Navigator.pop(context);
//                           }
//                         } catch (err) {
//                           if (err.toString() ==
//                               "سبق استخدام البريد الإلكتروني المدخل") {
//                             setState(() {
//                               _msg = err.toString();
//                             });
//                           }
//                         }
//                       }
//                       Navigator.pop(context);
//                     },
//                     child: Padding(
//                       padding: const EdgeInsets.all(10),
//                       child: Text(
//                         "تسجيل الدخول",
//                         style: Theme.of(context).textTheme.bodyText1?.copyWith(
//                             color: Theme.of(context).accentColor,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       primary: Theme.of(context).primaryColor,
//                       elevation: 0,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.all(
//                           Radius.circular(10),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
