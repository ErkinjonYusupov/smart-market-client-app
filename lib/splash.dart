import 'dart:async';

import 'package:client_mobile_app/exports.dart';
import 'package:client_mobile_app/on_boarding/onboarding.dart';


class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  void isOnboard() async {
    var onboard = await GetStorage().read('onboard') ?? true;
    var token = await GetStorage().read('token');
    Timer(const Duration(seconds: 2), () async {
      if (onboard) {
        Get.off(() => const OnBoarding());
      } else {
        if (token == null) {
          Get.offAll(() => const LoginPage());
        } else {
          Get.offAll(() => const HomePage());
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    isOnboard();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      SizedBox(height: 50),
      SizedBox(
          width: 30,
          height: 30,
          child: CircularProgressIndicator(color: Colors.blue, strokeWidth: 2)),
    ])));
  }
}
