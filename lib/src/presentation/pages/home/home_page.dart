import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:taste_master_app/src/routes.dart';
import 'package:taste_master_app/src/data/models/models.dart';
import 'package:taste_master_app/src/core/constants/colors.dart';
import 'package:taste_master_app/src/presentation/widgets/widgets.dart';
import 'package:taste_master_app/src/logic/api_cubit/dog/api_dog_cubit.dart';
import 'package:taste_master_app/src/presentation/widgets/dogs/skeleton_dogs.dart';
import 'package:taste_master_app/src/presentation/widgets/dogs/not_found_dog.dart';
import 'package:taste_master_app/src/logic/preference_cubit/dog/prefs_dog_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    bool isLoadingMore = context.read<ApiDogCubit>().state.isLoadingMore;
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !isLoadingMore) {
      context.read<ApiDogCubit>().fetchDogs();
    }
  }

  void goToDogDetails(ApiDogModel dog) {
    context.read<PrefsDogCubit>().selectDog(dog);
    Navigator.pushNamed(context, AppRoutes.dogDetails);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SearchDogs(),
            Expanded(
              child: BlocBuilder<ApiDogCubit, ApiDogState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return SkeletonDogs();
                  }
                  final dogs = state.filterResults ?? [];
                  if (dogs.isEmpty) {
                    return NotFoundDog();
                  }
                  return RefreshIndicator(
                    color: AppColors.accent,
                    onRefresh: () async {
                      context.read<ApiDogCubit>().fetchDogs(refresh: true);
                    },
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: dogs.length,
                      padding: const EdgeInsets.only(top: 8),
                      itemBuilder: (context, index) {
                        final dog = dogs[index];
                        return CardDog(
                          dog: dog,
                          onTap: () => goToDogDetails(dog),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
