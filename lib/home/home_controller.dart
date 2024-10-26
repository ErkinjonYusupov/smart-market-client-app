import 'package:client_mobile_app/config/database.dart';
import 'package:client_mobile_app/config/my_dio.dart';
import 'package:client_mobile_app/exports.dart';
import 'package:client_mobile_app/home/models/user.dart';

class HomeController extends GetxController {
  bool loading = false;
  var myDio = MyDio().dio();
  MyDb myDb = MyDb();
  GetStorage storage = GetStorage();

  // createOrUpdateUser() async {
  //   try {
  //     await myDb.open();
  //     await myDb.db?.rawInsert(
  //         "insert into user(title,description,taskColor) values (?,?,?)",
  //         [title.text.trim(), desc.text.trim(), myColor.value]);
  //     Get.back();
  //   } catch (err) {
  //     print(err);
  //   } finally {}
  // }

  init() {
    fetchAuth();
    localeUser();
  }

  UserModel? user;
  num totolSumma = 0;

  localeUser() {
    var localUser = storage.read('user');
    if (localUser != null) {
      user = UserModel.fromJson(localUser);
      changeTotalSumme();
    }
  }

  fetchAuth() async {
    try {
      loading = true;
      update();
      await Future.delayed(const Duration(seconds: 1));
      var res = await myDio.get('/customers/auth');
      Get.snackbar("Bajarildi", "Ma'lumotlar yangilandi");
      storage.write('user', res.data);
      storage.write('lastRefreshedTime', DateTime.now().toString());
    } catch (err) {
      print(err);
    } finally {
      loading = false;
      update();
    }
  }

  changeTotalSumme() {
    totolSumma = 0;
    if (user == null) return;
    for (var el in user!.transactions) {
      if (el.type == 'bonus') {
        totolSumma += el.amount;
      } else {
        totolSumma -= el.amount;
      }
    }
  }

  refreshFunction() {
    String? lastRefreshedTime = storage.read('lastRefreshedTime');
     DateTime? parsedDateTime = DateTime.parse(lastRefreshedTime!);
    DateTime now = DateTime.now();
    if (now.difference(parsedDateTime).inMinutes >= 1) {
      init();
      print("refresh amalga oshirildi");
    } else {
      print("Refresh amalga oshirib bo'lmaydi, 1 minutdan kam vaqt o'tdi.");
    }
  }
}
