import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextFiled extends StatelessWidget{
  final TextEditingController controller;
  final String labelText;
  const CustomTextFiled({Key?key,required this.controller,required this.labelText}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      textAlign: TextAlign.start,
      decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.cyan,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(6))),
    );
  }
}
