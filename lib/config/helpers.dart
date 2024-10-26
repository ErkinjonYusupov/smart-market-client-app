 import 'package:string_mask/string_mask.dart';

class Mask{
   var formatter = StringMask('00 000 00 00');
   phone(String val){
    return formatter.apply(val.replaceAll('+', ''));
   }
}

String formatNumber(num number) {
  if (number == 0) return '0'; // 0 uchun maxsus ko'rinish
  bool isNegative = number < 0; // Raqam manfiy ekanligini tekshiramiz

  number = number.abs(); // Raqamni musbatga aylantiramiz
  String result = '';
  int digit = 1; // Raqamlar orasiga bo'sh joy qo'shish uchun hisoblagich

  while (number > 0) {
    if (digit > 1 && digit % 3 == 1) {
      result = '${number % 10} $result';
    } else {
      result = (number % 10).toString() + result;
    }
    digit++;
    number = number ~/ 10; // Raqamni 10 ga bo'lib, keyingi raqamni tekshiramiz
  }

  if (isNegative) {
    result = '-$result'; // Agar raqam manfiy bo'lsa, minus belgisini qo'shamiz
  }

  return result;
}
