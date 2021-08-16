import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myhivebloc/bloc/my_bloc.dart';
import 'package:myhivebloc/service/simple_api_service.dart';
import 'home_page.dart';

void main() {
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
