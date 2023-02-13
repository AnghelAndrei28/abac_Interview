import 'package:flutter/material.dart';
import 'package:interview/Pages/History/Service/HistoryProvider.dart';
import 'package:interview/Pages/HomePageScreen.dart';
import 'package:interview/Pages/Services/RouterService.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: HistoryProvider(),)
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(

          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: RouterService.generateRoute,
        initialRoute: HomePageScreen.route,
      ),
    );
  }
}
