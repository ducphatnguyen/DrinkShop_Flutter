import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'ui/auth/auth_manager.dart';
import 'ui/auth/auth_screen.dart';
import 'ui/splash_screen.dart';

import 'ui/screens.dart';

Future<void> main() async {
  //(1) Load the new .env file
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // (2) Create and provide AuthManager
        ChangeNotifierProvider(
          create: (context) => AuthManager(),
        ),

        ChangeNotifierProxyProvider<AuthManager, OrdersManager>(
          create: (ctx) => OrdersManager(),
          update: (ctx, authManager, ordersManager) {
            // Khi authManager có báo hiệu thay đổi thì đọc lại authToken
            // cho ordersManager
            ordersManager!.authToken = authManager.authToken;
            return ordersManager;
          },
        ),

        ChangeNotifierProxyProvider<AuthManager, ProductsManager>(
          create: (ctx) => ProductsManager(),
          update: (ctx, authManager, productsManager) {
            // Khi authManager có báo hiệu thay đổi thì đọc lại authToken
            // cho productManager
            productsManager!.authToken = authManager.authToken;
            return productsManager;
          },
        ),

        ChangeNotifierProvider(
          create: (ctx) => CartManager(),
        ),

        // ChangeNotifierProvider(
        //   create: (ctx) => OrdersManager(),
        // ),
      ],

      // (3) Consume the AuthManager instance
      child: Consumer<AuthManager>(
        builder: (ctx, authManager, child) {
          return MaterialApp(
            title: 'My drink shop',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: 'Lato',
              colorScheme: ColorScheme.fromSwatch(
                primarySwatch: Colors.blue,
              ).copyWith(
                secondary: Colors.deepOrange, //Biểu tượng
              ),
            ),

            //Chỉ cần đăng ký xong nó sẽ kích hoạt autologin để đăng nhập tự động vào trang chi tiết sản phẩm
            home: authManager.isAuth
                ? const ProductsOverviewScreen()
                : FutureBuilder(
                    future: authManager.tryAutoLogin(),
                    builder: (ctx, snapshot) {
                      return snapshot.connectionState == ConnectionState.waiting
                          ? const SplashScreen()
                          : const AuthScreen();
                    },
                  ),

            routes: {
              CartScreen.routeName: (ctx) => const CartScreen(),
              UserOrdersScreen.routeName: (ctx) => const UserOrdersScreen(),
              UserProductsScreen.routeName: (ctx) => const UserProductsScreen(),

              AboutScreen.routeName: (ctx) => const AboutScreen(),
              ProfileOverviewScreen.routeName: (ctx) => const ProfileOverviewScreen(),
              ProductsWishlist.routeName: (ctx) => const ProductsWishlist(),
              HelpScreen.routeName: (ctx) => const HelpScreen(),

              //Test
              AllOrdersScreen.routeName: (ctx) => const AllOrdersScreen(),

            },

            // Tuyến đường mở rộng đến tài nguyên API
            onGenerateRoute: (settings) {
              //Lấy thông tin chi tiết sản phẩm thông qua productId trong trang ProductDetailScreen
              if (settings.name == ProductDetailScreen.routeName) {
                final productId = settings.arguments as String;
                return MaterialPageRoute(
                  builder: (ctx) {
                    return ProductDetailScreen(
                      ctx.read<ProductsManager>().findById(productId)!,
                    );
                  },
                );
              }

              //Lấy thông tin chi tiết đơn hàng thông qua orderId trong trang OrderDetailScreen
              if (settings.name == OrderDetailScreen.routeName) {
                final orderId = settings.arguments as String;
                return MaterialPageRoute(
                  builder: (ctx) {
                    return OrderDetailScreen(
                      // => sd this.order bên trang Order detail
                      ctx.read<OrdersManager>().findById(orderId)!,
                    );
                  },
                );
              }

              if (settings.name == EditProductScreen.routeName) {
                final productId = settings.arguments as String?;
                return MaterialPageRoute(
                  builder: (ctx) {
                    return EditProductScreen(
                      productId != null
                          ? ctx.read<ProductsManager>().findById(productId)
                          : null,
                    );
                  },
                );
              }

              return null;
            },
          );
        },
      ),
    );
  }
}
