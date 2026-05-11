import 'package:flutter/material.dart';
import 'package:ngoc_hung66131218_flutter_app/sqlite/page_home_sqlite.dart';
import 'package:ngoc_hung66131218_flutter_app/sqlite/provider_data.dart';
import 'package:provider/provider.dart';

class SQLiteAPP extends StatefulWidget {
  const SQLiteAPP({super.key});

  @override
  State<SQLiteAPP> createState() => _SQLiteAPPState();
}

class _SQLiteAPPState extends State<SQLiteAPP> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        var databaseProvider = DatabaseProvider();
        databaseProvider.readUsers();
        return databaseProvider;
      },
      child: MaterialApp(
        title: "SQLite Demo App",
        home: PageListUserSQLite(),
      )
    );
  }
}
