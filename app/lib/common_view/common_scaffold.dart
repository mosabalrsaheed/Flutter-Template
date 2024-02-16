import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

import '../app.dart';

class CommonScaffold extends StatelessWidget {
    /// A common scaffold widget that provides a consistent layout for the app.
  /// 
  /// The [body] widget represents the main content of the scaffold.
  /// The [appBar] widget represents the app bar at the top of the scaffold.
  /// The [drawer] widget represents the side drawer of the scaffold.
  /// The [floatingActionButton] widget represents the floating action button of the scaffold.
  /// The [backgroundColor] represents the background color of the scaffold.
  /// The [hideKeyboardWhenTouchOutside] determines whether the keyboard should be hidden when tapping outside the scaffold.
  const CommonScaffold({
    required this.body,
    this.appBar,
    this.floatingActionButton,
    this.drawer,
    this.backgroundColor,
    this.hideKeyboardWhenTouchOutside = false,
    super.key,
  });

     final Widget body;
    final PreferredSizeWidget? appBar;
    final Widget? drawer;
    final Widget? floatingActionButton;
    final Color? backgroundColor;
    final bool hideKeyboardWhenTouchOutside;

    @override
    Widget build(BuildContext context) {
      final scaffold = Scaffold(
        backgroundColor: backgroundColor,
        body: Shimmer(child: body),
        appBar: appBar,
        drawer: drawer,
        floatingActionButton: floatingActionButton,
      );

      return hideKeyboardWhenTouchOutside
          ? GestureDetector(
              onTap: () => ViewUtils.hideKeyboard(context),
              child: scaffold,
            )
          : scaffold;
    }
 
}
