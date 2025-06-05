import 'package:flutter/material.dart';

import 'package:frontend/home_page/home_controller.dart';
import 'package:frontend/login_page/login_controller.dart';
import 'package:frontend/login_page/login_view.dart';
import 'package:frontend/user_auth_controller.dart';
import 'package:get/get.dart';

class PatientHomeView extends StatelessWidget {
  final _controllerA = Get.find<AuthController>();
  final LoginController loginController = Get.put(LoginController());
  final UserHomeDataController userDataController = Get.put(UserHomeDataController());
  PatientHomeView({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome ${_controllerA.userName}', style: TextStyle(fontSize: 16),),
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
      body:
        Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                     child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(24)),
                          ),
                          fixedSize: Size(120, 40)),
                      onPressed: () async {
                        await userDataController.updatePatientStatus("pending");
                      },
                       child: Text(
                        'Send Request',
                         style: TextStyle(
                          color: Colors.black87,
                           fontSize: 14,

                           ),
                           ),
                           
                           ),
                           ),

                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                    child: Align(alignment: Alignment.centerRight, child: Text('Search for Therapist Using ${_controllerA.userID}'),),
                )
                         ],
                         ),

          ],
        ),

    );
  }
}
