import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:taste_master_app/src/data/models/models.dart';
import 'package:taste_master_app/src/core/constants/colors.dart';
import 'package:taste_master_app/src/presentation/widgets/modals/base_modal.dart';
import 'package:taste_master_app/src/logic/preference_cubit/dog/prefs_dog_cubit.dart';

class DogDetailsPage extends StatefulWidget {
  const DogDetailsPage({
    super.key,
  });

  @override
  State<DogDetailsPage> createState() => _DogDetailsPageState();
}

class _DogDetailsPageState extends State<DogDetailsPage> {
  bool isLiked = false;

  void onLikeToggle(ApiDogModel dog) {
    if (isLiked) {
      context.read<PrefsDogCubit>().removeDogTaste(dog.id);
      return;
    }
    context.read<PrefsDogCubit>().selectDog(dog);
    ModalHelper.saveDogBottomSheetModal(context: context);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.primaryButton),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: BlocBuilder<PrefsDogCubit, PrefsDogState>(
        builder: (context, state) {
          final ApiDogModel? dog = state.selectedDog;
          isLiked = context.watch<PrefsDogCubit>().isDogLiked(dog?.id ?? 0);
          if (dog == null) {
            return Center(
              child: Text(
                'No dog selected',
                style: TextStyle(color: Colors.grey[600], fontSize: 18),
              ),
            );
          }
          return Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F3F0),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Imagen del perro con corazón
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 300,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        image: DecorationImage(
                          image: NetworkImage(dog.image.url),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 20,
                      right: 20,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () => onLikeToggle(dog),
                          icon: Icon(
                            isLiked ? Icons.favorite : Icons.favorite_border,
                            color: AppColors.accent,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                // Información del perro
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: size.width * 0.6,
                                child: Text(
                                  dog.name,
                                  maxLines: 2,
                                  style: const TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF8B4513),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                dog.breedGroup,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                dog.lifeSpan,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // Dirección
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 20,
                            color: Colors.grey[600],
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              dog.origin,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      Text(
                        dog.temperament,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[700],
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
