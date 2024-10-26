import 'package:client_mobile_app/components/list_animation.dart';
import 'package:client_mobile_app/exports.dart';

class Products extends StatefulWidget {
  const Products({super.key});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  HomeController controller = Get.put(HomeController());
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        bool isTop = scrollController.position.pixels == 0;
        if (!isTop &&
            controller.pagination.current_page !=
                controller.pagination.last_page) {
          if (controller.loading) return;
          controller.pagination.current_page =
              (controller.pagination.current_page + 1);
          controller.fetchProductsFromDb();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.gray7,
          appBar: AppBar(
            backgroundColor: AppColors.gray7,
            leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                )),
            title: Text(
              "Mahsulotlar ${controller.pagination.current_page} ${controller.pagination.last_page}",
              style: const TextStyle(color: Colors.white),
            ),
          ),
          body: SingleChildScrollView(
            controller: scrollController,
            child: Container(
              constraints: const BoxConstraints(maxWidth: 500),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...List.generate(controller.products.length, (index) {
                    ProductModel item = controller.products[index];
                    return ListAnimation(
                      index: index,
                      child: ListTile(
                        dense: true,
                        contentPadding: const EdgeInsets.all(2),
                        textColor: Colors.white,
                        title: Text(item.title),
                        subtitle: Text(item.barcode, style: const TextStyle(color: Colors.grey, fontSize: 12),),
                        trailing: Text(formatNumber(item.price), style: const TextStyle(fontWeight: FontWeight.w700),),
                      ),
                    );
                  }),
                  controller.loading
                      ? const Center(
                          child: CircularProgressIndicator(
                          color: Colors.red,
                        ))
                      : const SizedBox(),
                  const SizedBox(height: 80)
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
