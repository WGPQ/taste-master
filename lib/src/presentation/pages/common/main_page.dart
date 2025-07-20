import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:taste_master_app/src/core/constants/colors.dart';
import 'package:taste_master_app/src/presentation/pages/pages.dart';
import 'package:taste_master_app/src/presentation/widgets/widgets.dart';
import 'package:taste_master_app/src/logic/common/navigation_bar_cubit.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: BlocBuilder<NavigationCubit, int>(
        builder: (context, currentTab) {
          return IndexedStack(
            index: currentTab,
            children: const [
              HomePage(),
              TastePage(),
              AboutPage(),
            ],
          );
        },
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
