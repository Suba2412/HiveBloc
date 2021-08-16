import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myhivebloc/api/simple_response.dart';
import 'package:myhivebloc/service/simple_api_service.dart';


class ResponseBloc extends Bloc<MyApiEvent, MyApiState> {

ApiService apiService = ApiService();

  ResponseBloc(this.apiService) : super(InitialState());

  @override
  Stream<MyApiState> mapEventToState(MyApiEvent event) async*{
    if(event is MyApiEvent){
       try{
         yield Loading();
         BlocApi? blocApiModel= await apiService.processHome();
         if(blocApiModel!.id != null){
           print("my response ********* $blocApiModel");
           yield Loaded(blocApiModel);
         }
       }catch(e) {
         print("Something went wrong");
       }
    }
  }
/*
// Api service
  String url ="https://jsonplaceholder.typicode.com/albums/1";
  late Dio _dio;
  BlocApi? blocApi;

  Future<BlocApi?> fetchApi() async {
    try {
      Response response = await _dio.get(url);
      print(response.statusCode);
      BlocApi blocApi = BlocApi.fromJson(json.decode(response.toString()));
      return blocApi;
    } catch (e) {
      print(e);
    }
    return blocApi;
  }

 */

}




//bloc state

abstract class MyApiState extends Equatable {
  const MyApiState();
}

class InitialState extends MyApiState {
  const InitialState();

  @override
  List<Object> get props => [];
}

class Loading extends MyApiState {
  const Loading();

  @override
  List<Object> get props => [];
}

class Loaded extends MyApiState {
  final BlocApi? blocApiModel;
  const Loaded(this.blocApiModel);

  @override
  List<Object> get props => [this.blocApiModel!];
}

class Error extends MyApiState {
  final String error;
  const Error(this.error);

  @override
  List<Object> get props => [this.error];
}




//bloc event
abstract class MyApiEvent extends Equatable {
const MyApiEvent();
}

class ResponseEvent extends MyApiEvent {
const ResponseEvent();

@override
List<Object> get props => [];
}




