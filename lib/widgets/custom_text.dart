import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String? text;
  final Color? color;
  final double? size;
  final FontWeight? fontWeight;
  final TextAlign? textalign;
  final Color? backgroundcolor;
  const CustomText({
    Key? key,
    this.text,
    this.color,
    this.size,
    this.fontWeight,
    this.textalign,
    this.backgroundcolor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,overflow: TextOverflow.ellipsis,maxLines: 2,
      softWrap: false,
      textAlign: textalign,
      style: TextStyle(
        fontFamily:'Righteous',
          color: color,
          fontSize: size,
          fontWeight: fontWeight,
          backgroundColor: backgroundcolor),
    );
  }
}
