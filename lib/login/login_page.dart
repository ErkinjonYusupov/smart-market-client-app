import 'package:client_mobile_app/components/my_button.dart';
import 'package:client_mobile_app/exports.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginController controller = Get.put(LoginController());
  var maskFormatter = MaskTextInputFormatter(
      mask: '+998 ## ### ## ##',
      filter: {"#": RegExp(r'[+, 0-9]')},
      type: MaskAutoCompletionType.lazy);
  bool showPasword = true;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (controller) {
      return Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const Spacer(),
                const Text("Up"),
                TextFormField(
                  validator: (value) {
                    return value!.trim().isEmpty
                        ? 'Telefon raqamingizni kiriting'
                        : value.trim().length < 17
                            ? "Telefon raqamni to'liq kiriting"
                            : null;
                  },
                  
                  keyboardType: TextInputType.phone,
                  controller: controller.phone,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600),
                  inputFormatters: [maskFormatter],
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.phone_outlined),
                    hintText: "+998",
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  validator: (value) {
                    return value!.trim().isEmpty
                        ? 'Parolni kiriting'
                        : value.trim().length < 8
                            ? "Parol 8 ta elemantdan tashkil topgan bo'lsishi shart"
                            : null;
                  },
                  obscuringCharacter: '●',
                  obscureText: showPasword,
                  controller: controller.password,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600),
                  decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      focusedErrorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      errorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                    prefixIcon: const Icon(Icons.lock_outline),

                      suffixIcon: IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(
                          showPasword
                              ? Icons.visibility_rounded
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            showPasword = !showPasword;
                          });
                        },
                      ),
                      border: InputBorder.none),
                ),
                const SizedBox(height: 16),
                MyTextButton(
                    buttonName: 'Kirish',
                    onPressed: () {
                      if (formKey.currentState!.validate()) {}
                    }),
                const Spacer(),
              ],
            ),
          ),
        ),
      );
    });
  }
}
