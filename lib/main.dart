import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:provider/provider.dart';

import './home_page.dart';
import '../providers/data_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: DataProvider(),
        ),
      ],
      child: Consumer<DataProvider>(
        builder: (ctx, dataProvider, _) => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: ('Sample App'),
          theme: ThemeData(
            primarySwatch: Colors.blueGrey,
          ),
          home: HomePage(),
        ),
      ),
    );
  }
}
