import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:myhivebloc/bloc/my_bloc.dart';
import 'package:myhivebloc/service/simple_api_service.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'api/simple_response.dart';
import 'home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ///Getting directory of this app
  var directory = await pathProvider.getApplicationDocumentsDirectory();

  /// To Store Data in Internal memory using Hive
  Hive..init(directory.path)
    ..registerAdapter(BlocApiAdapter());
  await Hive.openBox("mybox");

  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(create: (context) => ResponseBloc(ApiService()),
        child: BlocBuilder<ResponseBloc, MyApiState>(
          builder: (_,state)=> HomePage(),
        ),
        )

    );
  }
}

/*
class HiveKeys {
  HiveKeys._();
  static const String addResponse = 'AddResponse';
}
class HiveData{
  late final Box box;
  HiveData(Box box);
  void addResponseDetails(BlocApi blocApi){
    box.put("AddResponse", blocApi);
  }
}*/
