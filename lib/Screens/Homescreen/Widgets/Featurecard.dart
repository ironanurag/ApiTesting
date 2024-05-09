
  import 'package:flutter/material.dart';

Widget featureCard(  String title, VoidCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Container(
          width: 200,
          height: 200,
          child: Center(child: Text(title)),
        ),
      ),
    );
  }

