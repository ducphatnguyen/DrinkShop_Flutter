import 'package:flutter/material.dart';

class AppBanner extends StatelessWidget {

  const AppBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
      child: const Text(
        'Bottle Drink',
        style: TextStyle(
          color: Colors.white,
          fontSize: 50,
          fontFamily: 'Anton',
          fontWeight: FontWeight.w400,
        ),
      ), 
    );
    
  }
}
