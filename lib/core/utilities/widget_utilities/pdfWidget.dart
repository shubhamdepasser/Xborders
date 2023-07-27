import 'package:xborders/core/utilities/image_data/image_itlscanner.dart';
import 'package:xborders/core/utilities/image_data/my_icons.dart';
import 'package:xborders/core/utilities/style/style.dart';
import 'package:xborders/core/utilities/variable.dart';
import 'package:flutter/material.dart';

//import '../../../core/';

class PdfWidget extends StatelessWidget {
  final GestureTapCallback onTap;
  final GestureTapCallback onTapClose;
  final bool isShowClose;

  const PdfWidget({
    Key key,
    @required this.onTap,
    this.onTapClose,
    this.isShowClose = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 4),
            child: Row(
                mainAxisAlignment: isShowClose
                    ? MainAxisAlignment.spaceBetween
                    : MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ImageItlscanner(
                            image: AppIconImage.print, width: 16, height: 18.3),
                        SizedBox(width: 10),
                        Text(Variable.download_PDF,
                            style: normalRubikSize(
                                color: Color(0xff0052cc), fontSize: 14))
                      ]),
                  //closedIcon(onTapClose: onTapClose, isClose: isShowClose)
                ])));
  }
}
