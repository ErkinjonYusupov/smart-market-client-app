import 'package:client_mobile_app/exports.dart';

class HomePromotionsButton extends StatelessWidget {
  const HomePromotionsButton(
      {super.key,
      required this.onTap,
      this.title="Mening xaridlarim",
      this.subTitle="Bonus va xaridlar harakatlarini ko'rish",
      this.color = const Color(0xff9D81FF),
      this.image = AppImages.gift});
  final Function()? onTap;

  final Color color;
  final String image;
  final String title;
  final String subTitle;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Image.asset(
              image,
              width: 80,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 16),
             Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      color: Colors.white)
                ),
                const SizedBox(height: 5),
                Text(
                  subTitle,
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
