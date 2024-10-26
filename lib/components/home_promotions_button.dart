import 'package:client_mobile_app/config/colors.dart';
import 'package:client_mobile_app/config/images.dart';
import 'package:client_mobile_app/exports.dart';


class HomePromotionsButton extends StatelessWidget {
  const HomePromotionsButton({super.key, required this.onTap});
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: AppColors.primary, borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Image.asset(
              AppImages.gift,
              width: 80,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 16),
             Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Mening haridlarim".tr,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      color: Colors.white),
                ),
                const SizedBox(height: 5),
                Text(
                  "Bonus va haridlar harakatlarini ko'rish".tr,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: const TextStyle(color: Colors.white),
                )
              ],
            )),
            const Icon(Icons.keyboard_arrow_right_outlined,
                color: Colors.white, size: 32)
          ],
        ),
      ),
    );
  }
}
