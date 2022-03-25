import 'package:flutter/material.dart';

import '../../core/core_export.dart';

class NotFoundScreen extends StatelessWidget {
  final String text;
  const NotFoundScreen({
    Key? key,
    this.text = 'Deep linknot found ',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomText(
          text: text,
          color: Colors.red,
          maxLines: null,
        ),
      ),
    );
  }
}
