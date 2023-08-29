import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class YourImpact extends StatelessWidget {
  final String text;
  final String saved;
  final String image;

  YourImpact({required this.text, required this.saved, required this.image});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 3 - 20,
          height: MediaQuery.of(context).size.width / 3 - 20,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              image,
              fit: BoxFit.cover,
            ),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: MediaQuery.of(context).size.width / 3 - 20,
            height: MediaQuery.of(context).size.width / 3 - 20,
            color: Colors.black.withOpacity(0.3),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              saved,
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
