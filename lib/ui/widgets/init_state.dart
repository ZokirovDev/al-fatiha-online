

import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/colors.dart';
import 'get_record_button.dart';

Widget getInitState(Function() onClick){
  return Column(
    children: [
      Text(
        "Qiroatni yozib yuborish uchun quyidagi\ntugmani 1 marta bosing",
        textAlign: TextAlign.center,
        style: GoogleFonts.golosText().copyWith(
            fontSize: 14, fontWeight: FontWeight.w700),
      ),
      SizedBox(
        height: 8,
      ),
      Text(
        "Qiroatni 10dan 120 sekundgacha yuboring",
        textAlign: TextAlign.center,
        style: GoogleFonts.golosText().copyWith(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: descriptionColor),
      ),
      SizedBox(
        height: 18,
      ),
      getMicButton(onClick)
    ],
  );
}