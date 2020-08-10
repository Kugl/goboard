import 'package:flutter/material.dart';

class SnackWrap {
  static void createSnackBar(BuildContext context, {String text}) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Center(
        child: Text(text),
        heightFactor: 1,
      ),
    ));
  }

  static void dismissSnackbar(BuildContext context) {
    Scaffold.of(context)
        .removeCurrentSnackBar(reason: SnackBarClosedReason.dismiss);
  }
}
