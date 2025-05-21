import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RoundedButton extends StatelessWidget {
  var ontap;
  String title;
  var color;
  var borderColor;
  var textcolor;
  double radius;
  double fontsize;
  FontWeight fontweigth;
  double height;
  RoundedButton(
      {super.key,
      required this.ontap,
      required this.title,
      required this.color,
      this.radius = 12,
      this.borderColor,
      this.height=50,
      this.fontweigth=FontWeight.w500,
      this.fontsize=16,
      required this.textcolor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
          height: height,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: borderColor==null? color: borderColor),
            color: color,
            borderRadius: BorderRadius.circular(radius),
          ),
          child: Center(
              child: Text(
            title,
            style: GoogleFonts.montserrat(
                fontSize: fontsize, color: textcolor, fontWeight: fontweigth),
          ))),
    );
  }
}
