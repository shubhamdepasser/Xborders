import 'package:flutter/material.dart';

class submitButtonCustom extends StatelessWidget {
  final Widget widget;
  final bool isSmall;
  final bool isHorizontal;
  final GestureTapCallback onTap;

  const submitButtonCustom({
    Key key,
    this.widget,
    this.onTap,
    this.isSmall = false,
    this.isHorizontal = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Container(
            height: 40,
            width: 200,
            decoration: BoxDecoration(
               // ignore: prefer_const_literals_to_create_immutables
               boxShadow: [
                    // ignore: prefer_const_constructors
                    BoxShadow(
                      color: Colors.lightBlue.shade100,
                      offset: const Offset(
                        0.0,
                        4.0,
                      ),
                      blurRadius: 9.0,
                      spreadRadius: 2.0,
                    ), 
                    // ignore: prefer_const_constructors
                  ],
                borderRadius: BorderRadius.circular(30),
                gradient: LinearGradient(
    colors: <Color>[Colors.blue.shade900, Colors.lightBlueAccent],
                ),
     ), child: widget));
  }
}