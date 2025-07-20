import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:taste_master_app/src/core/constants/colors.dart';
import 'package:taste_master_app/src/core/constants/assets_resources.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundPrimary,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: SvgPicture.asset(
                AssetsResources.logoDog,
                fit: BoxFit.cover,
                height: size.height * 0.3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Built with ❤️ by William Puma',
                style: GoogleFonts.poppins(
                  color: AppColors.textPrimary,
                  fontSize: size.width * 0.04,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Taste Master is your go-to app for discovering and saving your favorite dog breeds. '
                'Explore a wide variety of breeds, learn about their characteristics, and save your favorites for easy access.',
                textAlign: TextAlign.justify,
                style: GoogleFonts.poppins(
                  color: AppColors.textPrimary,
                  fontSize: size.width * 0.04,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
