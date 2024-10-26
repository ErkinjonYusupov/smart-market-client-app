import 'package:client_mobile_app/exports.dart';
import 'package:client_mobile_app/home/controller/card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController controller = Get.put(HomeController());
  @override
  void initState() {
    controller.refreshFunction();
    controller.localeUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.gray7,
              actions: [
                IconButton(
                    onPressed: () {
                      controller.refreshFunction();
                    },
                    icon: const Icon(
                      Icons.replay_outlined,
                      color: Colors.white,
                    ))
              ],
            ),
            backgroundColor: AppColors.gray7,
            body: Container(
              constraints: const BoxConstraints(maxWidth: 500),
              child: controller.user == null
                  ? const SizedBox()
                  : Column(
                      children: [
                        CardWidget(
                            user: controller.user,
                            summa: controller.totolSumma),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: HomePromotionsButton(
                            onTap: () {
                              Get.to(() => const AllTransactions());
                            },
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: HomePromotionsButton(
                            onTap: () {
                              controller.pagination.current_page = 1;
                              controller.products=[];
                              controller.fetchProductsFromDb();
                              Get.to(() => const Products());
                            },
                          ),
                        ),
                      ],
                    ),
            ));
      },
    );
  }
}
