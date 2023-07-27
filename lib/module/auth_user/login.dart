import 'package:xborders/core/utilities/image_data/image_itlscanner.dart';
import 'package:xborders/core/utilities/image_data/my_icons.dart';
import 'package:xborders/core/utilities/validation/validation_widget.dart';
import 'package:xborders/core/utilities/validation/validator_helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
//import 'package:form_field_validator/form_field_validator.dart';
import 'Controller/userController.dart';
// import 'package:get/get_state_manager/get_state_manager.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  LoginController loginController = new LoginController();
  String _name = '';
  // void validate(){
  //     if(formkey.currentState.validate()){
  //      print('validated');

  //     }else{
  //      print('Not Validated');
  //     }
  // }

  String validatepass(value) {
    if (value.isEmpty) {
      return "Password Required";
    }
    // }else if(value.length < 6){
    //     return "Should Be Atlest 6 Character";
    // }
    // else if(value.length > 15){
    //     return "Should Not Be More Than 15 Character";
    // }
    // else if(value.LoginController().loginUser(password.text.trim())){
    //     return "Email Id Wrong";
    // }
    else {
      return null;
    }
  }

  bool isEmailFirstClicked = false;
  bool isEmailClicked = false;
  bool isPasswordFirstClicked = false;
  bool isPasswordClicked = false;
  String emailCurrent = '';
  String passwordCurrent = '';

  bool isLoading = false;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool _obscureText = true;
  Widget child;
  double kDefaultPadding = 12;
  BoxShadow kDefaultShadow = const BoxShadow(
    offset: Offset(0, 15),
    blurRadius: 10,
    color: Colors.black12, // Black color with 12% opacity
  );

  var isShow = true.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: AppBar(
            // Here we create one to set status bar color
            backgroundColor: Colors
                .black, // Set any color of status bar you want; or it defaults to your theme's primary color
          )),
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      
      body: SingleChildScrollView(
        child: Form(
          //autovalidateMode: true,
          key: formkey,
          child: Container(
            height: MediaQuery.of(context).size.height * 1.0,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 50),
                  Container(
                    // color: Colors.grey[200],
                    child: ImageItlscanner(
                      image: AppIconImage.LoginImage,
                    ),
                    height: 250,
                    width: 250,
                    alignment: Alignment.center,
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 8),
                        Container(
                          padding: EdgeInsets.only(left: 30),
                          alignment: Alignment.topLeft,
                          // child: Text(
                          //   Variable.login,
                          //   style: incomingstyle,
                          // ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 50),
                  Column(
                    children: [
                      Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                            // ignore: prefer_const_literals_to_create_immutables
                            boxShadow: [
                              // ignore: prefer_const_constructors
                              BoxShadow(
                                color: Colors.grey.shade200,
                                offset: const Offset(
                                  0.0,
                                  5.0,
                                ),
                                blurRadius: 10.0,
                                spreadRadius: 7,
                              ),
                              // ignore: prefer_const_constructors
                            ],
                            color: Color(0xffF6F6F8),
                            borderRadius:
                                BorderRadius.circular(kDefaultPadding)),
                        padding: EdgeInsets.only(left: 12, bottom: 9),
                        child: TextFormField(
                          controller: email,
                          style: TextStyle(color: Color(0xff73738C)),
                          decoration: InputDecoration(
                            hintText: "Email",

                            //labelText: "Email",
                            prefixIcon: Icon(
                              Icons.alternate_email,
                            ),

                            // icon is 48px widget.
                            //   ),,

                            //hintText: "Email ID",
                            hintStyle: TextStyle(color: Color(0xff73738C)),
                          ),
                          onChanged: (String value) {
                            if (value.isNotEmpty) {
                              isEmailFirstClicked = false;
                            }
                            isEmailClicked = true;
                            emailCurrent = value;
                            setState(() {});
                          },
                          // validator: MultiValidator([
                          //   RequiredValidator(errorText: 'Email ID Required'),
                          //   EmailValidator(errorText: 'Not a Valid Email ID'),
                          // ]),
                        ),
                      ),
                      ValidationWidget(
                          isWidthStart: true,
                          isClicked: isEmailFirstClicked,
                          validationType: ValidationHelper.email,
                          isShow: isEmailClicked == false,
                          valueInput: emailCurrent),
                    ],
                  ),
                  SizedBox(height: 25),
                  Column(
                    children: [
                      Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                            // ignore: prefer_const_literals_to_create_immutables
                            boxShadow: [
                              // ignore: prefer_const_constructors
                              BoxShadow(
                                color: Colors.grey.shade200,
                                offset: const Offset(
                                  0.0,
                                  5.0,
                                ),
                                blurRadius: 10.0,
                                spreadRadius: 7,
                              ),
                              // ignore: prefer_const_constructors
                            ],
                            color: Color(0xffF6F6F8),
                            borderRadius:
                                BorderRadius.circular(kDefaultPadding)),
                        child: Container(
                          padding: EdgeInsets.only(
                            left: 12,
                            bottom: 9,
                          ),
                          child: TextFormField(
                            obscureText: _obscureText,
                            controller: password,
                            style: TextStyle(color: Color(0xff73738C)),
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.lock_outline,
                                ), // icon is 48px widget.

                                // enabledBorder: InputBorder.none,
                                hintText: "Password",
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _obscureText = !_obscureText;
                                        });
                                      },
                                      child: Icon(_obscureText
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility_outlined)),
                                ),
                                hintStyle: TextStyle(color: Color(0xff73738C))),
                            onChanged: (String value) {
                              if (value.isNotEmpty) {
                                isPasswordClicked = false;
                              }
                              isPasswordClicked = true;
                              passwordCurrent = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                      ValidationWidget(
                          isWidthStart: true,
                          isClicked: isPasswordFirstClicked,
                          validationType: ValidationHelper.name,
                          isShow: isPasswordClicked == false,
                          valueInput: passwordCurrent),
                    ],
                  ),
                  SizedBox(height: 50),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18)),
                        minimumSize: const Size(250, 50),
                        primary: Color(0xff0052cc)),
                    onPressed: () async {
                      Get.focusScope.unfocus();
                      if (ValidationHelper.checkValidation(
                          first: email.text.trim(),
                          type: ValidationHelper.email))
                        isEmailFirstClicked = true;
                      if (ValidationHelper.checkValidation(
                          first: password.text.trim(),
                          type: ValidationHelper.name))
                        isPasswordFirstClicked = true;
                      setState(() {});
    
                      if (!ValidationHelper.checkValidation(
                              first: email.text.trim(),
                              type: ValidationHelper.email) &&
                          !ValidationHelper.checkValidation(
                              first: password.text.trim(),
                              type: ValidationHelper.name)) {
                        setState(() {
                          isLoading = true;
                        });
                        await LoginController()
                            .loginUser(email.text.trim(), password.text.trim());
                        isLoading = false;
                      }

                      // Future.delayed(const Duration(seconds: 3), () {
                      //   setState(() {

                      //   });
                      // });
                    },
                    child: isLoading
                        ? Container(
                            width: MediaQuery.of(context).size.width * 0.15,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                // Text('Loading...', ),
                                SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  height: 18,
                                  width: 18,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : const Text('Login'),
                  ),
                  SizedBox(
                    height: 10,
                  )
                  // submitButtonLarge(
                  //   onTap: () async {
                  //     await LoginController()
                  //         .loginUser(email.text.trim(), password.text.trim());
                  //   },
                  //   text: 'Login',
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
