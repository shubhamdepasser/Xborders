import 'dart:math' as math;
//import 'package:xborders/core_2/core.dart';
import 'package:xborders/core/utilities/style/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Stack(children: [
      // SpinKitThreeBounce(color: Color(0xFFF0065FF), size: 40)
    ]));
  }
}

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Loading());
  }
}

class LoadingScreenDialog {
  LoadingScreenDialog.show(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => Loading());
  }

  LoadingScreenDialog.end(BuildContext context) {
    Navigator.pop(context);
  }
}

class LoaderButton extends StatelessWidget {
  const LoaderButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SleekCircularSlider(
        max: 100,
        min: 0,
        initialValue: 90,
        appearance: CircularSliderAppearance(
            animationEnabled: true,
            size: 32,
            customColors: CustomSliderColors(
                trackColor: transparent,
                progressBarColors: [white, white.withOpacity(0.3)]),
            customWidths: CustomSliderWidths(
                trackWidth: 4, shadowWidth: 5, progressBarWidth: 6),
            spinnerMode: true));
  }
}

///
///
const double _kDefaultIndicatorRadius = 10.0;

const Color _kActiveTickColor = CupertinoDynamicColor.withBrightness(
    color: Color(0xFF172B4D), darkColor: Color(0xFF172B4D));

enum CupertinoActivityIndicatorIOSVersionStyle {
  @Deprecated('Use iOS14 instead. '
      'This feature was deprecated after v1.21.0-1.0.pre.')
  iOS13,

  /// The style that was introduced in iOS14 (8 points).
  iOS14,
}

/// An iOS-style activity indicator that spins clockwise.
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=AENVH-ZqKDQ}
///
/// See also:
///
///  * <https://developer.apple.com/ios/human-interface-guidelines/controls/progress-indicators/#activity-indicators>
class CupertinoActivityIndicator extends StatefulWidget {
  /// Creates an iOS-style activity indicator that spins clockwise.
  const CupertinoActivityIndicator({
    Key key,
    this.animating = true,
    this.radius = _kDefaultIndicatorRadius,
    @Deprecated('Leave this field default to use latest style. '
        'This feature was deprecated after v1.21.0-1.0.pre.')
        this.iOSVersionStyle = CupertinoActivityIndicatorIOSVersionStyle.iOS14,
  })  : assert(animating != null),
        assert(radius != null),
        assert(radius > 0.0),
        progress = 1.0,
        super(key: key);

  /// Creates a non-animated iOS-style activity indicator that displays
  /// a partial count of ticks based on the value of [progress].
  ///
  /// When provided, the value of [progress] must be between 0.0 (zero ticks
  /// will be shown) and 1.0 (all ticks will be shown) inclusive. Defaults
  /// to 1.0.
  const CupertinoActivityIndicator.partiallyRevealed({
    Key key,
    this.radius = _kDefaultIndicatorRadius,
    this.progress = 1.0,
    @Deprecated('Leave this field default to use latest style. '
        'This feature was deprecated after v1.21.0-1.0.pre.')
        this.iOSVersionStyle = CupertinoActivityIndicatorIOSVersionStyle.iOS14,
  })  : assert(radius != null),
        assert(radius > 0.0),
        assert(progress != null),
        assert(progress >= 0.0),
        assert(progress <= 1.0),
        animating = false,
        super(key: key);

  /// Whether the activity indicator is running its animation.
  ///
  /// Defaults to true.
  final bool animating;

  /// Radius of the spinner widget.
  ///
  /// Defaults to 10px. Must be positive and cannot be null.
  final double radius;

  /// Determines the percentage of spinner ticks that will be shown. Typical usage would
  /// display all ticks, however, this allows for more fine-grained control such as
  /// during pull-to-refresh when the drag-down action shows one tick at a time as
  /// the user continues to drag down.
  ///
  /// Defaults to 1.0. Must be between 0.0 and 1.0 inclusive, and cannot be null.
  final double progress;

  final CupertinoActivityIndicatorIOSVersionStyle iOSVersionStyle;

  @override
  _CupertinoActivityIndicatorState createState() =>
      _CupertinoActivityIndicatorState();
}

class _CupertinoActivityIndicatorState extends State<CupertinoActivityIndicator>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    if (widget.animating) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(CupertinoActivityIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animating != oldWidget.animating) {
      if (widget.animating)
        _controller.repeat();
      else
        _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.radius * 2,
      width: widget.radius * 2,
      child: CustomPaint(
        painter: _CupertinoActivityIndicatorPainter(
          position: _controller,
          activeColor:
              CupertinoDynamicColor.resolve(_kActiveTickColor, context),
          radius: widget.radius,
          progress: widget.progress,
          iOSVersionStyle: widget.iOSVersionStyle,
        ),
      ),
    );
  }
}

const double _kTwoPI = math.pi * 2.0;

const Map<CupertinoActivityIndicatorIOSVersionStyle, List<int>>
    _kAlphaValuesMap = <CupertinoActivityIndicatorIOSVersionStyle, List<int>>{
  CupertinoActivityIndicatorIOSVersionStyle.iOS13: <int>[
    47,
    47,
    47,
    47,
    64,
    81,
    97,
    114,
    131,
    147,
    47,
    47
  ],

  /// Alpha values for new style that introduced in iOS14.
  CupertinoActivityIndicatorIOSVersionStyle.iOS14: <int>[
    47,
    47,
    47,
    47,
    72,
    97,
    122,
    147,
  ],
};

/// The alpha value that is used to draw the partially revealed ticks.
const int _partiallyRevealedAlpha = 147;

class _CupertinoActivityIndicatorPainter extends CustomPainter {
  _CupertinoActivityIndicatorPainter({
    @required this.position,
    @required this.activeColor,
    @required this.radius,
    @required this.progress,
    CupertinoActivityIndicatorIOSVersionStyle iOSVersionStyle =
        CupertinoActivityIndicatorIOSVersionStyle.iOS13,
  })  : alphaValues = _kAlphaValuesMap[iOSVersionStyle],
        tickFundamentalRRect = RRect.fromLTRBXY(
          -radius / _kDefaultIndicatorRadius,
          -radius /
              (iOSVersionStyle ==
                      CupertinoActivityIndicatorIOSVersionStyle.iOS14
                  ? 3.0
                  : 2.0),
          radius / _kDefaultIndicatorRadius + .4,
          -radius,
          radius / _kDefaultIndicatorRadius,
          radius / _kDefaultIndicatorRadius,
        ),
        super(repaint: position);

  final Animation<double> position;
  final Color activeColor;
  final double radius;
  final double progress;

  final List<int> alphaValues;
  final RRect tickFundamentalRRect;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint();
    final int tickCount = alphaValues.length;

    canvas.save();
    canvas.translate(size.width / 2.0, size.height / 2.0);

    final int activeTick = (tickCount * position.value).floor();

    for (int i = 0; i < tickCount * progress; ++i) {
      final int t = (i - activeTick) % tickCount;
      paint.color = activeColor
          .withAlpha(progress < 1 ? _partiallyRevealedAlpha : alphaValues[t]);
      canvas.drawRRect(tickFundamentalRRect, paint);
      canvas.rotate(_kTwoPI / tickCount);
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(_CupertinoActivityIndicatorPainter oldPainter) {
    return oldPainter.position != position ||
        oldPainter.activeColor != activeColor ||
        oldPainter.progress != progress;
  }
}
