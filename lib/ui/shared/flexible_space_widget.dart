import 'package:flutter/material.dart';

class CustomFlexibleSpaceWidget extends StatelessWidget {
  const CustomFlexibleSpaceWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const NetworkImage(
              'https://topbrands.vn/wp-content/uploads/2021/08/Nuoc-ep-trai-cay-dong-chai.jpg'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.5),
            BlendMode.darken,
          ),
        ),
      ),
    );
  }
}
