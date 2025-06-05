import 'package:flutter/material.dart';
import 'package:frontend/authentication_page/patient_authentication/authentication_controller.dart';
import 'package:get/get.dart';
import 'package:persian_fonts/persian_fonts.dart';




class WavePatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    // Draw wave pattern
    final path1 = Path();
    path1.moveTo(0, size.height * 0.65);
    path1.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.7,
      size.width * 0.5,
      size.height * 0.65,
    );
    path1.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.6,
      size.width,
      size.height * 0.65,
    );
    path1.lineTo(size.width, size.height);
    path1.lineTo(0, size.height);
    path1.close();
    canvas.drawPath(path1, paint);

    // Draw circles
    final circlePaint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    // Draw various sized circles for the bubble effect
    canvas.drawCircle(
      Offset(size.width * 0.15, size.height * 0.2),
      size.width * 0.08,
      circlePaint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.4, size.height * 0.3),
      size.width * 0.05,
      circlePaint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.75, size.height * 0.15),
      size.width * 0.1,
      circlePaint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.8, size.height * 0.4),
      size.width * 0.06,
      circlePaint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.2, size.height * 0.5),
      size.width * 0.04,
      circlePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class AuthView extends StatelessWidget {
  final AuthController controllerA = Get.put(AuthController());

  AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background wave pattern
          Positioned.fill(
            child: CustomPaint(
              painter: WavePatternPainter(),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () => Get.back(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    Text(
                      'Create\nAccount',
                      style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 48),
                    TextField(
                      controller: controllerA.nameController,
                      decoration: const InputDecoration(
                        hintText: 'Name',
                        prefixIcon: Icon(Icons.person_outline, color: Colors.blue),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: controllerA.idNumberController,
                      decoration: const InputDecoration(
                        hintText: 'ID Number',
                        prefixIcon: Icon(Icons.badge_outlined, color: Colors.blue),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: controllerA.ageController,
                      decoration: const InputDecoration(
                        hintText: 'Age',
                        prefixIcon: Icon(Icons.cake_outlined, color: Colors.blue),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: controllerA.phoneNumberController,
                      decoration: const InputDecoration(
                        hintText: 'Phone Number',
                        prefixIcon: Icon(Icons.phone_outlined, color: Colors.blue),
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                      hintText: 'Gender',
                      prefixIcon: Icon(Icons.people_outline, color: Colors.blue),
                      ),
                      items: ['Male', 'Female']
                        .map((gender) => DropdownMenuItem<String>(
                          value: gender,
                          child: Text(gender),
                          ))
                        .toList(),
                      onChanged: (value) {
                      controllerA.genderController.text = value ?? '';
                      },
                    ),
                    const SizedBox(height: 16),
                    Obx(() => TextField(
                      controller: controllerA.passwordController,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        prefixIcon: const Icon(Icons.lock_outline, color: Colors.blue),
                        suffixIcon: IconButton(
                          icon: Icon(
                            controllerA.obscurePassword.value 
                                ? Icons.visibility_off 
                                : Icons.visibility,
                            color: Colors.grey,
                          ),
                          onPressed: controllerA.togglePasswordVisibility,
                        ),
                      ),
                      obscureText: controllerA.obscurePassword.value,
                    )),
                    const SizedBox(height: 16),
                    TextField(
                      controller: controllerA.extraInfoController,
                      decoration: const InputDecoration(
                        hintText: 'Extra Information',
                        prefixIcon: Icon(Icons.info_outline, color: Colors.blue),
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 48),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white
                        ),
                        onPressed: controllerA.sendAuth,
                        child: Text('ثبت نام', style: PersianFonts.Yekan.copyWith(color: Colors.black87, fontSize: 18),),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Center(
                      child: TextButton(
                        onPressed: () => Get.toNamed('/login'),
                        child: const Text(
                          'Log in',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
