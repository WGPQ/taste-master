import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:taste_master_app/src/core/constants/colors.dart';
import 'package:taste_master_app/src/data/models/api/dog/api_dog_model.dart';
import 'package:taste_master_app/src/presentation/widgets/dogs/no_image_dog.dart';
import 'package:taste_master_app/src/presentation/widgets/modals/base_modal.dart';
import 'package:taste_master_app/src/logic/preference_cubit/dog/prefs_dog_cubit.dart';

class CardDog extends StatefulWidget {
  final ApiDogModel? dog;
  final VoidCallback? onTap;

  const CardDog({
    super.key,
    required this.dog,
    this.onTap,
  });

  @override
  State<CardDog> createState() => _DogCardState();
}

class _DogCardState extends State<CardDog> {
  bool isLiked = false;

  ApiDogModel? get dog => widget.dog;

  void onLikeToggle() {
    if (dog == null) return;
    if (isLiked) {
      context.read<PrefsDogCubit>().removeDogTaste(dog!.id);
      return;
    }
    context.read<PrefsDogCubit>().selectDog(dog!);
    ModalHelper.saveDogBottomSheetModal(context: context);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    isLiked = context.watch<PrefsDogCubit>().isDogLiked(dog?.id);
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: Stack(
            children: [
              Row(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: NetworkImage(dog?.image.url ?? ''),
                        fit: BoxFit.cover,
                        onError: (exception, stackTrace) => const NoImageDog(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: size.width * 0.5,
                          child: Text(
                            dog?.name ?? 'Unknown',
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF8B4513),
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          dog?.breedGroup ?? 'Unknown',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          dog?.lifeSpan ?? 'Unknown',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                top: -5,
                right: 0,
                child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => onLikeToggle(),
                    icon: Icon(
                      isLiked ? Icons.favorite : Icons.favorite_border,
                      color: AppColors.accent,
                      size: 24,
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
