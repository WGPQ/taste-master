import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:taste_master_app/src/routes.dart';
import 'package:taste_master_app/src/data/models/models.dart';
import 'package:taste_master_app/src/presentation/widgets/widgets.dart';
import 'package:taste_master_app/src/logic/preference_cubit/dog/prefs_dog_cubit.dart';

class TasteDetailsPage extends StatefulWidget {
  final String? title;
  const TasteDetailsPage({super.key, required this.title});

  @override
  State<TasteDetailsPage> createState() => _TasteDetailsPageState();
}

class _TasteDetailsPageState extends State<TasteDetailsPage> {
  void goToDogDetails(ApiDogModel? dog) {
    if (dog != null) {
      context.read<PrefsDogCubit>().selectDog(dog);
      Navigator.pushNamed(context, AppRoutes.dogDetails);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? 'Taste Details',
            style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
      ),
      body: BlocBuilder<PrefsDogCubit, PrefsDogState>(
        builder: (context, state) {
          final tasteDogs = state.dogsByTaste ?? [];
          return ListView.builder(
            itemCount: tasteDogs.length,
            padding: const EdgeInsets.only(top: 8),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final tastedDog = tasteDogs[index];
              return CardDog(
                dog: tastedDog.dog,
                onTap: () => goToDogDetails(tastedDog.dog),
              );
            },
          );
        },
      ),
    );
  }
}
