import 'package:xborders/core/utilities/image_data/image_itlscanner.dart';
import 'package:xborders/core/utilities/image_data/my_icons.dart';
import 'package:xborders/core/utilities/style/style.dart';
import 'package:flutter/material.dart';

class Bottomsheetpdff extends StatefulWidget {
  final String word;
  const Bottomsheetpdff({Key key, this.word}) : super(key: key);

  @override
  State<Bottomsheetpdff> createState() => _BottomsheetpdffState();
}

class _BottomsheetpdffState extends State<Bottomsheetpdff> {
  void initState() {
    super.initState();
    // reprintyes();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Container(
              width: MediaQuery.of(context).size.width * 0.6,
              child: Text(
                widget.word,
                style: PoppinsHeadingHwab,
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: ImageItlscanner(
              image: AppIconImage.print,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 0),
          child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.share,
                  size: 21,
                  color: Color(0xff374151),
                ),
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 0),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: ImageItlscanner(
              image: AppIconImage.close,
            ),
          ),
        ),
      ]),
      Column(children: [
        SizedBox(
          height: 10,
        ),
        Divider(
          thickness: 1,
          color: Color(0xffe5e7eb),
        ),
        SizedBox(
          height: 13,
        )
      ])
    ]));
  }
}
