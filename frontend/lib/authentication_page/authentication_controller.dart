import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthController extends GetxController {
  final TextEditingController idNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController extraInfoController = TextEditingController();

  RxString idNumber = ''.obs;
  RxString password = ''.obs;
  RxString name = ''.obs;
  RxString age = ''.obs;
  RxString gender = ''.obs;
  RxString extra = ''.obs;
  RxBool obscurePassword = true.obs;

  @override
  void onInit() {
    super.onInit();
    
    idNumberController.addListener(() {
      idNumber.value = idNumberController.text;
    });
    
    passwordController.addListener(() {
      password.value = passwordController.text;
    });
    
    nameController.addListener(() {
      name.value = nameController.text;
    });
    
    ageController.addListener(() {
      age.value = ageController.text;
    });
    
    genderController.addListener(() {
      gender.value = genderController.text;
    });
    
    extraInfoController.addListener(() {
      extra.value = extraInfoController.text;
    });
  }

  @override
  void onClose() {
    idNumberController.dispose();
    passwordController.dispose();
    nameController.dispose();
    ageController.dispose();
    phoneNumberController.dispose();
    genderController.dispose();
    extraInfoController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }
  Future<void> sendAuth() async {
    final url = Uri.parse(
        'http://127.0.0.1:8000/auth/register/'); // Ensure trailing slash

    print(phoneNumberController.text);

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode({
          "id_number": idNumberController.text.trim(),
          "password": passwordController.text.trim(),
          "name": nameController.text.trim(),
          "age": ageController.text.trim(),
          "phone_number": phoneNumberController.text.trim(),
          "gender": genderController.text.trim(),
          "extra_info": extraInfoController.text.trim(),
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print("Success: $data");
      } else {
        print("Error: ${response.statusCode}, ${response.body}");
      }
    } catch (e) {
      print("Exception: $e");
    }
  }
}
