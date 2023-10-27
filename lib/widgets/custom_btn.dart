import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  String text;
  CustomButton({Key? key,required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
    margin: EdgeInsets.only(left: 16,right: 16),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Colors.redAccent,
      ),
      child: Center(
        child: Text(text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
        ),
      ),

      );
  }
}
