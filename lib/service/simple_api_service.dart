import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:myhivebloc/api/simple_response.dart';

class ApiService{

String url ="https://jsonplaceholder.typicode.com/albums/1";
late Dio _dio;


Future<BlocApi?> processHome() async {
  BaseOptions options =
  BaseOptions(receiveTimeout: 15000, connectTimeout: 15000);
  _dio = Dio(options);

  Response response = await _dio.get(url);
  print(response.statusCode);
  BlocApi blocApi = BlocApi.fromJson(json.decode(response.toString()));
  if( response.statusCode == 200){
    return blocApi;
  }else{
    print("data not loaded");
  }}}
