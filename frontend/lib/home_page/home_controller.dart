import 'dart:convert';

import 'package:frontend/login_page/login_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class UserHomeDataController extends GetxController {
  final LoginController loginController = Get.put(LoginController());
  var userData = {}.obs;
  var isLoading = true.obs;
  var username = ''.obs;
  var userID = ''.obs;
  bool isUserActive = false;
  
  
  @override
  void onInit() {
    super.onInit();
    fetchUserDataById();
  }

  void fetchUserDataById() async {
    final String baseUrl = 'http://127.0.0.1:8000/api';
    final userid = loginController.userId;
    
    final username = loginController.userName;
    print('this is userid variable from home_controller $userid');

    isLoading.value = true;

    try {
      final response = await http.get(
        Uri.parse('$baseUrl/patient/${userid}'),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      final data = jsonDecode(response.body);
      username.value = data['name'] as String? ?? 'No Name';
      print(username);
      userID.value = data['id_number'] as String? ?? 'No ID Available';
      print(userID);
      isUserActive = data['isActive'] ?? false;
      print(isUserActive);
      
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch user data: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
