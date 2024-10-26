import 'package:client_mobile_app/exports.dart';
import 'package:client_mobile_app/on_boarding/controller.dart';


class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  OnBoardingController controller = Get.put(OnBoardingController());
  late PageController pageController;
  int pageIndex = 0;

  @override
  void initState() {
    pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                  itemCount: controller.data.length,
                  controller: pageController,
                  onPageChanged: (index) {
                    setState(() {
                      pageIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    var item = controller.data[index];
                    return OnboardContent(
                        image: item.image,
                        title: item.title,
                        description: item.description);
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(
                    controller.data.length,
                    (index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: DotIndicator(isActive: index == pageIndex),
                        )),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: MyTextButton(
                buttonName: pageIndex == controller.data.length - 1
                    ? 'getStart'.tr
                    : 'next'.tr,
                onPressed: () {
                  pageIndex == controller.data.length - 1
                      ? controller.onBoardHome()
                      : pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease,
                        );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class OnboardContent extends StatelessWidget {
  const OnboardContent({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });
  final String image, title, description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                image,
                scale: 5,
              ),
              Text(
                title,
                style: context.textTheme.titleLarge
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 300,
                child: Text(
                  description,
                  style: context.textTheme.labelLarge?.copyWith(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    super.key,
    this.isActive = false,
  });

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 12,
      width: 12,
      decoration: BoxDecoration(
        color: isActive
            ? context.theme.colorScheme.secondary
            : context.theme.colorScheme.secondaryContainer,
        shape: BoxShape.circle,
      ),
    );
  }
}
