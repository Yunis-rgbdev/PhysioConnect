import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/home_page/home_view.dart';
import 'package:frontend/user_auth_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../home_page/home_controller.dart';

class LoginController extends GetxController {
  // final HomeController _controllerH = Get.put(HomeController());
  final AuthController _controllerA = Get.find<AuthController>();
  // RxString userName = ''.obs;
  var isLoggedIn = false.obs;
  final TextEditingController idController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final obscurePassword = true.obs;
  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;


  // Send Login data to Django API to login user
  // responses will be successful or unsuccessful
  // if successful the userId will be set to the id of the user
  Future<bool> sendLogin() async {
    if (idController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {
      errorMessage.value = 'Please enter both ID and password';
      return false;
    }
    isLoading.value = true;
    errorMessage.value = '';

    final url = Uri.parse('http://127.0.0.1:8000/auth/login/');
    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode({
          "id_number": idController.text.trim(),
          "password": passwordController.text.trim(),
        }),
      );
      isLoading.value = false;

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("Login Success: ${data['user_data']}");

        // here we fill the userid with LoggedIn user id if it was successful
        // and we set the isLoggedIn to true
        
        print("Filling the userId variables");
        String userID = data['user_data']['id_number'];
        String username = data['user_data']['name'];

        print('debugging $userID and $username');
        // setUserLoggedIn(userId, userName);

        if (userID.isNotEmpty) {
          print('saving parient: ${userID}, to main controller');
          _controllerA.setUserId(userID, username);
        }
          //navigating to user home page if login was successful
          print('Navigating to user home page.');
          Get.offAll(() => PatientHomeView());
          print('Navigated to user home page succesfully.');

        return true;
      } else {
        final errorData = jsonDecode(response.body);
        errorMessage.value = errorData['message'] ?? 'Login failed';
        return false;
      }
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = 'Network error. Please try again.';
      print("Login Exception: $e");
      return false;
    }
  }


  // if user login was successful this function will be called
  // and the userId will be used to intilialize data from database to homepage
  // and the isLoggedIn will be set to true
  // void setUserLoggedIn(String user, String name) async {
  //   userID = user.toString();
  //   name = userName.toString();
  //   print(user);
  //   isLoggedIn.value = true;
  // }

  // Logout
  void logout() async {
    _controllerA.userID.value = '';
    isLoggedIn.value = false;
  }
}