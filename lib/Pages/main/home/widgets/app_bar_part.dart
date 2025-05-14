import 'package:flutter/material.dart';
import 'package:mas_market/core/theme/app_colors.dart';

AppBar AppBarPart() {
    return AppBar(
      backgroundColor: AppColors.background,
      centerTitle: true,
      actions: [
        SizedBox(width: 25),
        Container(
          height: 45,
          width: 45,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.lightGray,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Image.asset('assets/dash.png'),
        ),
        Spacer(),
        Row(children: [Icon(Icons.location_on_outlined, size: 18),
        SizedBox(width: 5,),Text("Mohammed",style: TextStyle(
          fontSize: 16,
          color: AppColors.textPrimary,
          fontWeight: FontWeight.bold
        ),),
        SizedBox(width: 5,),Icon(Icons.keyboard_arrow_down_rounded,size: 18,color: AppColors.primary,)
        ]),
        Spacer(),Container(
          height: 45,
          width: 45,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.lightGray,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Image.asset('assets/user.png'),
        ),
        SizedBox(width: 25,)
      ],
    );
  }