
import 'package:client_mobile_app/config/colors.dart';
import 'package:client_mobile_app/config/helpers.dart';
import 'package:client_mobile_app/home/models/user.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({super.key, required this.user, required this.summa});
  final UserModel? user;
  final num summa;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      child: Stack(
        
        children: [
          Container(
            width: double.maxFinite,
            padding: const EdgeInsets.all(16),
      
            decoration: BoxDecoration(
              image: const DecorationImage(image: AssetImage('assets/images/card1.jpg'), fit: BoxFit.cover),
                 borderRadius: BorderRadius.circular(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user!.fullName,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white)),
                Text("+998 ${Mask().phone(user!.phone)}",
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500)),
                        Text.rich(TextSpan(
                        style:  TextStyle(
                            color:summa<0?Colors.red: Colors.white, fontWeight: FontWeight.w800),
                        children: [
                          TextSpan(
                            text: formatNumber(summa),
                            style: const TextStyle(fontSize: 24),
                          ),
                          const TextSpan(
                              text: " so'm", style: TextStyle(fontSize: 16))
                        ])),
                        const SizedBox(height: 8),
                    const Text(
                      "ELEKTRON KASHALOK RAQAMI",
                      style: TextStyle(
                          color: Colors.white, fontSize: 10, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      formatNumber(int.parse(user!.code)),
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w700, fontSize: 14),
                    ),
                    SizedBox(
                        height: 30,
                        child: SfBarcodeGenerator(
                          value: user!.code,
                          barColor: Colors.white,
                        )),
              ],
            ),
          ),
           Positioned(right: 100, top: -10, child: Cubic(width: 50, opocity: .4)),
           Positioned(right: 60, top: 35, child: Cubic(width: 35, opocity: .6)),
           Positioned(
              right: 30,
              bottom: 40,
              child: Cubic(
                width: 70,
                opocity: .2,
              )),
           Positioned(
              right: 70,
              top: 0,
              child: Cubic(
                width: 70,
                opocity: .2,
              )),
           Positioned(right: -50, top: 50, child: Cubic(width: 100, opocity: .7,)),
          Positioned(right: -30, top: 28, child: BorderCubic(width: 120)),
          Positioned(right: 60, top: 0, child: BorderCubic(width: 100)),
        ],
      ),
    );
  }
}
class Cubic extends StatelessWidget {
  Cubic({super.key, required this.width, this.opocity = 1});
  double width;
  double opocity;

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: const AlwaysStoppedAnimation(15 / 120),
      child: Container(
        width: width,
        height: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.primary.withOpacity(opocity)),
      ),
    );
  }
}

class BorderCubic extends StatelessWidget {
  BorderCubic({super.key, required this.width, this.opocity = 1});
  double width;
  double opocity;

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: const AlwaysStoppedAnimation(15 / 120),
      child: Container(
        width: width,
        height: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.primary.withOpacity(opocity)),
        ),
      ),
    );
  }
}