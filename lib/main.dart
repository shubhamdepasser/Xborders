// import 'package:xborders/module/reprintscan/views/reprint_scan_yes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'core/network/binding/network_binding.dart';
import 'core/routes/app_routes.dart';
import 'core/utilities/variable.dart';
import 'module/auth_user/Controller/userController.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Get.isLogEnable) Get.isLogEnable = true;
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setEnabledSystemUIOverlays(
      [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  await GetStorage.init();
  Get.put(LoginController(), permanent: true);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: Variable.incommingshipments,
        debugShowCheckedModeBanner: false,
        initialRoute: Get.find<LoginController>().navigatingRoute(),
        // home: ToggleButton(),
        getPages: RoutesApp.routes,
        initialBinding: NetworkBinding());
  }
}



class ToggleButton extends StatefulWidget {
  @override
  _ToggleButtonState createState() => _ToggleButtonState();
}

const double width = 60;
const double height = 30;
const double loginAlign = -1;
const double signInAlign = 1;
const Color selectedColor = Colors.white;
const Color normalColor = Colors.black54;

class _ToggleButtonState extends State<ToggleButton> {
  double xAlign;
  Color loginColor;
  Color signInColor;

  @override
  void initState() {
    super.initState();
    xAlign = loginAlign;
    loginColor = selectedColor;
    signInColor = normalColor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo'),
      ),
      body: Center(
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.all(
              Radius.circular(50.0),
            ),
          ),
          child: Stack(
            children: [
              AnimatedAlign(
                alignment: Alignment(xAlign, 0),
                duration: Duration(milliseconds: 300),
                child: Container(
                  width: width * 0.5,
                  height: height,
                  decoration: BoxDecoration(
                    color: Colors.lightGreen,
                    borderRadius: BorderRadius.all(
                      Radius.circular(50.0),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    xAlign = loginAlign;
                    loginColor = selectedColor;

                    signInColor = normalColor;
                  });
                },
                child: Align(
                  alignment: Alignment(-1, 0),
                  child: Container(
                    width: width * 0.5,
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: loginColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    xAlign = signInAlign;
                    signInColor = selectedColor;

                    loginColor = normalColor;
                  });
                },
                child: Align(
                  alignment: Alignment(1, 0),
                  child: Container(
                    width: width * 0.5,
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    child: Text(
                      'Signin',
                      style: TextStyle(
                        color: signInColor,
                        fontWeight: FontWeight.bold,
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
  }
}



// import 'package:flutter/material.dart';  
// import 'package:custom_switch/custom_switch.dart';  
  
// void main() => runApp(MyApp());  
  
// class MyApp extends StatelessWidget {  
//   @override  
//   Widget build(BuildContext context) {  
//     return MaterialApp(  
//         home: Scaffold(  
//             appBar: AppBar(  
//               backgroundColor: Colors.blue,  
//               title: Text("Custom Switch Example"),  
//             ),  
//             body: Center(  
//                   child: SwitchScreen()  
//             ),  
//         )  
//     );  
//   }  
// }  
  
// class SwitchScreen extends StatefulWidget {  
//   @override  
//   SwitchClass createState() => new SwitchClass();  
// }  
  
// class SwitchClass extends State {  
//   bool isSwitched = false;  
//   @override  
//   Widget build(BuildContext context) {  
//     return Column(  
//         mainAxisAlignment: MainAxisAlignment.center,  
//         children:<Widget>[  
//             CustomSwitch(  
//               value: isSwitched,  
//               activeColor: Colors.blue,  
//               onChanged: (value) {  
//                 print("VALUE : $value");  
//                 setState(() {  
//                   isSwitched = value;  
//                 });  
//               },  
//             ),  
//           SizedBox(height: 15.0,),  
//           Text('Value : $isSwitched', style: TextStyle(color: Colors.red,  
//               fontSize: 25.0),)  
//         ]);  
//     }  
// } 