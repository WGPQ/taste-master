import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:taste_master_app/src/routes.dart';
import 'package:taste_master_app/src/data/models/models.dart';
import 'package:taste_master_app/src/core/constants/colors.dart';
import 'package:taste_master_app/src/core/constants/hive_models.dart';
import 'package:taste_master_app/src/logic/api_cubit/dog/api_dog_cubit.dart';
import 'package:taste_master_app/src/logic/common/navigation_bar_cubit.dart';
import 'package:taste_master_app/src/data/repositories/dogs/dogs_repository.dart';
import 'package:taste_master_app/src/data/models/api/dog/api_image_dog_model.dart';
import 'package:taste_master_app/src/logic/preference_cubit/dog/prefs_dog_cubit.dart';
import 'package:taste_master_app/src/logic/preference_cubit/taste/prefs_taste_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await Hive.initFlutter();
  Hive.registerAdapter(TasteModelAdapter());
  Hive.registerAdapter(PrefsDogModelAdapter());
  Hive.registerAdapter(ApiDogModelAdapter());
  Hive.registerAdapter(ApiImageDogModelAdapter());
  await Hive.openBox<TasteModel>(HiveModelsConstants.tasteBox);
  await Hive.openBox<PrefsDogModel>(HiveModelsConstants.tasteDogBox);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) => DogsRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => NavigationCubit(),
          ),
          BlocProvider(
            create: (_) => PrefsDogCubit(
              Hive.box<PrefsDogModel>(HiveModelsConstants.tasteDogBox),
            )..fetchDogTastes(),
          ),
          BlocProvider(
            create: (context) => PrefsTasteCubit(
              tasteBox: Hive.box<TasteModel>(HiveModelsConstants.tasteBox),
            ),
          ),
          BlocProvider(
            create: (context) => ApiDogCubit(
              RepositoryProvider.of<DogsRepository>(context),
            )..fetchDogs(),
          ),
        ],
        child: MaterialApp(
          title: 'Taste Master App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primaryColor: AppColors.textPrimary,
              textTheme: GoogleFonts.openSansTextTheme(
                Theme.of(context).textTheme,
              )),
          initialRoute: AppRoutes.splash,
          onGenerateRoute: AppRoutes.generateRoute,
        ),
      ),
    );
  }
}
