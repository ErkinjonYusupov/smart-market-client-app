import 'package:client_mobile_app/config/images.dart';
import 'package:client_mobile_app/exports.dart';
import 'package:client_mobile_app/on_boarding/model.dart';


class OnBoardingController extends GetxController{
  final List<Onboard> data = [
  Onboard(
      image: AppImages.todo,
      title: 'title1'.tr,
      description: 'subtitle1'.tr),
  Onboard(
      image: AppImages.category,
      title: 'title2'.tr,
      description: 'subtitle2'.tr),
  Onboard(
      image: AppImages.calendar,
      title: 'title3'.tr,
      description: 'subtitle3'.tr),
];
void onBoardHome() async{
    await GetStorage().write('onboard', false);
    Get.off(() => const HomePage(), transition: Transition.downToUp);
  }
}