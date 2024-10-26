import 'package:client_mobile_app/exports.dart';


class AllTransactions extends StatefulWidget {
  const AllTransactions({super.key});

  @override
  State<AllTransactions> createState() => _AllTransactionsState();
}

class _AllTransactionsState extends State<AllTransactions> {
  HomeController controller = Get.put(HomeController());
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
            title: const Text(
              "Xaridlarim",
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 500),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...List.generate(controller.user!.transactions.length,
                      (index) {
                    TransactionsModel item =
                        controller.user!.transactions[index];
                    return Container(
                      padding: const EdgeInsets.all(10),
                      width: double.maxFinite,
                      margin: const EdgeInsets.only(bottom: 5),
                      decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(7)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomListTile(
                              title: "Xodim FIO", subTitle: item.user),
                          CustomListTile(
                              title: "Xarid turi", subTitle: item.type=='debt'?"Qarz":"Bonus"),
                          CustomListTile(
                              title: "Amal bajarilgan sana", subTitle: formatDateTime(item.createdAt)),
                              item.repaymentDate==null?const SizedBox():
                          CustomListTile(
                              title: "Qarzni to'lash sanasi", subTitle: item.repaymentDate!),
                          CustomListTile(
                              title: "Summa", subTitle: "${formatNumber(item.amount)} so'm" , textColor: item.type=='debt'?Colors.red.shade800:Colors.green.shade800,),
                        ],
                      ),
                    );
                  })
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.subTitle,
    required this.title,
    this.textColor=Colors.white
  });

  final String title;
  final String subTitle;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Color.fromARGB(255, 235, 235, 235),
            fontSize: 12,
          ),
        ),
        Text(
          subTitle,
          style:
               TextStyle(color: textColor, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
