import 'package:flutter/material.dart';

import 'auth_card.dart';
import 'app_banner.dart';

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    final deviceSize = MediaQuery.of(context).size;

    const drinkImage = 'https://cdn.tgdd.vn/2021/11/CookDish/nuoc-ep-trai-cay-de-duoc-bao-lau-cach-bao-quan-nuoc-ep-trai-avt-1200x676-2.jpg';

    return Scaffold(

      body: Stack(
        children: <Widget>[
          //1.
          Image.network(
            drinkImage,
            height: double.infinity,
            fit: BoxFit.cover,
          ),

          SingleChildScrollView(

            child: SizedBox(
              height: deviceSize.height,
              width: deviceSize.width,

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Flexible(
                    child: AppBanner(),
                  ),
                  Flexible(
                    flex: deviceSize.width > 600 ? 2 : 1,
                    child: const AuthCard(),
                  ),
                ],
              ),
              
            ),
          ),

        ],
      ),
    );

  }
}
