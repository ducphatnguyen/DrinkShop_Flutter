import 'package:flutter/material.dart';
import '../shared/flexible_space_widget.dart';

class HelpScreen extends StatelessWidget {
  static const routeName = '/help';

  const HelpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help'),
         flexibleSpace: const CustomFlexibleSpaceWidget(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            SizedBox(height: 10),
            Text(
              'Câu hỏi thường gặp',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Q: Làm thế nào để đặt nước?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'A: Để đặt nước, bạn có thể chọn sản phẩm từ danh sách nước, thêm vào giỏ hàng và tiến hành nhập vào SĐT để đặt hàng.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Q: Tôi muốn hủy đơn hàng, làm thế nào?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'A: Để hủy đơn hàng, bạn cần liên hệ với chúng tôi qua số điện thoại hoặc email để được hỗ trợ.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Q: Làm thế nào để thanh toán?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'A: Hiện tại cửa hàng vừa mới ra mắt nên chỉ có thanh toán khi nhận hàng.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),

            // Text(
            //   'Q: Đồ uống giao trong bao lâu?',
            //   style: TextStyle(
            //     fontSize: 18,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            // SizedBox(height: 10),
            // Text(
            //   'A: Nếu nằm trong khu vực, đồ uống sẽ giao trong 30p.',
            //   style: TextStyle(
            //     fontSize: 16,
            //   ),
            // ),
            // SizedBox(height: 20),

            Text(
              'Liên hệ',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Nếu bạn gặp bất kỳ vấn đề gì khi sử dụng ứng dụng của chúng tôi, vui lòng liên hệ với chúng tôi qua:',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '- Email: drinkshop@support.com',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '- Số điện thoại: 0123456789',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
