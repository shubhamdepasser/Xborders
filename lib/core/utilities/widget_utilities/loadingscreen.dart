import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class loadingscreen extends StatelessWidget {
  const loadingscreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      color: Colors.white,
      child: Center(
        child: SpinKitThreeBounce(
          color: Colors.blue,
          size: 50.0,
        ),
      ),
    );
  }
}
