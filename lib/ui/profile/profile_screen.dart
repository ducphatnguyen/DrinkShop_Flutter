import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/ui/auth/auth_manager.dart';
import '../shared/flexible_space_widget.dart';
import '../profile/about.dart';
import '../profile/help.dart';

class ProfileOverviewScreen extends StatelessWidget {
  static const routeName = '/profile';
  const ProfileOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hồ sơ cá nhân'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Xử lý khi người dùng nhấn vào
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Xử lý khi người dùng nhấn vào
            },
          ),
        ],
        flexibleSpace: const CustomFlexibleSpaceWidget(),
      ),
      body: ListView(
        children: <Widget>[
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 10.0,
                ),
                width: double.infinity,
                color: const Color.fromARGB(255, 170, 201, 34),
                child: Column(
                  children: const <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    CircleAvatar(
                      radius: 50, // Điều chỉnh kích thước avatar của bạn
                      backgroundImage: NetworkImage(
                        'https://th.bing.com/th/id/OIP.sI62YQTmpshAV_YediafhQHaHa?pid=ImgDet&rs=1', // URL hình ảnh của bạn
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'NGUYỄN PHÁT ĐỨC',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.assignment, color: Colors.red),
                          onPressed: () {
                            Navigator.of(context).pushNamed('/user-orders');
                          },
                        ),
                        const Text('Đơn hàng'),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.discount, color: Colors.red),
                          onPressed: () {
                            // Navigator.of(context).pushReplacementNamed('/');
                          },
                        ),
                        const Text('Coupon'),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                          icon:
                              const Icon(Icons.location_on, color: Colors.red),
                          onPressed: () {},
                        ),
                        const Text('Địa điểm'),
                      ],
                    ),
                  ],
                ),
                const Divider(),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(AboutScreen.routeName);
                  },
                  child: ListTile(
                    title: Row(
                      children: const [
                        Icon(Icons.info, color: Colors.red),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text("Giới thiệu cửa hàng"),
                        ),
                        Icon(Icons.arrow_forward_ios),
                      ],
                    ),
                  ),
                ),
                const Divider(),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(HelpScreen.routeName);
                  },
                  child: ListTile(
                    title: Row(
                      children: const [
                        Icon(Icons.help, color: Colors.red),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text("Giúp đỡ"),
                        ),
                        Icon(Icons.arrow_forward_ios),
                      ],
                    ),
                  ),
                ),
                const Divider(),
                const ListTile(
                  leading: Icon(Icons.phone, color: Colors.red),
                  title: Text("Hotline hỗ trợ"),
                  subtitle: Text("0123456789"),
                ),
                const Divider(),
                const ListTile(
                  leading: Icon(Icons.location_on, color: Colors.red),
                  title: Text("Địa chỉ cửa hàng"),
                  subtitle: Text("Trường Đại học Cần Thơ, CTU"),
                ),
                const Divider(),
                // GestureDetector(
                //   onTap: () {
                //     Navigator.of(context).pushNamed(AboutScreen.routeName);
                //   },
                //   child: ListTile(
                //     title: Row(
                //       children: const [
                //         Icon(Icons.info, color: Colors.red),
                //         SizedBox(width: 8),
                //         Expanded(
                //           child: Text("Giới thiệu cửa hàng"),
                //         ),
                //         Icon(Icons.arrow_forward_ios),
                //       ],
                //     ),
                //   ),
                // ),
                // const Divider(),
                const ListTile(
                  leading: Icon(Icons.comment, color: Colors.red),
                  title: Text("Giờ mở cửa"),
                  subtitle: Text("07:00 - 22:00 (24/7)"),
                ),
                const Divider(),
                // const SizedBox(
                //   height: 10,
                // ),
                SizedBox(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                        ..pop()
                        ..pushReplacementNamed('/');
                      context.read<AuthManager>().logout();
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    //Text của button
                    child: const Text(
                      'ĐĂNG XUẤT',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const Divider(),
                const Text(
                  "Phiên bản hiện tại: v1.34.2 @2023",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
