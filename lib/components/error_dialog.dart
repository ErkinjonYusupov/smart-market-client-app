import 'package:client_mobile_app/exports.dart';


class ErrorDialog extends StatelessWidget {
  const ErrorDialog({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: context.theme.cardColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            const Icon(Icons.close_sharp, size: 80, color: Colors.red),
            const SizedBox(height: 20),
            Text(text, textAlign: TextAlign.center),
            const SizedBox(height: 20),
            MyTextButton(
                buttonName: "Yopish",
                onPressed: () {
                  Get.back();
                })
          ],
        ),
      ),
    );
  }
}
