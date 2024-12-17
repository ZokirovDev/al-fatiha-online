import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/colors.dart';
AppBar getCustomAppbar(String title,Function() onBackClick){
  return AppBar(
    forceMaterialTransparency: true,
    surfaceTintColor: Colors.transparent,
    backgroundColor: backgroundColor,
    automaticallyImplyLeading: false,
    centerTitle: true,
    title: Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Stack(
        children: [
          IconButton(
              onPressed: () {onBackClick();},
              icon: Icon(
                Icons.arrow_back_ios_new_outlined,
                size: 14,
              )),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Center(
                child: Text(
                  title,
                  style: GoogleFonts.golosText().copyWith(
                      color: primaryTextColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                )),
          )
        ],
      ),
    ),
  );
}