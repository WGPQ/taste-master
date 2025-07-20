import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taste_master_app/src/core/constants/colors.dart';

import 'package:taste_master_app/src/logic/preference_cubit/dog/prefs_dog_cubit.dart';
import 'package:taste_master_app/src/presentation/widgets/taste/list_title_taste.dart';
import 'package:taste_master_app/src/presentation/widgets/taste/add/add_button_taste.dart';
import 'package:taste_master_app/src/logic/preference_cubit/taste/prefs_taste_cubit.dart';

class ListTasteToSave extends StatefulWidget {
  final ScrollController scrollController;
  const ListTasteToSave({super.key, required this.scrollController});

  @override
  State<ListTasteToSave> createState() => _ListTasteToSaveState();
}

class _ListTasteToSaveState extends State<ListTasteToSave> {
  int selectedIndex = 0;
  String title = 'Save in';

  void onTasteSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          header(),
          Expanded(
            child: SingleChildScrollView(
              controller: widget.scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.all(5.0),
                child: BlocBuilder<PrefsTasteCubit, PrefsTasteState>(
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
                          style:
                              TextStyle(color: Colors.grey[600], fontSize: 18),
                        ),
                      );
                    }
                    return ListView.builder(
                      padding: const EdgeInsets.only(top: 8),
                      itemCount: tastes.length,
                      shrinkWrap: true,
                      reverse: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final taste = tastes[index];
                        return ListTitleTaste(
                          taste: taste,
                          onTap: () {
                            onTasteSelected(index);
                            context
                                .read<PrefsDogCubit>()
                                .saveDogTaste(taste.id!);
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Saved in ${taste.name}'),
                                duration: Duration(seconds: 2),
                                backgroundColor: AppColors.accent,
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget header() {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.only(
        top: 12,
        bottom: 8,
      ),
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                width: size.width * 0.15,
                height: 5,
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const Divider(),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 16.0,
            ),
            child: const Align(
              alignment: Alignment.centerRight,
              child: AddButtonTaste(),
            ),
          ),
        ],
      ),
    );
  }
}
