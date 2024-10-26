import 'package:client_mobile_app/config/my_dio.dart';
import 'package:client_mobile_app/exports.dart';

class LoginController extends GetxController{
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  bool loading=false;
  var myDio = MyDio().dio();
  GetStorage storage = GetStorage();

  login()async{
    if(loading)return;
    try{
      loading=true;
      update();
      await Future.delayed(const Duration(seconds: 1));
      var res = await myDio.post('/customers/token', data: {
        "phone":phone.text.replaceAll(' ', '').substring(4,13),
        "password":password.text,
        "client_secret":"erick"
      });
      storage.write('token', res.data['token']);
      Get.off(()=>const HomePage());
    }catch(err){
      print(err);
    }finally{
      loading=false;
      update();
    }
  }
}