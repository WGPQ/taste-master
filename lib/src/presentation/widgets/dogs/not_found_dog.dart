import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:taste_master_app/src/core/constants/colors.dart';
import 'package:taste_master_app/src/core/constants/assets_resources.dart';

class NotFoundDog extends StatelessWidget {
  const NotFoundDog({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: SvgPicture.asset(
              AssetsResources.dogSad,
              fit: BoxFit.cover,
              height: size.height * 0.2,
            ),
          ),
          Text(
            'No dogs found',
            style: GoogleFonts.poppins(
              color: AppColors.textPrimary,
              fontSize: size.width * 0.05,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
