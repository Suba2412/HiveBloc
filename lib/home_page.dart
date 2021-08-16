import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'api/simple_response.dart';
import 'bloc/my_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();

}
class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ResponseBloc>(context).add(ResponseEvent());

  }
  BlocApi? blocApiModel;
  @override
  Widget build(BuildContext context) {
    //BlocProvider.of<ResponseBloc>(context).add(ResponseEvent());

    Widget myContent(MyApiState state){
      if(blocApiModel==null){
        return Container();
      }else
      return ListView.builder(
          itemBuilder: (BuildContext context, int index){
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(blocApiModel!.id.toString()),
                  SizedBox(
                    height: 5,
                  ),
                  Text(blocApiModel!.userId.toString()),
                  SizedBox(
                    height: 5 ,
                  ),
                  Text(blocApiModel!.title.toString()),
                  Divider(color: Colors.green,height: 2,thickness: 2,),
                  SizedBox(
                    height:10 ,
                  ),
                ],
              ),
            );
          }
      );
    }
    return BlocConsumer<ResponseBloc, MyApiState>(
      builder: (context, state){
      return Scaffold(
        body: SafeArea(child:
        (state is Loading)? Center(child: CircularProgressIndicator()) :
        (state is Loaded) ? myContent(state) :
        (state is Error) ? Center(child: Text(state.error)) :Container()
        ),

        //how to cretee a hive adapter using terminal
      );
    },
      listener: (context, state) {
        print("${state.toString()} Syed");
        if(state is Loaded){
          blocApiModel = state.blocApiModel!;
        }
      },
    );
  }
}
