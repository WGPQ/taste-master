import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:taste_master_app/src/routes.dart';
import 'package:taste_master_app/src/core/constants/colors.dart';
import 'package:taste_master_app/src/core/constants/assets_resources.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _goToHome();
  }

  void _goToHome() {
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(AppRoutes.main, (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: SvgPicture.asset(
              AssetsResources.logoDog,
              fit: BoxFit.cover,
              height: size.height * 0.3,
            ),
          ),
          Text(
            'Taste Master App',
            style: GoogleFonts.poppins(
              color: AppColors.textPrimary,
              fontSize: size.width * 0.08,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
