import 'package:cat_classifier/cubits/cat_classifier/cat_classifier_cubit.dart';
import 'package:cat_classifier/cubits/image_picker/image_picker_cubit.dart';
import 'package:cat_classifier/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => ImagePickerCubit(),
      ),
      BlocProvider(
        create: (context) => CatClassifierCubit()
          ..loadModel(
            modelPath: 'assets/basemodel.tflite',
            labelsPath: 'assets/labels.txt',
          ),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cat Breed Classifier',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        fontFamily: GoogleFonts.poppins().fontFamily,
        scaffoldBackgroundColor: Colors.white,
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            backgroundColor: Colors.blueGrey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                20,
              ),
            ),
            foregroundColor: Colors.white,
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.white,
            side: const BorderSide(color: Colors.blueGrey, width: 1.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                20,
              ),
            ),
            foregroundColor: Colors.blueGrey,
          ),
        ),
      ),
      home: const MainPage(),
    );
  }
}
