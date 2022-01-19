import 'package:flutter/material.dart';
import 'package:flutter_hivedb_demo/Home%20Page.dart';
import 'package:flutter_hivedb_demo/Model.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final documentsDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  await Hive.initFlutter(documentsDirectory.path);
  Hive.registerAdapter(InfoModelAdapter());
  await Hive.openBox('Info');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
