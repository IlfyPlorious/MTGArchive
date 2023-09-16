import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:playground/colors.dart';
import 'package:playground/network/ApiService/apiservice.dart';
import 'package:playground/network/ApiService/firestore_service.dart';
import 'package:playground/network/ApiService/scryfall_service.dart';
import 'package:playground/network/repository/api_service_repository.dart';
import 'package:playground/network/repository/firestore_repository.dart';
import 'package:playground/network/requestmodels/cardsrequest.dart';
import 'package:playground/ui/authentication/login.dart';
import 'package:playground/ui/bloc/cards/cards_cubit.dart';
import 'package:playground/ui/main_page.dart';
import 'package:playground/utils/constants.dart';
import 'package:playground/utils/utils.dart';

import 'firebase_options.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseAuth.instanceFor(app: Firebase.app(), persistence: Persistence.LOCAL);
  FirebaseFirestore.instanceFor(app: Firebase.app());

  await setupDependencyInjection();
  runApp(const MyApp());
}

Future<void> setupDependencyInjection() async {
  GetIt.I.registerLazySingleton<ApiServiceRepository>(
      () => ApiServiceRepositoryImpl(
          client: ApiService(Dio()..options.headers = NetworkInfo.headers),
          scryfallClient: ScryfallApiService(
              Dio()..options.headers = NetworkInfo.scryfallHeaders)),
      instanceName: 'ApiRepository');

  GetIt.I.registerLazySingleton<FirestoreServiceRepository>(
      () => FirestoreServiceRepositoryImpl(
          client:
              FirestoreService(firebaseFirestore: FirebaseFirestore.instance)),
      instanceName: 'FirestoreRepository');

  GetIt.I.registerLazySingleton<CardsListCubit>(
      () => CardsListCubit()..initData(CardsRequest()),
      instanceName: 'CardsListCubit');

  GetIt.I.registerLazySingleton<Reference>(() => FirebaseStorage.instance.ref(),
      instanceName: 'FirebaseStorageReference');

  final symbolUtilInstance = MtgSymbolUtil();
  await symbolUtilInstance.initData();
  GetIt.I.registerSingleton<MtgSymbolUtil>(symbolUtilInstance,
      instanceName: 'Symbols list util');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Flutter Playground',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: CustomColors.orange),
          color: CustomColors.blackOlive,
          systemOverlayStyle: SystemUiOverlayStyle(
              systemNavigationBarColor: CustomColors.blackOlive),
        ),
        primarySwatch: Colors.orange,
        primaryColor: CustomColors.orange,
        colorScheme: const ColorScheme(
            brightness: Brightness.light,
            primary: CustomColors.blackOlive,
            onPrimary: CustomColors.orange,
            secondary: CustomColors.darkGray,
            onSecondary: CustomColors.eggshell,
            error: CustomColors.errorRed,
            onError: Colors.white,
            background: CustomColors.eggshell,
            onBackground: CustomColors.blackOlive,
            surface: CustomColors.eggshell,
            onSurface: CustomColors.blackOlive),
        scaffoldBackgroundColor: CustomColors.eggshell,
        textTheme: const TextTheme(
          bodySmall: TextStyle(color: CustomColors.blackOlive),
          bodyMedium: TextStyle(color: CustomColors.blackOlive),
          bodyLarge: TextStyle(color: CustomColors.blackOlive),
          labelSmall: TextStyle(color: CustomColors.orange),
          labelLarge: TextStyle(color: CustomColors.orange),
          labelMedium: TextStyle(color: CustomColors.orange),
        ),
        dialogTheme: const DialogTheme(
          backgroundColor: CustomColors.blackOlive,
          contentTextStyle:
              TextStyle(fontSize: 20, color: CustomColors.eggshell),
          titleTextStyle: TextStyle(fontSize: 30, color: CustomColors.orange),
          surfaceTintColor: CustomColors.orange,
        ),
      ),
      home: const MyHomePage(title: 'Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const LoginPage();
        }
        return const MainPage();
      },
    );
  }
}
