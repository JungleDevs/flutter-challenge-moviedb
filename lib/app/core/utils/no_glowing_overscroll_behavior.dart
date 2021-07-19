import 'package:flutter/material.dart';

/// When attached to an scrollable widget will remove the glowing effect of when
/// scrolling after reach end/start of the list
class NoGlowingOverscrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
    BuildContext context,
    Widget child,
    AxisDirection axisDirection,
  ) {
    return child;
  }
}
