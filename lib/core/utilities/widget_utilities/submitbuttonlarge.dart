import 'package:xborders/core/utilities/widget_utilities/buttoncustom.dart';
import 'package:flutter/material.dart';

class submitButtonLarge extends StatelessWidget {
  final String text;
  final bool isMargin;
  final GestureTapCallback onTap;

  const submitButtonLarge({
    Key key,
    this.text,
    this.onTap,
    this.isMargin = false,
    Function() onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        margin: isMargin
            ? EdgeInsets.symmetric(vertical: 5, horizontal: 25)
            : EdgeInsets.all(0),
        // ignore: missing_required_param
        child: submitButtonCustom(
          widget: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  // padding: const EdgeInsets.all(8.0),
                  child: Text(text,
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontStyle: FontStyle.normal,
                          letterSpacing: 0,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 14)))
            ],
          ),
          onTap: onTap,
        ));
  }
}
