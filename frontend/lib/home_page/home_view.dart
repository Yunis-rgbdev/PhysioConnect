import 'package:flutter/material.dart';
import 'package:frontend/home_page/home_controller.dart';
import 'package:frontend/login_page/login_controller.dart';
import 'package:frontend/login_page/login_view.dart';
import 'package:get/get.dart';

class PatientHomeView extends StatelessWidget {
  final LoginController loginController = Get.put(LoginController());
  final UserHomeDataController userDataController = Get.put(UserHomeDataController());
  PatientHomeView({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome ${loginController.userName} with ID: ${loginController.userId}', style: TextStyle(fontSize: 16),),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, size: 30, color: Colors.black),
            onPressed: () {
              loginController.logout();
              Get.offAll(() => LoginView());
              },
            ),  
        ],
        leading: IconButton(
          icon: Icon(Icons.person, size: 30),
          onPressed: () {
            // Handle menu button press
          },
        ),
        leadingWidth: 60,
      ),
      body: Center(
          child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue[300],
            shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0))),
        child: Text('Open Chat'),
        ),
      ),
    );
  }
}
