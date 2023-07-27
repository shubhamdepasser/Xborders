import 'package:xborders/core/utilities/image_data/image_itlscanner.dart';
import 'package:xborders/core/utilities/style/style.dart';
import 'package:flutter/material.dart';

class InvardCard extends StatelessWidget {
  final String img;
  final String num;
  final String word;
  const InvardCard({Key key, this.img, this.num, this.word}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 20,
                bottom: 20,
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 25),
                    child: ImageItlscanner(
                      image: img,
                      boxFit: BoxFit.fill,
                      height: 40,
                      width: 40,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        num,
                        style: phonenumberstyle,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        word,
                        style: alltext,
                      ),
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }
}
