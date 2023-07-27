import 'package:xborders/core/utilities/style/style.dart';
import 'package:xborders/core/utilities/variable.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:xborders/core/utilities/image_data/image_itlscanner.dart';
import 'package:xborders/core/utilities/image_data/my_icons.dart';

class Photo extends StatelessWidget {
  var file1base64 = '';

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () {},
      child: Container(
          width: MediaQuery.of(context).size.width * 0.4,
          padding: const EdgeInsets.only(left: 8.0),
          child: DottedBorder(
              child: file1base64 == ''
                  ? Container(
                      height: 120,
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 0.42,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: ImageItlscanner(
                              image: AppIconImage.uploadimage,
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          InkWell(
                            onTap: () {},
                            child: Text(
                              Variable.taptoupload,
                              textAlign: TextAlign.center,
                              style: uploadimagetext,
                            ),
                          )
                        ],
                      ))
                  : Container())),
    );
  }

  void printLongString(String text) {
    final RegExp pattern = RegExp('.{1,800}');
    pattern
        .allMatches(text)
        .forEach((RegExpMatch match) => print(match.group(0)));
  }
}
