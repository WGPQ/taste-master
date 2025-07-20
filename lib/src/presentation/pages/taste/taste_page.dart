import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:taste_master_app/src/routes.dart';
import 'package:taste_master_app/src/data/models/models.dart';
import 'package:taste_master_app/src/core/constants/colors.dart';
import 'package:taste_master_app/src/logic/preference_cubit/dog/prefs_dog_cubit.dart';
import 'package:taste_master_app/src/logic/preference_cubit/taste/prefs_taste_cubit.dart';
import 'package:taste_master_app/src/presentation/widgets/taste/add/add_button_taste.dart';
import 'package:taste_master_app/src/presentation/widgets/taste/delete/delete_dialog_taste.dart';

class TastePage extends StatefulWidget {
  const TastePage({super.key});

  @override
  State<TastePage> createState() => _TastePageState();
}

class _TastePageState extends State<TastePage> {
  @override
  void initState() {
    super.initState();
    context.read<PrefsTasteCubit>().fetchTastes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cardBackground,
      appBar: AppBar(
        title: Text('Taste Page',
            style: GoogleFonts.poppins(
              color: AppColors.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )),
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AddButtonTaste(
              size: 45,
              borderRadius: 10,
            ),
          ),
        ],
      ),
      body: BlocBuilder<PrefsTasteCubit, PrefsTasteState>(
        builder: (context, state) {
          final tastes = state.tastes;
          if (state.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (tastes.isEmpty) {
            return Center(
              child: Text(
                'No tastes available',
                style: TextStyle(color: Colors.grey[600], fontSize: 18),
              ),
            );
          }
          return ListView.builder(
            itemCount: tastes.length,
            reverse: true,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final taste = tastes[index];
              return DeleteDialogTaste(
                taste: taste,
                child: itemBuilder(context, taste),
              );
            },
          );
        },
      ),
    );
  }

  Widget itemBuilder(BuildContext context, TasteModel taste) {
    final List<PrefsDogModel>? tasteDogs =
        context.watch<PrefsDogCubit>().state.tasteDogs;

    final int totalDogs =
        tasteDogs?.where((dog) => dog.tasteId == taste.id).toList().length ?? 0;
    return ListTile(
      leading: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: AppColors.primaryButton,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Icon(Icons.pets, color: Colors.white),
      ),
      trailing: Icon(Icons.chevron_right, color: AppColors.textPrimary),
      title: Text(taste.name,
          style: GoogleFonts.poppins(
            color: AppColors.textPrimary,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          )),
      subtitle: Text(
        '$totalDogs dogs',
        style: GoogleFonts.poppins(
          color: Colors.grey[600],
          fontSize: 14,
        ),
      ),
      onTap: () {
        context.read<PrefsDogCubit>().getDogByTaste(taste.id!);
        Navigator.pushNamed(context, AppRoutes.tasteDetails,
            arguments: '${taste.name} ($totalDogs)');
      },
    );
  }
}
