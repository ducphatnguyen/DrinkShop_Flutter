import 'package:flutter/material.dart';
import '../shared/flexible_space_widget.dart';

class AboutScreen extends StatelessWidget {
  static const routeName = '/about';

  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About us'),
        flexibleSpace: const CustomFlexibleSpaceWidget(),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Chào mừng đến với drink shop!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Đến với drink shop, bạn sẽ tận hưởng những chai nước được thiết kế bắt mắt, hương vị ngọt ngào và tươi mới, rất phù hợp trong thời tiết nóng nực này.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 20),
            const Text(
               'Đến với drink shop, bạn sẽ tận hưởng những chai nước được thiết kế bắt mắt, hương vị ngọt ngào và tươi mới, rất phù hợp trong thời tiết nóng nực này.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 20),
            const Text(
              'Đến với drink shop, bạn sẽ tận hưởng những chai nước được thiết kế bắt mắt, hương vị ngọt ngào và tươi mới, rất phù hợp trong thời tiết nóng nực này.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 20),
            const Text(
              'Vậy còn chần chờ gì nữa mà không đặt ngay cho mình những chai nước ngon ngọt nào!',
              style: TextStyle(
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 200),
            ElevatedButton.icon(
              icon: const Icon(Icons.home),
              label: const Text('Trở lại trang chủ'),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/');
              },
            ),
            
          ],
        ),
      ),


    );
  }
}
