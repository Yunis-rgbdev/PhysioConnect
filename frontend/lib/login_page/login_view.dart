import 'package:flutter/material.dart';
import 'package:frontend/login_page/login_controller.dart';
import 'package:frontend/user_auth_controller.dart';
import 'package:frontend/welcome_page/welcome_view.dart';
import 'package:get/get.dart';

class WavePatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
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


class LoginView extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());
final _controllerA = Get.find<AuthController>();
  
  LoginView({super.key});

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Get.to(WelcomeScreen()),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Welcome\nBack',
                    style: TextStyle(
                      color: Colors.white,
                        fontSize: 28,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(height: 48),
                    TextField(
                    controller: controller.idController,
                    decoration: InputDecoration(
                      hintText: 'ID',
                      hintStyle: const TextStyle(color: Colors.black45),
                        prefixIcon: const Icon(Icons.perm_identity, color: Colors.blue),
                      suffixIcon: Obx(() => _controllerA.userID.value.isNotEmpty
                        ? const Icon(Icons.check_circle, color: Colors.green)
                        : const SizedBox()),
                    ),
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.black),
                    ),
                  const SizedBox(height: 16),
                  Obx(() => TextField(
                    controller: controller.passwordController,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      prefixIcon: const Icon(Icons.lock_outline, color: Colors.blue),
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.obscurePassword.value 
                              ? Icons.visibility_off 
                              : Icons.visibility,
                          color: Colors.grey,
                        ),
                        onPressed: controller.togglePasswordVisibility,
                      ),
                    ),
                    style: TextStyle(color: Colors.black),
                    obscureText: controller.obscurePassword.value,
                  )),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Forgot password?',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: controller.sendLogin,
                      child: const Text('Log in'),
                    ),
                  ),
                  const Spacer(),
                  Center(
                    child: TextButton(
                      onPressed: () => Get.toNamed('/signup'),
                      child: const Text(
                        'Sign up',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
    // return Scaffold(
    //   backgroundColor: Colors.white,
    //   body: Directionality(
    //     textDirection: TextDirection.rtl,
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [
    //         SizedBox(height: 150), // Add white space at the top
    //         Expanded(
    //           child: Align(
    //             alignment: Alignment.bottomCenter,
    //             child: Padding(
    //               padding: const EdgeInsets.symmetric(horizontal: 0.0),
    //               child: Container(
    //                 padding: EdgeInsets.symmetric(vertical: 32, horizontal: 12),
    //                 decoration: BoxDecoration(
    //                   color: Colors.blue[200],
    //                   borderRadius: BorderRadius.only(
    //                     topLeft: Radius.circular(32.0),
    //                     topRight: Radius.circular(32.0),
    //                   ),
    //                 ),
    //                 height: MediaQuery.of(context).size.height ,
    //                 width: MediaQuery.of(context).size.width,
    //                 child: Column(
    //                   mainAxisAlignment: MainAxisAlignment.start,
    //                   children: [
    //                     SizedBox(
    //                       width: 300,
    //                       height: 500,
    //                       child: Column(
    //                         children: [
    //                           Align(
    //                             alignment: Alignment.centerRight,
    //                             child: Text('ID'),
    //                           ),
    //                           SizedBox(
    //                             height: 60,
    //                             child: TextField(
    //                               controller: controller.idController,
    //                               decoration: InputDecoration(
    //                                 hintText: 'Enter your ID',
    //                                 filled: true,
    //                                 fillColor: Colors.white,
    //                                 hintStyle: TextStyle(color: Colors.black54),
    //                                 disabledBorder: OutlineInputBorder(
    //                                     borderSide: BorderSide(color: Colors.black)),
    //                                 enabledBorder: OutlineInputBorder(
    //                                     borderSide: BorderSide(color: Colors.black)),
    //                                 focusedBorder: OutlineInputBorder(
    //                                     borderSide: BorderSide(color: Colors.black)),
    //                                 border: OutlineInputBorder(
    //                                     borderSide: BorderSide(color: Colors.black)),
    //                               ),
    //                             ),
    //                           ),
    //                           SizedBox(height: 10),
    //                           Align(
    //                             alignment: Alignment.centerRight,
    //                             child: Text('Password'),
    //                           ),
    //                           SizedBox(
    //                             height: 60,
    //                             child: TextField(
    //                               controller: controller.passwordController,
    //                               decoration: InputDecoration(
    //                                 filled: true,
    //                                 fillColor: Colors.white,
    //                                 hintText: 'Enter your password',
    //                                 hintStyle: TextStyle(color: Colors.black54),
    //                                 disabledBorder: OutlineInputBorder(
    //                                     borderSide: BorderSide(color: Colors.black)),
    //                                 enabledBorder: OutlineInputBorder(
    //                                     borderSide: BorderSide(color: Colors.black)),
    //                                 focusedBorder: OutlineInputBorder(
    //                                     borderSide: BorderSide(color: Colors.black)),
    //                                 border: OutlineInputBorder(
    //                                     borderSide: BorderSide(color: Colors.black)),
    //                               ),
    //                             ),
    //                           ),
    //                           SizedBox(height: 25),
    //                           ElevatedButton(
    //                               onPressed: () => controller.sendLogin(),
    //                               style: ElevatedButton.styleFrom(
    //                                   backgroundColor: Colors.white,
    //                                   shape: RoundedRectangleBorder(
    //                                     borderRadius: BorderRadius.circular(8.0),
    //                                   ),
    //                                   fixedSize: Size(300, 50),
    //                                   elevation: 6
    //                                   ),
                                      
    //                               child: Text(
    //                                 'Login',
    //                                 style: TextStyle(fontSize: 18, color: Colors.black),
    //                               )),
    //                         ],
    //                       ),
    //                     ),
    //                     SizedBox(height: 20), // Add some space from the bottom
    //                   ],
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}



// commit 2