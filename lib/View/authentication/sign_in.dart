import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recipe/Model/authentication.dart';
import 'package:recipe/Model/user.dart';
import 'package:recipe/View/authentication/register.dart';
import 'package:recipe/View/Component/auth_text_field.dart';
import 'package:recipe/View/Component/loading.dart';



class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final Authentication _auth = Authentication();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool? _rememberMe = false;
  bool _emailClicked = false;
  bool _passClicked = false;
  String _msg = "";
  bool _done = false;

  Future loadingDialog() {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => Loading(),
    );
  }

  void showError() {
    if (!_done) ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      margin:  EdgeInsets.all(10),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Theme.of(context).accentColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5)
      ),
      content: Text(
        "من فضلك أدخل البيانات الصحيحة",
        textDirection: TextDirection.rtl,
      ),
    ));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
        automaticallyImplyLeading: false,
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
              Padding(
                padding: const EdgeInsets.only(
                  right: 8.0,
                ),
                child: Text(
                  "تسجيل الدخول",
                  style: Theme.of(context).textTheme.headline1?.copyWith(
                        color: Theme.of(context).accentColor,
                      ),
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
        titleSpacing: 0,
      ),
      body: SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SvgPicture.asset(
                    "assets/images/SignIn_illustration.svg",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(_msg,
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          color: Colors.red[400], fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 10,
                  ),
                  child: AuthTextField(
                    color: _emailClicked
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).accentColor,
                    controller: _emailController,
                    hintTxt: "البريد الإلكتروني",
                    imgName: "email",
                    onTap: () {
                      setState(() {
                        _emailClicked = true;
                        _passClicked = false;
                      });
                    },
                    onSubmit: (val) {
                      setState(() {
                        _emailClicked = false;
                      });
                    },
                    validator: (val) => (val ?? "").trim().isEmpty
                        ? "أدخِل بريدك الإلكتروني"
                        : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 10,
                  ),
                  child: AuthTextField(
                    color: _passClicked
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).accentColor,
                    controller: _passController,
                    imgName: "password",
                    hintTxt: "كلمة المرور",
                    isObscure: true,
                    onTap: () {
                      setState(() {
                        _passClicked = true;
                        _emailClicked = false;
                      });
                    },
                    onSubmit: (val) {
                      setState(() {
                        _passClicked = false;
                      });
                    },
                    validator: (val) => (val ?? "").length < 8
                        ? "كلمة المرور تتطلب 8 رموز أو أكثر"
                        : null,
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Row(
                    textDirection: TextDirection.rtl,
                    children: [
                      Checkbox(
                        value: _rememberMe,
                        onChanged: (val) {
                          setState(() {
                            _rememberMe = val;
                          });
                        },
                        fillColor: MaterialStateProperty.all(
                            Theme.of(context).accentColor),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(4),
                          ),
                        ),
                      ),
                      Text(
                        "تذكرني",
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              color: Theme.of(context).accentColor,
                            ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton(
                            child: Text(
                              "نسيت كلمة المرور؟",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).indicatorColor,
                                  ),
                              textAlign: TextAlign.left,
                            ),
                            onPressed: () {
                              // Navigate to comming soon page
                            },
                            style: TextButton.styleFrom(
                              onSurface: Theme.of(context).backgroundColor,
                              primary: Theme.of(context).backgroundColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
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
                      loadingDialog();
                      //TODO: "Remember me" is not pragrammed
                      //TODO: Forget password
                      if (_formKey.currentState?.validate() ?? false) {
                        // TODO: Delete print
                        print(_emailController.text);
                        print(_passController.text);

                        RecipeUser? user = await _auth.signInEmail(
                          _emailController.text.trim(),
                          _passController.text.trim(),
                        );

                        if (user == null) {
                          setState(() {
                            _msg = "البريد الإلكتروني أو كلمة المرور غير صحيحة";
                          });
                        } else {
                          print(user.name);
                          Navigator.pop(context);
                          _done = true;
                        }
                      }
                      _emailController.clear();
                      _passController.clear();
                      Navigator.pop(context);

                      showError();

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
                TextButton(
                  style: TextButton.styleFrom(
                      primary: Theme.of(context).backgroundColor),
                  child: Text(
                    "أنشئ حساب جديد",
                    textDirection: TextDirection.rtl,
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          color: Theme.of(context).indicatorColor,
                        ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUp(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// add it to the component folder
