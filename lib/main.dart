import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:membuat_berita/blocs/newsbloc/news_bloc.dart';
import 'package:membuat_berita/blocs/newsbloc/news_states.dart';
import 'package:membuat_berita/repositories/news_repository.dart';
import 'package:membuat_berita/views/splash_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NewsBloc>(
          create: (context) => NewsBloc(
              initialState: NewsInitState(),
              newsRepositotiy: NewsRepositoriy()),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            textTheme: GoogleFonts.poppinsTextTheme(
              Theme.of(context).textTheme,
            )),
        home: SplashScreen(),
      ),
    );
  }
}
