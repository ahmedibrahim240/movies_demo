import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? size;
  final int? maxLines;
  final TextOverflow? textOverflow;

  const CustomText({
    Key? key,
    required this.text,
    this.color = Colors.white,
    this.size = 14,
    this.maxLines,
    this.textOverflow = TextOverflow.ellipsis,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final TextStyle headline4 = Theme.of(context).textTheme.headline4!.copyWith(
          color: color,
          fontSize: size,
          fontWeight: FontWeight.bold,
        );
    return Text(
      text,
      overflow: textOverflow,
      maxLines: maxLines,
      style: GoogleFonts.oswald(textStyle: headline4),
    );
  }
}
