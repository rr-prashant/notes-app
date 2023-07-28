import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes_app/models/data_func.dart';
import 'package:provider/provider.dart';

import 'Homepage.dart';

void main() async {
  await Hive.initFlutter(); //intializing hive

  await Hive.openBox('notes'); // open hive box from hive_database.dart file
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NoteData(),
      builder: ((context, child) => const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Homepage(),
          )),
    );
  }
}
